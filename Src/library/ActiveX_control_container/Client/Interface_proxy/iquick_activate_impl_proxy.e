indexing
	description: "Implemented `IQuickActivate' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IQUICK_ACTIVATE_IMPL_PROXY

inherit
	IQUICK_ACTIVATE_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iquick_activate_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	quick_activate (p_qa_container: TAG_QACONTAINER_RECORD; p_qa_control: TAG_QACONTROL_RECORD) is
			-- No description available.
			-- `p_qa_container' [in].  
			-- `p_qa_control' [out].  
		do
			ccom_quick_activate (initializer, p_qa_container.item, p_qa_control.item)
		end

	set_content_extent (psizel: TAG_SIZEL_RECORD) is
			-- No description available.
			-- `psizel' [in].  
		do
			ccom_set_content_extent (initializer, psizel.item)
		end

	get_content_extent (psizel: TAG_SIZEL_RECORD) is
			-- No description available.
			-- `psizel' [out].  
		do
			ccom_get_content_extent (initializer, psizel.item)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iquick_activate_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_quick_activate (cpp_obj: POINTER; p_qa_container: POINTER; p_qa_control: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IQuickActivate_impl_proxy %"ecom_control_library_IQuickActivate_impl_proxy_s.h%"](ecom_control_library::tagQACONTAINER *,ecom_control_library::tagQACONTROL *)"
		end

	ccom_set_content_extent (cpp_obj: POINTER; psizel: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IQuickActivate_impl_proxy %"ecom_control_library_IQuickActivate_impl_proxy_s.h%"](ecom_control_library::tagSIZEL *)"
		end

	ccom_get_content_extent (cpp_obj: POINTER; psizel: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IQuickActivate_impl_proxy %"ecom_control_library_IQuickActivate_impl_proxy_s.h%"](ecom_control_library::tagSIZEL *)"
		end

	ccom_delete_iquick_activate_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IQuickActivate_impl_proxy %"ecom_control_library_IQuickActivate_impl_proxy_s.h%"]()"
		end

	ccom_create_iquick_activate_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IQuickActivate_impl_proxy %"ecom_control_library_IQuickActivate_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IQuickActivate_impl_proxy %"ecom_control_library_IQuickActivate_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IQUICK_ACTIVATE_IMPL_PROXY

