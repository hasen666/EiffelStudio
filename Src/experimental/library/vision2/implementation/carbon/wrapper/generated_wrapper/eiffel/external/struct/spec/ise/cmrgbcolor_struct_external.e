-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct CMRGBColor

class CMRGBCOLOR_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct CMRGBColor)"
		end

	get_red_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CMRGBColor_member_get_red"
		end

	set_red_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CMRGBColor_member_set_red"
		ensure
			a_value_set: a_value = get_red_external (an_item)
		end

	get_green_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CMRGBColor_member_get_green"
		end

	set_green_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CMRGBColor_member_set_green"
		ensure
			a_value_set: a_value = get_green_external (an_item)
		end

	get_blue_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CMRGBColor_member_get_blue"
		end

	set_blue_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_CMRGBColor_member_set_blue"
		ensure
			a_value_set: a_value = get_blue_external (an_item)
		end

end
