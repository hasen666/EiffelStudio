/*
indexing
description: "WEL: library of reusable components for Windows."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef __WEL_TOOLINFO__
#define __WEL_TOOLINFO__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_toolinfo_set_cbsize(_ptr_, _value_) (((TOOLINFO *) _ptr_)->cbSize = (UINT) (_value_))
#define cwel_toolinfo_set_uflags(_ptr_, _value_) (((TOOLINFO *) _ptr_)->uFlags = (UINT) (_value_))
#define cwel_toolinfo_set_hwnd(_ptr_, _value_) (((TOOLINFO *) _ptr_)->hwnd = (HWND) (_value_))
#define cwel_toolinfo_set_uid(_ptr_, _value_) (((TOOLINFO *) _ptr_)->uId = (UINT_PTR) (_value_))
#define cwel_toolinfo_set_rect(_ptr_, _value_) (((TOOLINFO *) _ptr_)->rect = (* (RECT *) (_value_)))
#define cwel_toolinfo_set_hinst(_ptr_, _value_) (((TOOLINFO *) _ptr_)->hinst = (HINSTANCE) (_value_))
#define cwel_toolinfo_set_lpsztext(_ptr_, _value_) (((TOOLINFO *) _ptr_)->lpszText = (LPTSTR) (_value_))

#define cwel_toolinfo_get_uflags(_ptr_) ((((TOOLINFO *) _ptr_)->uFlags))
#define cwel_toolinfo_get_hwnd(_ptr_) ((((TOOLINFO *) _ptr_)->hwnd))
#define cwel_toolinfo_get_uid(_ptr_) ((((TOOLINFO *) _ptr_)->uId))
#define cwel_toolinfo_get_rect(_ptr_) ((& ((TOOLINFO *) _ptr_)->rect))
#define cwel_toolinfo_get_hinst(_ptr_) ((((TOOLINFO *) _ptr_)->hinst))
#define cwel_toolinfo_get_lpsztext(_ptr_) ((((TOOLINFO *) _ptr_)->lpszText))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TOOLINFO__ */
