indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GENERATION_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create filter_frame
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_1
			create l_ev_vertical_box_3
			create convert_box
			create l_ev_label_1
			create l_ev_cell_1
			create transform_file_combo
			create transform_box
			create l_ev_label_2
			create l_ev_cell_2
			create filter_option_combo
			create l_ev_horizontal_box_2
			create l_ev_label_3
			create location_text
			create browse_button
			create l_ev_cell_3
			create help_frame
			create l_ev_vertical_box_4
			create l_ev_horizontal_box_3
			create l_ev_label_4
			create help_name_text
			create l_ev_vertical_box_5
			create html_radio
			create vs_radio
			create web_radio
			create help_toc_box
			create l_ev_frame_1
			create l_ev_vertical_box_6
			create toc_list
			create web_filter_option_combo
			create help_filter_box
			create l_ev_frame_2
			create l_ev_vertical_box_7
			create filter_list
			create web_toc_option_combo
			create l_ev_horizontal_box_4
			create l_ev_cell_4
			create finish_button
			create cancel_button
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (filter_frame)
			filter_frame.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (convert_box)
			convert_box.extend (l_ev_label_1)
			convert_box.extend (l_ev_cell_1)
			convert_box.extend (transform_file_combo)
			l_ev_vertical_box_3.extend (transform_box)
			transform_box.extend (l_ev_label_2)
			transform_box.extend (l_ev_cell_2)
			transform_box.extend (filter_option_combo)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_label_3)
			l_ev_horizontal_box_2.extend (location_text)
			l_ev_horizontal_box_2.extend (browse_button)
			l_ev_vertical_box_2.extend (l_ev_cell_3)
			l_ev_vertical_box_1.extend (help_frame)
			help_frame.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_label_4)
			l_ev_horizontal_box_3.extend (help_name_text)
			l_ev_vertical_box_4.extend (l_ev_vertical_box_5)
			l_ev_vertical_box_5.extend (html_radio)
			l_ev_vertical_box_5.extend (vs_radio)
			l_ev_vertical_box_5.extend (web_radio)
			l_ev_vertical_box_4.extend (help_toc_box)
			help_toc_box.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_6)
			l_ev_vertical_box_6.extend (toc_list)
			l_ev_vertical_box_6.extend (web_filter_option_combo)
			l_ev_vertical_box_4.extend (help_filter_box)
			help_filter_box.extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_vertical_box_7)
			l_ev_vertical_box_7.extend (filter_list)
			l_ev_vertical_box_7.extend (web_toc_option_combo)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_cell_4)
			l_ev_horizontal_box_4.extend (finish_button)
			l_ev_horizontal_box_4.extend (cancel_button)
			
			set_minimum_width (dialog_wide_width)
			set_minimum_height (dialog_tall_height)
			set_title ("Generation Wizard")
			l_ev_vertical_box_1.set_padding_width (padding_width)
			l_ev_vertical_box_1.set_border_width (border_width)
			l_ev_vertical_box_1.disable_item_expand (filter_frame)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_4)
			filter_frame.set_text ("File Options")
			l_ev_vertical_box_2.set_padding_width (padding_width)
			l_ev_vertical_box_2.set_border_width (border_width)
			l_ev_horizontal_box_1.set_padding_width (padding_width)
			l_ev_horizontal_box_1.set_border_width (border_width)
			l_ev_vertical_box_3.set_padding_width (padding_width)
			l_ev_vertical_box_3.set_border_width (inner_border_width)
			l_ev_vertical_box_3.disable_item_expand (convert_box)
			l_ev_vertical_box_3.disable_item_expand (transform_box)
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_2)
			convert_box.set_minimum_width (15)
			convert_box.set_padding_width (padding_width)
			convert_box.set_border_width (border_width)
			convert_box.disable_item_expand (l_ev_label_1)
			convert_box.disable_item_expand (transform_file_combo)
			l_ev_label_1.set_text ("Convert XML documents into")
			l_ev_label_1.align_text_left
			transform_file_combo.set_minimum_width (100)
			transform_file_combo.disable_edit
			transform_box.set_minimum_width (15)
			transform_box.set_padding_width (5)
			transform_box.set_border_width (2)
			transform_box.disable_item_expand (l_ev_label_2)
			transform_box.disable_item_expand (l_ev_cell_2)
			l_ev_label_2.set_text ("Filter documents for")
			l_ev_label_2.align_text_left
			filter_option_combo.set_minimum_width (100)
			filter_option_combo.disable_edit
			l_ev_horizontal_box_2.set_padding_width (5)
			l_ev_horizontal_box_2.set_border_width (2)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_3)
			l_ev_horizontal_box_2.disable_item_expand (browse_button)
			l_ev_label_3.set_text ("Save output to")
			browse_button.set_text ("Browse...")
			browse_button.set_minimum_width (80)
			help_frame.disable_sensitive
			help_frame.set_text ("Help Project Options")
			l_ev_vertical_box_4.set_padding_width (padding_width)
			l_ev_vertical_box_4.set_border_width (border_width)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_4.disable_item_expand (l_ev_vertical_box_5)
			l_ev_horizontal_box_3.set_padding_width (padding_width)
			l_ev_horizontal_box_3.set_border_width (border_width)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_4)
			l_ev_label_4.set_text ("Project Name")
			l_ev_label_4.align_text_left
			help_name_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			l_ev_vertical_box_5.set_padding_width (5)
			l_ev_vertical_box_5.set_border_width (inner_border_width)
			l_ev_vertical_box_5.disable_item_expand (html_radio)
			l_ev_vertical_box_5.disable_item_expand (vs_radio)
			l_ev_vertical_box_5.disable_item_expand (web_radio)
			html_radio.set_text ("Microsoft HTML Help 1.x")
			vs_radio.set_text ("Visual Studio Integrated Help (MS Help 2.0)")
			web_radio.set_text ("Web Help (can generate multiple interchangable tocs)")
			help_toc_box.set_padding_width (padding_width)
			help_toc_box.set_border_width (border_width)
			l_ev_frame_1.set_text ("Table of Contents")
			l_ev_vertical_box_6.set_padding_width (padding_width)
			l_ev_vertical_box_6.set_border_width (border_width)
			l_ev_vertical_box_6.disable_item_expand (web_filter_option_combo)
			web_filter_option_combo.disable_sensitive
			web_filter_option_combo.disable_edit
			help_filter_box.set_padding_width (5)
			help_filter_box.set_border_width (2)
			l_ev_frame_2.set_text ("Document Filters")
			l_ev_vertical_box_7.set_padding_width (5)
			l_ev_vertical_box_7.set_border_width (2)
			l_ev_vertical_box_7.disable_item_expand (web_toc_option_combo)
			web_toc_option_combo.disable_sensitive
			web_toc_option_combo.disable_edit
			l_ev_horizontal_box_4.set_padding_width (padding_width)
			l_ev_horizontal_box_4.set_border_width (border_width)
			l_ev_horizontal_box_4.disable_item_expand (finish_button)
			l_ev_horizontal_box_4.disable_item_expand (cancel_button)
			finish_button.set_text (button_finish_text)
			finish_button.set_minimum_width (button_width)
			cancel_button.set_text (button_cancel_text)
			cancel_button.set_minimum_width (button_width)
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	l_ev_vertical_box_1, l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4, 
	l_ev_vertical_box_5, l_ev_vertical_box_6, l_ev_vertical_box_7: EV_VERTICAL_BOX
	filter_frame, help_frame, l_ev_frame_1, l_ev_frame_2: EV_FRAME
	l_ev_horizontal_box_1, convert_box, transform_box, l_ev_horizontal_box_2, l_ev_horizontal_box_3, 
	help_toc_box, help_filter_box, l_ev_horizontal_box_4: EV_HORIZONTAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3, l_ev_label_4: EV_LABEL
	l_ev_cell_1, l_ev_cell_2, l_ev_cell_3, l_ev_cell_4: EV_CELL
	transform_file_combo, filter_option_combo, web_filter_option_combo, web_toc_option_combo: EV_COMBO_BOX
	location_text, help_name_text: EV_TEXT_FIELD
	browse_button, finish_button, cancel_button: EV_BUTTON
	html_radio, vs_radio, web_radio: EV_RADIO_BUTTON
	toc_list, filter_list: EV_MULTI_COLUMN_LIST

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
end -- class GENERATION_DIALOG_IMP
