/*
	description: "Include file for printing an Eiffel object."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_out_h_
#define _eif_out_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_portable.h"
#include "eif_cecil.h"		/* %%zs added for EIF_OBJECT definition line 26... */
#include "eif_interp.h"		/* %%zs added for 'EIF_TYPED_VALUE' definition line 48 */

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Function declarations 
 */

RT_LNK EIF_REFERENCE  c_generator_of_type(EIF_TYPE ftype); /* Called by `generator' from ANY */
#define c_generator(obj)	c_generator_of_type (eif_object_type(obj))

RT_LNK EIF_REFERENCE c_tagged_out(EIF_REFERENCE object);			/* Called by `tagged_out' from ANY */
RT_LNK char *eif_out(EIF_REFERENCE object);		/* Build the output of an EIF_REFERENCE */
extern char *build_out(EIF_REFERENCE object);		/* Build tagged out in C buffer */

/*
 * Building `out' string for simple types.
 */

RT_LNK EIF_REFERENCE c_outu(EIF_NATURAL_32 i);
RT_LNK EIF_REFERENCE c_outu64(EIF_NATURAL_64 i);
RT_LNK EIF_REFERENCE c_outi(EIF_INTEGER i);
RT_LNK EIF_REFERENCE c_outi64(EIF_INTEGER_64 i);
RT_LNK EIF_REFERENCE c_outr32(EIF_REAL_32 f);
RT_LNK EIF_REFERENCE c_outr64(EIF_REAL_64 d);
RT_LNK EIF_REFERENCE c_outc(EIF_CHARACTER_8 c);
RT_LNK EIF_REFERENCE c_outp(EIF_POINTER p);

#ifdef __cplusplus
}
#endif

#endif
