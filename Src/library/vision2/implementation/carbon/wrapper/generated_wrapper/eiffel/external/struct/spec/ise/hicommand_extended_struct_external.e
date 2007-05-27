-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct HICommandExtended

class HICOMMAND_EXTENDED_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct HICommandExtended)"
		end

	get_attributes_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HICommandExtended_member_get_attributes"
		end

	set_attributes_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HICommandExtended_member_set_attributes"
		ensure
			a_value_set: a_value = get_attributes_external (an_item)
		end

	get_commandid_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HICommandExtended_member_get_commandID"
		end

	set_commandid_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_HICommandExtended_member_set_commandID"
		ensure
			a_value_set: a_value = get_commandid_external (an_item)
		end

end

