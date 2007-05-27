-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct ControlClickActivationRec

class CONTROL_CLICK_ACTIVATION_REC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct ControlClickActivationRec)"
		end

	get_localpoint_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlClickActivationRec_member_get_localPoint"
		end

	set_localpoint_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlClickActivationRec_member_set_localPoint"
		end

	get_modifiers_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlClickActivationRec_member_get_modifiers"
		end

	set_modifiers_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlClickActivationRec_member_set_modifiers"
		ensure
			a_value_set: a_value = get_modifiers_external (an_item)
		end

	get_a_result_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlClickActivationRec_member_get_result"
		end

	set_a_result_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlClickActivationRec_member_set_result"
		ensure
			a_value_set: a_value = get_a_result_external (an_item)
		end

end

