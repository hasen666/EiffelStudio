-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct SetupWindowProxyDragImageRec

class SETUP_WINDOW_PROXY_DRAG_IMAGE_REC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct SetupWindowProxyDragImageRec)"
		end

	get_imagegworld_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_SetupWindowProxyDragImageRec_member_get_imageGWorld"
		end

	set_imagegworld_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_SetupWindowProxyDragImageRec_member_set_imageGWorld"
		ensure
			a_value_set: a_value = get_imagegworld_external (an_item)
		end

	get_imagergn_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_SetupWindowProxyDragImageRec_member_get_imageRgn"
		end

	set_imagergn_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_SetupWindowProxyDragImageRec_member_set_imageRgn"
		ensure
			a_value_set: a_value = get_imagergn_external (an_item)
		end

	get_outlinergn_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_SetupWindowProxyDragImageRec_member_get_outlineRgn"
		end

	set_outlinergn_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_SetupWindowProxyDragImageRec_member_set_outlineRgn"
		ensure
			a_value_set: a_value = get_outlinergn_external (an_item)
		end

end
