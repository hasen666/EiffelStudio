indexing
	description: "Implemented `IObjectWithSite' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOBJECT_WITH_SITE_IMPL_PROXY

inherit
	IOBJECT_WITH_SITE_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iobject_with_site_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	set_site (p_unk_site: ECOM_INTERFACE) is
			-- No description available.
			-- `p_unk_site' [in].  
		local
			p_unk_site_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_unk_site /= Void then
				if (p_unk_site.item = default_pointer) then
					a_stub ?= p_unk_site
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_unk_site_item := p_unk_site.item
			end
			ccom_set_site (initializer, p_unk_site_item)
		end

	get_site (riid: ECOM_GUID; ppv_site: CELL [POINTER]) is
			-- No description available.
			-- `riid' [in].  
			-- `ppv_site' [out].  
		do
			ccom_get_site (initializer, riid.item, ppv_site)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iobject_with_site_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_set_site (cpp_obj: POINTER; p_unk_site: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IObjectWithSite_impl_proxy %"ecom_control_library_IObjectWithSite_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_get_site (cpp_obj: POINTER; riid: POINTER; ppv_site: CELL [POINTER]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IObjectWithSite_impl_proxy %"ecom_control_library_IObjectWithSite_impl_proxy_s.h%"](GUID *,EIF_OBJECT)"
		end

	ccom_delete_iobject_with_site_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IObjectWithSite_impl_proxy %"ecom_control_library_IObjectWithSite_impl_proxy_s.h%"]()"
		end

	ccom_create_iobject_with_site_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IObjectWithSite_impl_proxy %"ecom_control_library_IObjectWithSite_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IObjectWithSite_impl_proxy %"ecom_control_library_IObjectWithSite_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IOBJECT_WITH_SITE_IMPL_PROXY

