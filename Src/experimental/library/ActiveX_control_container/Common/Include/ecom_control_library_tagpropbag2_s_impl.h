/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record tagPROPBAG2
	dwType: ULONG
			-- No description available.
	vt: USHORT
			-- No description available.
	cfType: typedef
			-- No description available.
	dwHint: ULONG
			-- No description available.
	pstrName: LPWSTR
			-- No description available.
	clsid: typedef
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_TAGPROPBAG2_S_IMPL_H__
#define __ECOM_CONTROL_LIBRARY_TAGPROPBAG2_S_IMPL_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagPROPBAG2_s.h"

#include "ecom_grt_globals_control_interfaces2.h"

#ifdef __cplusplus
extern "C" {
#endif



#ifdef __cplusplus

#define ccom_tag_propbag2_dw_type(_ptr_) (EIF_INTEGER)(ULONG)(((ecom_control_library::tagPROPBAG2 *)_ptr_)->dwType)

#define ccom_tag_propbag2_set_dw_type(_ptr_, _field_) ((((ecom_control_library::tagPROPBAG2 *)_ptr_)->dwType) = (ULONG)_field_)

#define ccom_tag_propbag2_vt(_ptr_) (EIF_INTEGER)(USHORT)(((ecom_control_library::tagPROPBAG2 *)_ptr_)->vt)

#define ccom_tag_propbag2_set_vt(_ptr_, _field_) ((((ecom_control_library::tagPROPBAG2 *)_ptr_)->vt) = (USHORT)_field_)

#define ccom_tag_propbag2_cf_type(_ptr_) (EIF_REFERENCE)(grt_ce_control_interfaces2.ccom_ce_alias_wire_clipformat_alias9 (((ecom_control_library::tagPROPBAG2 *)_ptr_)->cfType))

#define ccom_tag_propbag2_set_cf_type(_ptr_, _field_) ((((ecom_control_library::tagPROPBAG2 *)_ptr_)->cfType) = (ecom_control_library::wireCLIPFORMAT)_field_)

#define ccom_tag_propbag2_dw_hint(_ptr_) (EIF_INTEGER)(ULONG)(((ecom_control_library::tagPROPBAG2 *)_ptr_)->dwHint)

#define ccom_tag_propbag2_set_dw_hint(_ptr_, _field_) ((((ecom_control_library::tagPROPBAG2 *)_ptr_)->dwHint) = (ULONG)_field_)

#define ccom_tag_propbag2_pstr_name(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_lpwstr (((ecom_control_library::tagPROPBAG2 *)_ptr_)->pstrName, NULL))

#define ccom_tag_propbag2_set_pstr_name(_ptr_, _field_) ((((ecom_control_library::tagPROPBAG2 *)_ptr_)->pstrName) = rt_ec.ccom_ec_lpwstr (eif_access (_field_), NULL))

#define ccom_tag_propbag2_clsid(_ptr_) (EIF_REFERENCE)(grt_ce_control_interfaces2.ccom_ce_record_ecom_guid56 (((ecom_control_library::tagPROPBAG2 *)_ptr_)->clsid))

#define ccom_tag_propbag2_set_clsid(_ptr_, _field_) (memcpy (&(((ecom_control_library::tagPROPBAG2 *)_ptr_)->clsid), (GUID *)_field_, sizeof (GUID)))

#endif
#ifdef __cplusplus
}
#endif

#endif