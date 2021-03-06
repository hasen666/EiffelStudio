note
	description: "Implemented `IPersistMemory' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IPERSIST_MEMORY_IMPL_PROXY

inherit
	IPERSIST_MEMORY_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_ipersist_memory_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID)
			-- No description available.
			-- `p_class_id' [out].  
		do
			ccom_get_class_id (initializer, p_class_id.item)
		end

	is_dirty
			-- No description available.
		do
			ccom_is_dirty (initializer)
		end

	load (p_mem: CHARACTER_REF; cb_size: INTEGER)
			-- No description available.
			-- `p_mem' [in].  
			-- `cb_size' [in].  
		do
			ccom_load (initializer, p_mem, cb_size)
		end

	save (p_mem: CHARACTER_REF; f_clear_dirty: INTEGER; cb_size: INTEGER)
			-- No description available.
			-- `p_mem' [out].  
			-- `f_clear_dirty' [in].  
			-- `cb_size' [in].  
		do
			ccom_save (initializer, p_mem, f_clear_dirty, cb_size)
		end

	get_size_max (pcb_size: INTEGER_REF)
			-- No description available.
			-- `pcb_size' [out].  
		do
			ccom_get_size_max (initializer, pcb_size)
		end

	init_new
			-- No description available.
		do
			ccom_init_new (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_ipersist_memory_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_class_id (cpp_obj: POINTER; p_class_id: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"](GUID *)"
		end

	ccom_is_dirty (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"]()"
		end

	ccom_load (cpp_obj: POINTER; p_mem: CHARACTER_REF; cb_size: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_save (cpp_obj: POINTER; p_mem: CHARACTER_REF; f_clear_dirty: INTEGER; cb_size: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER,EIF_INTEGER)"
		end

	ccom_get_size_max (cpp_obj: POINTER; pcb_size: INTEGER_REF)
			-- No description available.
		external
			"C++ [ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_init_new (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"]()"
		end

	ccom_delete_ipersist_memory_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"]()"
		end

	ccom_create_ipersist_memory_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IPersistMemory_impl_proxy %"ecom_control_library_IPersistMemory_impl_proxy_s.h%"]():EIF_POINTER"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IPERSIST_MEMORY_IMPL_PROXY

