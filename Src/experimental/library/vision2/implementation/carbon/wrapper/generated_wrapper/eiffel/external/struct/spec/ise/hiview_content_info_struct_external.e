-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct HIViewContentInfo

class HIVIEW_CONTENT_INFO_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct HIViewContentInfo)"
		end

	get_contenttype_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HIViewContentInfo_member_get_contentType"
		end

	set_contenttype_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HIViewContentInfo_member_set_contentType"
		ensure
			a_value_set: a_value = get_contenttype_external (an_item)
		end

end
