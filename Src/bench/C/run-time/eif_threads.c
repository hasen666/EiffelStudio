/*

 ######    #    ######
 #         #    #
 #####     #    #####
 #         #    #
 #         #    #
 ######    #    #      #######

 #####  #    #  #####   ######    ##    #####    ####           ####
   #    #    #  #    #  #        #  #   #    #  #              #    #
   #    ######  #    #  #####   #    #  #    #   ####          #
   #    #    #  #####   #       ######  #    #       #   ###   #
   #    #    #  #   #   #       #    #  #    #  #    #   ###   #    #
   #    #    #  #    #  ######  #    #  #####    ####    ###    ####

	Thread management routines.

*/

/*
doc:<file name="eif_thread.c" header="eif_thread.h" version="$Id$" summary="Thread management routines">
*/

#include "eif_portable.h"
#include "eif_eiffel.h"
#include "rt_threads.h"
#include "rt_lmalloc.h"
#include "rt_globals.h"
#include "rt_err_msg.h"
#include "eif_sig.h"
#include "rt_garcol.h"
#include "rt_malloc.h"
#include "rt_macros.h"
#include "rt_types.h"
#include "rt_interp.h"
#include "rt_assert.h"
#include "rt_retrieve.h"
#include "rt_run_idr.h"
#include "rt_store.h"
#include "rt_except.h"
#include "rt_memory.h"
#include "rt_option.h"

#include <string.h>


#ifdef EIF_THREADS

/*---------------------------------------*/
/*---  In multi-threaded environment  ---*/
/*---------------------------------------*/

rt_public void eif_thr_panic(char *);
rt_public void eif_thr_init_root(void);
rt_public void eif_thr_register(void);
rt_public unsigned int eif_thr_is_initialized(void);
rt_public void eif_thr_create(EIF_OBJECT, EIF_POINTER);
rt_public void eif_thr_create_with_args(EIF_OBJECT, EIF_POINTER, EIF_INTEGER,
										EIF_INTEGER, EIF_BOOLEAN);
rt_public void eif_thr_exit(void);

rt_public EIF_POINTER eif_thr_mutex_create(void);
rt_public void eif_thr_mutex_lock(EIF_POINTER);
rt_public void eif_thr_mutex_unlock(EIF_POINTER);
rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER);
rt_public void eif_thr_mutex_destroy(EIF_POINTER);

rt_private rt_global_context_t *eif_new_context (void);
rt_private EIF_THR_ENTRY_TYPE eif_thr_entry(EIF_THR_ENTRY_ARG_TYPE);

	/* To update GC with thread specific data */
rt_private void eif_destroy_gc_stacks(rt_global_context_t *);
rt_private void eif_init_gc_stacks(rt_global_context_t *);
rt_private void load_stack_in_gc (struct stack_list *, void *);
rt_private void remove_stack_from_gc (struct stack_list *, void *);
rt_private void eif_stack_free (void *stack);

/*
doc:	<attribute name="eif_global_key" return_type="EIF_TSD_TYPE" export="public">
doc:		<summary>Key used to access per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_public EIF_TSD_TYPE eif_global_key;

/*
doc:	<attribute name="rt_global_key" return_type="EIF_TSD_TYPE" export="shared">
doc:		<summary>Key used to access private per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_shared EIF_TSD_TYPE rt_global_key;

/*
doc:	<attribute name="eif_thread_launch_mutex" return_type="EIF_LW_MUTEX_TYPE *" export="private">
doc:		<summary>Mutex used to protect launching of a thread.</summary>
doc:		<thread_safety>Safe, initialized once in `eif_thr_root_init'.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Mutex is not freed.</fixme>
doc:	</attribute>
*/
rt_private EIF_LW_MUTEX_TYPE *eif_thread_launch_mutex = NULL;

/*
doc:	<attribute name="eif_is_gc_collecting" return_type="int" export="public">
doc:		<summary>Is GC currently performing a collection?</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public int volatile eif_is_gc_collecting = 0;

#ifdef EIF_WIN32
/*
doc:	<attribute name="yield_address" return_type="FARPROC" export="private">
doc:		<summary>Address of `yield' routine for Windows. Only implemented on Windows NT and above.</summary>
doc:		<thread_safety>Save, initialized once in `eif_thr_root_init'.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_private FARPROC yield_address = NULL;
#endif

/*
doc:	<attribute name="rt_globals_list" return_type="struct stack_list" export="private">
doc:		<summary>Used to store all per thread data of all running threads.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private struct stack_list rt_globals_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* rt_globals_list */
};

#define LAUNCH_MUTEX_LOCK	\
	EIF_LW_MUTEX_LOCK(eif_thread_launch_mutex, "Cannot lock mutex for the thread launcher\n")
#define LAUNCH_MUTEX_UNLOCK \
	EIF_LW_MUTEX_UNLOCK(eif_thread_launch_mutex, "Cannot unlock mutex for the thread launcher\n"); 

rt_public void eif_thr_init_root(void) 
{
	/*
	 * This function must be called once and only once at the very beginning
	 * of an Eiffel program (typically from main()) or the first time a thread
	 * initializes the Eiffel run-time if it is part of a Cecil system.
	 * The global key for Thread Specific Data is initialized: this variable
	 * is shared by all the threads, but it allows them to fetch a pointer
	 * to their own context (eif_globals structure).
	 */

	EIF_TSD_CREATE(eif_global_key,"Couldn't create global key for root thread");
	EIF_TSD_CREATE(rt_global_key,"Couldn't create private global key for root thread");
#ifdef ISE_GC
	EIF_LW_MUTEX_CREATE(eif_gc_mutex, "Couldn't create GC mutex");
	EIF_LW_MUTEX_CREATE(eif_gc_set_mutex, "Couldn't create GC set mutex");
	EIF_LW_MUTEX_CREATE(eif_gc_gsz_mutex, "Couldn't create GSZ mutex");
#endif
	EIF_LW_MUTEX_CREATE(eif_thread_launch_mutex, "Cannot create mutex for thread launcher\n");
	EIF_LW_MUTEX_CREATE(eif_except_lock, "Couldn't create exception lock");
	EIF_LW_MUTEX_CREATE(eif_memory_mutex, "Couldn't create memory mutex");
	EIF_LW_MUTEX_CREATE(eif_trace_mutex, "Couldn't create tracemutex");
	EIF_MUTEX_CREATE(eif_global_once_mutex, "Couldn't create global once mutex");
	eif_thr_register();
#ifdef EIF_WIN32
	{
		HMODULE kernel_module = LoadLibrary("kernel32.dll");
		yield_address = GetProcAddress (kernel_module, "SwitchToThread");
	}
#endif
}

rt_public void eif_thr_register(void)
{
	/*
	 * Allocates memory for the rt_globals structure, initializes it
	 * and makes it part of the Thread Specific Data (TSD).
	 * Allocates memory for onces (for non-root threads)
	 */

	static int not_root_thread = 0;	/* For initial eif_thread, we don't know how
							 		 * many once values we have to allocate */

	rt_global_context_t *rt_globals = eif_new_context();

	if (not_root_thread) {
		EIF_GET_CONTEXT
	  /*
	   * Allocate room for once values for all threads but the initial 
	   * because we do not have the number of onces yet
	   * Also set value root thread id.
	   */

		EIF_once_values = (EIF_REFERENCE *) eif_realloc (EIF_once_values, EIF_once_count * REFSIZ);
			/* needs malloc; crashes otherwise on some pure C-ansi compiler (SGI)*/
		if (EIF_once_values == (EIF_REFERENCE *) 0) /* Out of memory */
			enomem();
		memset ((EIF_REFERENCE) EIF_once_values, 0, EIF_once_count * REFSIZ);
	} else 
	{
		not_root_thread = 1;
		eif_cecil_init ();				/* Initialize ressources for cecil. */
		eif_thr_id = (EIF_THR_TYPE *) 0;	/* Null by convention in root */
	}
}

rt_public EIF_BOOLEAN eif_thr_is_root()
{
	/*
	 * Returns True is the calling thread is the Eiffel root thread,
	 * False otherwise.
	 */

	RT_GET_CONTEXT
	return (eif_thr_context ? EIF_FALSE : EIF_TRUE);
}

rt_public unsigned int eif_thr_is_initialized()
{
	/*
	 * Returns a non null value if the calling thread is initialized for
	 * Eiffel, null otherwise.
	 */

#ifndef VXWORKS
	eif_global_context_t *x;
#endif

#ifdef EIF_WIN32
	/* On windows, GetLastError() yields NO_ERROR if such key was initialized */
	EIF_TSD_GET0 ((eif_global_context_t *),eif_global_key,x);
	return (GetLastError() == NO_ERROR);

#elif defined VXWORKS
	/* On VXWORKS, eif_global_key holds a pointer to eif_globals. If the
	 thread isn't initialized, eif_global_key == 0 */
	return (eif_global_key != (EIF_TSD_TYPE) 0);

#elif defined EIF_POSIX_THREADS
#ifdef EIF_NONPOSIX_TSD
	return (EIF_TSD_GET0((void *),eif_global_key,x) == 0); /* FIXME.. not sure */
#else /* EIF_NONPOSIX_TSD */
	return (EIF_TSD_GET0(0,eif_global_key,x) != 0);
#endif

#elif defined SOLARIS_THREADS
	return (EIF_TSD_GET0((void *),eif_global_key,x) == 0);
#endif
}

rt_private rt_global_context_t *eif_new_context (void)
{
	/*
	 * Create rt_globals and eif_globals structure and initializes some of their fields
	 * fields.
	 */
	rt_global_context_t *rt_globals;
	eif_global_context_t *eif_globals;

		/* Create and initialize private context */
	rt_globals = (rt_global_context_t *) eif_malloc(sizeof(rt_global_context_t));
	if (!rt_globals) {
		eif_thr_panic("No more memory for thread context");
	}
	memset (rt_globals, 0, sizeof(rt_global_context_t));
	EIF_TSD_SET(rt_global_key, rt_globals, "Couldn't bind private context to TSD.");

		/* Create and initialize public context */
	eif_globals = (eif_global_context_t *) eif_malloc(sizeof(eif_global_context_t));
	if (!eif_globals) {
		eif_thr_panic("No more memory for thread context");
	}
	memset (eif_globals, 0, sizeof(eif_global_context_t));
	EIF_TSD_SET(eif_global_key, eif_globals, "Couldn't bind public context to TSD.");

		/* Private context has always a reference to public one to avoid 
		 * calls to get thread specific data. */
	rt_globals->eif_globals = eif_globals;

		/* Initialize per thread data. It is done in the module which uses them */

		/* except.c */
	eif_except_thread_init ();

		/* retrieve.c */
	eif_retrieve_thread_init ();

		/* run_idr.c */
	eif_run_idr_thread_init ();

		/* store.c */
	eif_store_thread_init ();

	eif_init_gc_stacks(rt_globals);

	return rt_globals;
}


rt_public void eif_thr_create (EIF_OBJECT thr_root_obj, EIF_POINTER init_func)
{
	/*
	 * Creates a new Eiffel thread. This function is only called from
	 * Eiffel and is given three arguments: 
	 * - the object (whose class inherits from THREAD) a clone of which
	 *   will become the root object of the new thread
	 * - the Eiffel routine it will execute
	 *
	 * These arguments are part of the routine context that will be
	 * passed to the new thread via the low-level platform-dependant
	 * thread-creation function.
	 *
	 * This context also contains a pointer to the thread-id of the new
	 * thread, a pointer to the parent's children-counter `n_children', a
	 * mutex and a condition variable that are used by eif_thr_join_all()
	 * and eif_thr_exit()  --PCV
	 */

	eif_thr_create_with_args (thr_root_obj, init_func,
							  (EIF_INTEGER) -1, /* Priority: not used */
							  (EIF_INTEGER) -1, /* Policy: not used */
							  (EIF_BOOLEAN) 5); /* -> Don't use args */
}


rt_public void eif_thr_create_with_args (EIF_OBJECT thr_root_obj, 
										 EIF_POINTER init_func,
										 EIF_INTEGER priority,
										 EIF_INTEGER policy,
										 EIF_BOOLEAN detach)
{
	/*
	 * This function is the same as eif_thr_create() but makes it possible
	 * to set the thread priority, scheduling policy and detached_state
	 * (when allowed by the current architecture) upon creation.--PCV
	 */

	RT_GET_CONTEXT

	start_routine_ctxt_t *routine_ctxt;
	EIF_THR_TYPE *tid = (EIF_THR_TYPE *) eif_malloc (sizeof (EIF_THR_TYPE));

	routine_ctxt = (start_routine_ctxt_t *)eif_malloc(sizeof(start_routine_ctxt_t));
	if (!routine_ctxt)
		eif_thr_panic("No more memory to launch new thread\n");
	routine_ctxt->current = eif_adopt (thr_root_obj);
	routine_ctxt->routine = init_func;
	routine_ctxt->tid = tid;
	routine_ctxt->addr_n_children = &n_children;

	if (!eif_children_mutex) {
		/* It is the first time this thread creates a subthread (hopefully!), so
		* we create a mutex and a condition variable for join and join_all */
		EIF_MUTEX_CREATE(eif_children_mutex, "Couldn't create join mutex");
#ifndef EIF_NO_CONDVAR
		eif_children_cond = (EIF_COND_TYPE *) eif_malloc (sizeof (EIF_COND_TYPE));
		EIF_COND_INIT(eif_children_cond, "Couldn't initialize cond. variable");
#endif /* EIF_NO_CONDVAR */
	}
	routine_ctxt->children_mutex = eif_children_mutex;
#ifndef EIF_NO_CONDVAR
	routine_ctxt->children_cond = eif_children_cond;
#endif /* EIF_NO_CONDVAR */
	EIF_MUTEX_LOCK(eif_children_mutex, "Couldn't lock children mutex");
	n_children ++;	
	EIF_MUTEX_UNLOCK(eif_children_mutex, "Couldn't unlock children mutex");
	LAUNCH_MUTEX_LOCK;
	if (detach != (EIF_BOOLEAN) 5) {
#ifndef EIF_WIN32
		EIF_THR_ATTR_TYPE attr;
#endif
		EIF_THR_ATTR_INIT(attr,priority,policy,detach);
		EIF_THR_CREATE_WITH_ATTR(eif_thr_entry, routine_ctxt, *tid, attr,
								 "Cannot create thread\n");
		EIF_THR_ATTR_DESTROY(attr);
	} else { /* We're called from eif_thr_create */
		EIF_THR_CREATE(eif_thr_entry, routine_ctxt, *tid, "Cannot create thread\n");
	}
	LAUNCH_MUTEX_UNLOCK;
	last_child = tid;
}

rt_private EIF_THR_ENTRY_TYPE eif_thr_entry (EIF_THR_ENTRY_ARG_TYPE arg)
{
	/*
	 * This function is a wrapper to the Eiffel routine that will be
	 * executed by the new thread. It is directly called upon creation
	 * of the thread, and initializes the Eiffel run-time.
	 * Also, it initializes the eif_thr_id, for the overhead of
	 * the Eiffel objects allocated in this thread.
	 */

	start_routine_ctxt_t *routine_ctxt = (start_routine_ctxt_t *)arg;
	eif_thr_register();
		/* To prevent current thread to return too soon after call
		 * to EIF_THR_CREATE or EIF_THR_CREATE_WITH_ATTR.
		 * That way `tid' is properly initialized and can be freed
		 * safely later on */
	LAUNCH_MUTEX_LOCK;
	LAUNCH_MUTEX_UNLOCK;
	{
		RT_GET_CONTEXT
		EIF_GET_CONTEXT

		struct ex_vect *exvect;
		jmp_buf exenv;
		EIF_PROCEDURE execute = (EIF_PROCEDURE) routine_ctxt->routine;

		eif_thr_context = routine_ctxt;
		eif_thr_id = routine_ctxt->tid;	/* Initialize here the thread_id */
		initsig();
		initstk();
		if (egc_prof_enabled)
			initprf();
		exvect = new_exset((char *) 0, 0, (char *) 0, 0, 0, 0);
		exvect->ex_jbuf = &exenv;

#ifdef _CRAY
		if (setjmp(exenv))
			failure();
#else
		if ((echval = setjmp(exenv)))
			failure();
#endif

#ifdef WORKBENCH
		xinitint();
#endif

			/* Call the `execute' routine of the thread */
		(FUNCTION_CAST(void,(EIF_REFERENCE)) execute)(eif_access(routine_ctxt->current));

		exok();
	}
	eif_thr_exit ();
#if (!defined SOLARIS_THREADS && !defined EIF_WIN32)
	return (EIF_THR_ENTRY_TYPE) 0;	/* 	NOTREACHED. */
#else
	/* On solaris, EIF_ENTRY_TYPE is void: there is no Null void. */
	return;
#endif
}


rt_public void eif_thr_exit(void)
{
	/*
	 * Function called to terminate a thread launched by Eiffel with
	 * eif_thr_create() or eif_thr_create_with_args().
	 * All the memory allocated with eif_malloc() for the thread context is freed
	 * This function must be called from the thread itself (not the parent).
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT

	int destroy_mutex = 0; /* If non null, we'll destroy the 'join' mutex */

		/* We need to keep a reference to the children mutex, 
		 * the children condition variable and parent's thread number
		 * of children after freeing ressources */
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *l_chld_cond = eif_thr_context->children_cond; 
#endif /* EIF_NO_CONDVAR */
	EIF_MUTEX_TYPE *l_chld_mutex = eif_thr_context->children_mutex;
	int *l_addr_n_children = eif_thr_context->addr_n_children;
	
	int ret;	/* Return Status of "eifaddr_offset". */
	EIF_INTEGER offset;	/* Location of `terminated' in `eif_thr_context->current' */
	EIF_REFERENCE thread_object = NULL;

	exitprf();

	RT_GC_PROTECT(thread_object);
	thread_object = eif_access(eif_thr_context->current);
	eif_wean(eif_thr_context->current);
	offset = eifaddr_offset (thread_object, "terminated", &ret);
	CHECK("terminated attribute exists", ret == EIF_CECIL_OK);

#ifdef ISE_GC
	gc_thread_status = EIF_THREAD_BLOCKED;
#endif
	EIF_MUTEX_LOCK(l_chld_mutex, "Lock parent mutex");

		/* Set the `terminated' field of the twin thread object to True so that
		 * it knows the thread is terminated */
	*(EIF_BOOLEAN *) (thread_object + offset) = EIF_TRUE;
	RT_GC_WEAN(thread_object);


	/* 
	 * Every thread that has created a child thread with eif_thr_create() or
	 * eif_thr_create_with_args() has created a mutex and a condition 
	 * variable to be able to do a join_all (or a join). If no children are
	 * still alive, we destroy eif_children_mutex and eif_children_cond.
	 * If children are still alive, it is better not to remove the mutex
	 * because it would cause a crash upon their termination. If it is the
	 * case, no join_all has been called, which is a bit dangerous--PCV
	 */

	if (eif_children_mutex) {
		EIF_MUTEX_LOCK (eif_children_mutex, "Locking problem in reclaim()");
		if (!n_children) destroy_mutex = 1; /* No children are alive */
		EIF_MUTEX_UNLOCK (eif_children_mutex, "Unlocking problem in reclaim()");
	}

	if (destroy_mutex) {
	  EIF_MUTEX_DESTROY(eif_children_mutex, "Couldn't destroy join mutex.");
	  eif_children_mutex = NULL;
#ifndef EIF_NO_CONDVAR
	  EIF_COND_DESTROY(eif_children_cond, "Couldn't destroy join cond. var");
	  eif_children_cond = NULL;
#endif
	}

		/* Clean GC of non-used data that were used to hold objects */
	eif_destroy_gc_stacks(rt_globals);

	if (eif_thr_is_root ())	{	/* Is this the root thread */
		eif_cecil_reclaim ();
		eif_free (rt_globals);			
		eif_free (eif_globals);			
						/* Global variables specific to the current thread */
		CHECK("Is root", !eif_thr_context);
#ifdef LMALLOC_CHECK
		eif_lm_display ();
		eif_lm_free ();
#endif	/* LMALLOC_CHECK */
	} else {
		eif_free (eif_thr_context->tid); /* Free id of the current thread */
		eif_free (eif_thr_context);		/* Thread context passed by parent */
		eif_free (rt_globals);			
		eif_free (eif_globals);			
						/* Global variables specific to the current thread */
	}

#ifdef VXWORKS
	/* The TSD is managed in a different way under VxWorks: each thread
	 * must call taskVarAdd upon initialization and taskVarDelete upon
	 * termination.  It was impossible to call taskVarDelete using the same
	 * model as on other platforms unless creating a new macro that would
	 * be useful only for VxWorks. It is easier to do the following:
	 */


	if (taskVarDelete(0,(int *)&(eif_global_key))) 
	  eif_thr_panic("Problem with taskVarDelete\n");
	if (taskVarDelete(0,(int *)&(rt_global_key))) 
	  eif_thr_panic("Problem with taskVarDelete\n");
#endif	/* VXWORKS */

		/* Decrement the number of child threads of the parent */
	*l_addr_n_children -= 1;

#ifndef EIF_NO_CONDVAR
	EIF_COND_BROADCAST(l_chld_cond, "Pbl cond_broadcast");
#endif
	EIF_MUTEX_UNLOCK(l_chld_mutex, "Unlock parent mutex");


	EIF_THR_EXIT(0);
}	/* eif_thr_exit ().*/


/**************************************************************************/
/* NAME: eif_init_gc_stacks                                               */
/* ARGS: rt_globals: References to thread specific data                   */
/*------------------------------------------------------------------------*/
/* Initialize shared global stacks with thread specific stack. That way   */
/* the GC holds references to Eiffel objects in each thread               */
/**************************************************************************/

rt_private void eif_init_gc_stacks(rt_global_context_t *rt_globals)
{
#ifdef ISE_GC
	eif_global_context_t *eif_globals = rt_globals->eif_globals;
	eif_synchronize_gc(rt_globals);
	load_stack_in_gc (&rt_globals_list, rt_globals);
	load_stack_in_gc (&loc_stack_list, &loc_stack);	
	load_stack_in_gc (&loc_set_list, &loc_set);	
	load_stack_in_gc (&once_set_list, &once_set);	
	load_stack_in_gc (&hec_stack_list, &hec_stack);	
	load_stack_in_gc (&hec_saved_list, &hec_saved);	
	load_stack_in_gc (&eif_stack_list, &eif_stack);	
	load_stack_in_gc (&eif_trace_list, &eif_trace);
#ifdef WORKBENCH
	load_stack_in_gc (&opstack_list, &op_stack);
#endif
	eif_unsynchronize_gc(rt_globals);
#endif
}


/**************************************************************************/
/* NAME: eif_destroy_gc_stacks                                            */
/* ARGS: rt_globals: References to thread specific data                   */
/*------------------------------------------------------------------------*/
/* Destroy thread specific stacks and remove them from GC global stack    */
/**************************************************************************/

rt_private void eif_destroy_gc_stacks(rt_global_context_t *rt_globals)
{
#ifdef ISE_GC
	eif_global_context_t *eif_globals = rt_globals->eif_globals;
	eif_synchronize_gc(rt_globals);
	remove_stack_from_gc (&rt_globals_list, rt_globals);
	remove_stack_from_gc (&loc_stack_list, &loc_stack);
	remove_stack_from_gc (&loc_set_list, &loc_set);	
	remove_stack_from_gc (&once_set_list, &once_set);	
	remove_stack_from_gc (&hec_stack_list, &hec_stack);	
	remove_stack_from_gc (&hec_saved_list, &hec_saved);	
	remove_stack_from_gc (&eif_stack_list, &eif_stack);	
	remove_stack_from_gc (&eif_trace_list, &eif_trace);
#ifdef WORKBENCH
	remove_stack_from_gc (&opstack_list, &op_stack);
#endif
	eif_stack_free (&free_stack);
	eif_unsynchronize_gc(rt_globals);
#endif
}


/**************************************************************************/
/* NAME: load_stack_in_gc                                                 */
/* ARGS: st_list: Global GC stack                                         */
/*       st: thread specific stack that we are putting in `st_list'.      */
/*------------------------------------------------------------------------*/
/* Insert `st' in `st_list->threads_stack' and update `st_list'.          */
/**************************************************************************/

rt_private void load_stack_in_gc (struct stack_list *st_list, void *st)
{
	int count = st_list->count + 1;
	st_list->count = count;
	if (st_list->capacity < st_list->count) {
		st_list->threads.data = (void **) eif_realloc (st_list->threads.data,
															count * sizeof(struct stack **));
		st_list->capacity = count;
	}
	st_list->threads.data[count - 1] = st;
}


/**************************************************************************/
/* NAME: remove_stack_from_gc                                             */
/* ARGS: st_list: Global GC stack                                         */
/*       st: thread specific stack that should be in `st_list'.           */
/*------------------------------------------------------------------------*/
/* Remove `st' from `st_list->threads_stack' and update `st_list'         */
/* accordingly.                                                           */
/**************************************************************************/

rt_private void remove_stack_from_gc (struct stack_list *st_list, void *st)
{
	int count = st_list->count;
	int i = 0;
	void **stack = st_list->threads.data;

	REQUIRE("Stack not empty", count > 0);

		/* Linear search to find `st' in `threads_stack' */
	while (i < count) {
		if (stack[i] == st)
			break;
		i = i + 1;
	}

	CHECK("Is found", i < count);	/* We must have found entry that holds reference to `st' */

		/* Free memory used by `st'. */
	eif_stack_free (st);

		/* Remove one element */
	st_list->count = count - 1;
	stack [i] = stack [count -1];
	stack [count - 1] = NULL;
}

/**************************************************************************/
/* NAME: eif_stack_free                                                   */
/* ARGS: st: thread specific stack.                                       */
/*------------------------------------------------------------------------*/
/* Free memory used by `st'.                                              */
/**************************************************************************/

rt_private void eif_stack_free (void *stack){
	struct stack *st = (struct stack *) stack;
	struct stchunk *c, *cn;

	for (c = st->st_hd; c != (struct stchunk *) 0; c = cn) {
		cn = c->sk_next;
		eif_rt_xfree ((EIF_REFERENCE) c);
	}

	st->st_hd = NULL;
	st->st_tl = NULL;
	st->st_cur = NULL;
	st->st_top = NULL;
	st->st_end = NULL;
}

#ifdef ISE_GC
rt_public void eif_synchronize_for_gc ()
	/* Synchronize current thread for a GC cycle */
{
	RT_GET_CONTEXT

		/* Simple synchronization, if a GC cycle was performed, then
		 * we will lock on `gc_mutex' only if current thread is not the
		 * one performing the GC cycle, otherwise we could cause dead-lock.
		 * This is needed when a GC cycle trigger calls to `dispose' routines.
		 */
	if (gc_thread_status != EIF_THREAD_GC_RUNNING) {
		gc_thread_status = EIF_THREAD_SUSPENDED;
		EIF_GC_MUTEX_LOCK;
		gc_thread_status = EIF_THREAD_RUNNING;
		EIF_GC_MUTEX_UNLOCK;
	}
}

rt_public void eif_enter_eiffel_code()
	/* Synchronize current thread as we enter some Eiffel code */
{
	RT_GET_CONTEXT
	gc_thread_status = EIF_THREAD_RUNNING;
}

rt_public void eif_exit_eiffel_code()
	/* Synchronize current thread as we exit some Eiffel code */
{
	RT_GET_CONTEXT
	gc_thread_status = EIF_THREAD_BLOCKED;
}

#ifdef DEBUG
rt_private int counter = 0;
#endif

#ifdef EIF_ASSERTIONS
/*
doc:	<routine name="eif_is_synchronized" return_type="int" export="shared">
doc:		<summary>Check if all threads are in a paused state, so that GC can safely be performed.</summary>
doc:		<return_value>1 when synchronized, 0 otherwise</return_value>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>To be done while already pocessing the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_shared int eif_is_synchronized (void)
{
	int i;

	for (i = 0; i < rt_globals_list.count; i ++) {
		if (((rt_global_context_t *) (rt_globals_list.threads.data [i]))->gc_thread_status_cx ==
			EIF_THREAD_RUNNING) {
			return 0;
#ifdef DEBUG
		} else {
			printf ("Status is %d\n", ((rt_global_context_t *) (rt_globals_list.threads.data [i]))->gc_thread_status_cx);
#endif
		}
	}
	return 1;
}
#endif

rt_shared void eif_synchronize_gc (rt_global_context_t *rt_globals)
	/* Synchronize all threads under GC control */
{
	if (gc_thread_status != EIF_THREAD_GC_RUNNING) {
		struct stack_list all_thread_list;
		struct stack_list running_thread_list = {0, 0, { NULL }};
		rt_global_context_t *thread_globals;
		int status, i;

			/* We are marking ourself to show that we are requesting a safe access
			 * to GC data. */
		gc_thread_status = EIF_THREAD_GC_REQUESTED;
		EIF_GC_MUTEX_LOCK;
#ifdef DEBUG
		printf ("Starting Collection number %d ...", counter);
#endif
		eif_is_gc_collecting = 1;
		gc_thread_collection_count = 1;
		gc_thread_status = EIF_THREAD_GC_RUNNING;

			/* We have acquired the lock, now, process all running threads and wait until
			 * they are all not marked `EIF_THREAD_RUNNING'. */
		memcpy(&all_thread_list, &rt_globals_list, sizeof(struct stack_list));
		all_thread_list.threads.data = eif_malloc (rt_globals_list.count * sizeof(void *));
		memcpy(all_thread_list.threads.data, rt_globals_list.threads.data,
			rt_globals_list.count * sizeof(void *));

		while (all_thread_list.count != 0) {
			for (i = 0; i < all_thread_list.count; i++) {
				thread_globals = (rt_global_context_t *) all_thread_list.threads.data[i];
				if (thread_globals != rt_globals) {
					status = thread_globals->gc_thread_status_cx;
					if (status == EIF_THREAD_RUNNING) {
						load_stack_in_gc (&running_thread_list, thread_globals);
					}
				}
			}
			eif_free (all_thread_list.threads.data);
			memcpy(&all_thread_list, &running_thread_list, sizeof(struct stack_list));
			memset(&running_thread_list, 0, sizeof(struct stack_list));

				/* For performance reasons on systems with a poor scheduling policy, 
				 * we switch context to one of the remaining running thread. Not doing
				 * so on a uniprocessor WinXP system, the execution was about 1000 times
				 * slower than on a bi-processor WinXP system. */
			EIF_THR_YIELD;
		}
#ifdef DEBUG
		printf ("Synchronized...");
#endif
	} else {
			/* A recursive demand was made, we simply increment the blocking counter.
			 * No synchronization is required as we are still under the protection
			 * of `eif_gc_mutex'. */
		gc_thread_collection_count++;	
#ifdef DEBUG
		printf ("+");
#endif
	}

	ENSURE("Synchronized", eif_is_synchronized());
}

rt_shared void eif_unsynchronize_gc (rt_global_context_t *rt_globals)
	/* Free all threads under GC control from GC control */
{
	gc_thread_collection_count--;

	if (gc_thread_collection_count == 0) {
#ifdef DEBUG
		printf ("... finishing %d\n", counter);
		counter++;
#endif
			/* Here we have still the lock of `gc_mutex'. So it is safe to update
			 * `eif_is_gc_collecting'. */
		eif_is_gc_collecting = 0;

			/* Let's mark ourself as a running thread. */
		gc_thread_status = EIF_THREAD_RUNNING;

			/* Because recursive calls can be made to `eif_synchronize_gc' we
			 * have to unlock the `eif_gc_mutex' mutex only at the last call
			 * to `eif_unsynchronize_gc'. */
		EIF_GC_MUTEX_UNLOCK;
	} else {
#ifdef DEBUG
		printf ("-");
#endif
	}
}
#endif

rt_public void eif_thr_yield(void)
{
	/*
	 * Yields execution to other threads. Platform dependant, sometimes
	 * undefined.
	 */

	EIF_THR_YIELD;
}


#ifdef EIF_NO_JOIN_ALL
rt_public void eif_thr_join_all(void)
{
	/*
	 * With Solaris threads, it is possible to wait for the termination of the
	 * first thread, so we can implement a simpler join_all mechanism 
	 */

	EIF_THR_JOIN_ALL;
}
#else
rt_public void eif_thr_join_all(void)
{
	/*
	 * Our implementation of join_all: the parent thread keeps a record of the
	 * number of threads it has launched, and the children have a pointer to
	 * this variable (n_children). So they decrement it upon termination. This
	 * variable is protected by the mutex eif_children_mutex.
	 * This function loops until the value of n_children is equal to zero. In
	 * order not to use all the CPU, we yield the execution to other threads
	 * if there are still more children.
	 * NB: this function might be very costly in CPU if the yield function
	 * doesn't work. --PCV
	 */

	RT_GET_CONTEXT

#ifdef EIF_NO_CONDVAR
	int end = 0;
#endif

	/* If no thread has been launched, the mutex isn't initialized */
	if (!eif_children_mutex) return;

#ifdef EIF_NO_CONDVAR
	EIF_THR_YIELD;
	while (!end) {
		EIF_MUTEX_LOCK(eif_children_mutex, "Failed lock mutex join_all");
		if (n_children) {
			EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join_all");
			EIF_THR_YIELD;
		} else {
			end = 1;
			EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join_all");
		}
	}
#else
	EIF_MUTEX_LOCK(eif_children_mutex, "Failed lock mutex join_all");
	while (n_children)
		EIF_COND_WAIT(eif_children_cond, eif_children_mutex, "pb wait");
	EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join_all");
#endif
}
#endif

rt_public void eif_thr_wait (EIF_OBJECT Current)
{
	/*
	 * Waits until a thread sets `terminated' from `Current' to True, which means it
	 * is terminated. This function is called by `join'. The calling
	 * thread must be the direct parent of the thread, or the function
	 * might loop indefinitely --PCV
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT

#ifdef EIF_NO_CONDVAR
	int end = 0;
#endif
	int ret;	/* Return Status of "eifaddr". */
	EIF_INTEGER offset;	/* location of `terminated' in Current */
	EIF_REFERENCE thread_object = NULL;

		/* We need to protect thread_object, because the protected
		 * reference `eif_access (Current)' will be cleaned when
		 * Current thread exit. */
	RT_GC_PROTECT(thread_object);
	thread_object = eif_access(Current);
	offset = eifaddr_offset (thread_object, "terminated", &ret);
	CHECK("terminated attribute exists", ret == EIF_CECIL_OK);

	/* If no thread has been launched, the mutex isn't initialized */
	if (!eif_children_mutex) return;

#ifdef EIF_NO_CONDVAR
	/* This version is for platforms that don't support condition
	 * variables. If the platform doesn't support yield() either, this
	 * function can use much of the CPU time.
	 */

	EIF_THR_YIELD;
	while (!end) {
		EIF_MUTEX_LOCK(eif_children_mutex, "Failed lock mutex join()");
		if (*(EIF_BOOLEAN *) (thread_object + offset) == EIF_FALSE) {
			EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join()");
			EIF_THR_YIELD;
		} else {
			end = 1;
			EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join()");
		}
	}
#else

	/* This version is for platforms that support condition variables, like
	 * the platforms supporting POSIX threads, Solaris and Vxworks (if
	 * properly configured, ie compiled with POSIX_SCHED).
	 */

	EIF_MUTEX_LOCK(eif_children_mutex, "Failed lock mutex join()");
	while (*(EIF_BOOLEAN *) (thread_object + offset) == EIF_FALSE)
		EIF_COND_WAIT(eif_children_cond, eif_children_mutex, "pb wait");
	EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join()");

#endif
	RT_GC_WEAN(thread_object);
}

rt_public void eif_thr_join (EIF_POINTER tid)
{
	/*
	 * Invokes thr_join, pthread_join, etc.. depending on the platform.
	 * No such routine exists on VxWorks or Windows, so the Eiffel version
	 * should be used (ie. `join' <-> eif_thr_wait)
	 */

	if (tid != (EIF_POINTER) 0) {
		EIF_THR_JOIN(* (EIF_THR_TYPE *) tid);
	} else {
		eraise ("Trying to join a thread whose ID is NULL", EN_EXT);
	}
}


/*
 * These three functions are used from Eiffel: they return the default,
 * minimum and maximum priority values for the current platform --PCV
 */

rt_public EIF_INTEGER eif_thr_default_priority(void) {
	return EIF_DEFAULT_PRIORITY;
}

rt_public EIF_INTEGER eif_thr_min_priority(void) {
	return EIF_MIN_PRIORITY;
}

rt_public EIF_INTEGER eif_thr_max_priority(void) {
	return EIF_MAX_PRIORITY;
}

/*
 * These two functions each return a pointer to respectively the thread-id
 * of the current thread and the thread-id of the last created thread.
 * They are used from the class THREAD.--PCV
 */

rt_public EIF_POINTER eif_thr_thread_id(void) {
	RT_GET_CONTEXT
	if (eif_thr_context) {
		return (EIF_POINTER) eif_thr_context->tid;
	} else
		return (EIF_POINTER) 0; /* Root thread's id is 0 */
}

rt_public EIF_POINTER eif_thr_last_thread(void) {
	RT_GET_CONTEXT
	return (EIF_POINTER) last_child;
}


/*
 * Functions for mutex management:
 *	- creation, locking, unlocking, non-blocking locking and destruction
 */
 
rt_public EIF_POINTER eif_thr_mutex_create(void) {
	EIF_MUTEX_TYPE *a_mutex_pointer;

	EIF_MUTEX_CREATE(a_mutex_pointer, "cannot create mutex\n");
	return (EIF_POINTER) a_mutex_pointer;
}

rt_public void eif_thr_mutex_lock(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_LOCK(a_mutex_pointer, "cannot lock mutex\n");
	} else 
		eraise("Trying to lock a NULL mutex", EN_EXT);
}

rt_public void eif_thr_mutex_unlock(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_UNLOCK(a_mutex_pointer, "cannot unlock mutex\n");
	} else
		eraise("Trying to unlock a NULL mutex", EN_EXT);
}

rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER mutex_pointer) {
	int status = 0;
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_TRYLOCK(a_mutex_pointer, status, "cannot trylock mutex\n");
	} else
		eraise("Trying to lock a NULL mutex", EN_EXT);
	return ((EIF_BOOLEAN)(!status));
}

rt_public void eif_thr_mutex_destroy(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;

	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_DESTROY(a_mutex_pointer, "cannot destroy mutex\n");
		a_mutex_pointer = (EIF_MUTEX_TYPE *) 0;
	}
}


/*
 * class SEMAPHORE externals
 */

rt_public EIF_POINTER eif_thr_sem_create (EIF_INTEGER count)
{
#ifndef EIF_NO_SEM
	EIF_SEM_TYPE *a_sem_pointer;

	EIF_SEM_CREATE(a_sem_pointer, count, "cannot create semaphore\n");
	return (EIF_POINTER) a_sem_pointer;
#else
	return (EIF_POINTER) 0;
#endif
}

rt_public void eif_thr_sem_wait (EIF_POINTER sem)
{
#ifndef EIF_NO_SEM
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	if (a_sem_pointer != (EIF_SEM_TYPE *) 0) {
		EIF_SEM_WAIT(a_sem_pointer, "cannot lock semaphore");
	} else 
		eraise("Trying to lock a NULL semaphore", EN_EXT);
#endif
}

rt_public void eif_thr_sem_post (EIF_POINTER sem)
{
#ifndef EIF_NO_SEM
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	if (a_sem_pointer != (EIF_SEM_TYPE *) 0) {
		EIF_SEM_POST(a_sem_pointer, "cannot post semaphore");
	} else 
		eraise("Trying to post a NULL semaphore", EN_EXT);
#endif
}

rt_public EIF_BOOLEAN eif_thr_sem_trywait (EIF_POINTER sem)
{
#ifndef EIF_NO_SEM
	int status = 0;
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	if (a_sem_pointer != (EIF_SEM_TYPE *) 0) {
		EIF_SEM_TRYWAIT(a_sem_pointer, status, "cannot trywait semaphore\n");
	} else
		eraise("Trying to trywait a NULL semaphore", EN_EXT);
	return ((EIF_BOOLEAN)(!status));
#else
	return EIF_FALSE;	/* Not implemented. */
#endif
}

rt_public void eif_thr_sem_destroy (EIF_POINTER sem)
{
#ifndef EIF_NO_SEM
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	if (a_sem_pointer != (EIF_SEM_TYPE *) 0) {
		EIF_SEM_DESTROY(a_sem_pointer, "cannot destroy semaphore");
		a_sem_pointer = (EIF_SEM_TYPE *) 0;
	}
#endif
}

/*
 * class CONDITION_VARIABLE externals
 */

rt_public EIF_POINTER eif_thr_cond_create (void)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond;

	EIF_COND_CREATE(cond, "cannot create cond. variable");
	return (EIF_POINTER) cond;
#else
	return (EIF_POINTER) 0;
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_broadcast (EIF_POINTER cond_ptr)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;

	if (cond != (EIF_COND_TYPE *) 0) {
		EIF_COND_BROADCAST(cond, "cannot cond_broadcast");
	} else
		eraise ("Trying to cond_broadcast on NULL", EN_EXT);
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_signal (EIF_POINTER cond_ptr)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;

	if (cond != (EIF_COND_TYPE *) 0) {
		EIF_COND_SIGNAL(cond, "cannot cond_signal");
	} else
		eraise ("Trying to cond_signal on NULL", EN_EXT);
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_wait (EIF_POINTER cond_ptr, EIF_POINTER mutex_ptr)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	EIF_MUTEX_TYPE *mutex = (EIF_MUTEX_TYPE *) mutex_ptr;

	if (cond != (EIF_COND_TYPE *) 0) {
		EIF_COND_WAIT(cond, mutex, "cannot cond_wait");
	} else
		eraise ("Trying to cond_wait on NULL", EN_EXT);
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_wait_with_timeout (EIF_POINTER cond_ptr, EIF_POINTER mutex_ptr, EIF_INTEGER a_timeout)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	EIF_MUTEX_TYPE *mutex = (EIF_MUTEX_TYPE *) mutex_ptr;

	if (cond != (EIF_COND_TYPE *) 0) {
		EIF_COND_WAIT_WITH_TIMEOUT(cond, mutex, a_timeout, "cannot cond_wait with timeout");
	} else
		eraise ("Trying to cond_wait_with_timeout on NULL", EN_EXT);
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_destroy (EIF_POINTER cond_ptr)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	EIF_COND_DESTROY(cond, "destroying condition variable");
#endif /* EIF_NO_CONDVAR */
}


rt_public void eif_thr_panic(char *msg)
{
	print_err_msg (stderr, "*** Thread panic! ***\n");
	eif_panic(msg);
	exit(0);
}

#endif /* EIF_THREADS */
/*
doc:</file>
*/
