/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record _COAUTHIDENTITY
	User: Pointed Type
			-- No description available.
	UserLength: ULONG
			-- No description available.
	Domain: Pointed Type
			-- No description available.
	DomainLength: ULONG
			-- No description available.
	Password: Pointed Type
			-- No description available.
	PasswordLength: ULONG
			-- No description available.
	Flags: ULONG
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY__COAUTHIDENTITY_S_H__
#define __ECOM_CONTROL_LIBRARY__COAUTHIDENTITY_S_H__
#ifdef __cplusplus
extern "C" {
#endif


namespace ecom_control_library
{
struct tag_COAUTHIDENTITY;
typedef struct ecom_control_library::tag_COAUTHIDENTITY _COAUTHIDENTITY;
}

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif



namespace ecom_control_library
{
struct tag_COAUTHIDENTITY
{	USHORT * User;
	ULONG UserLength;
	USHORT * Domain;
	ULONG DomainLength;
	USHORT * Password;
	ULONG PasswordLength;
	ULONG Flags;
};
}
#ifdef __cplusplus
}
#endif

#endif