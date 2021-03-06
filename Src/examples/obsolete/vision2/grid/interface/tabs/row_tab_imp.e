note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROW_TAB_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_horizontal_box_1
			create row_finder
			create row_properties_frame
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_2
			create l_ev_table_1
			create l_ev_label_1
			create row_index_entry
			create l_ev_label_2
			create row_height_entry
			create l_ev_horizontal_box_3
			create l_ev_label_3
			create foreground_color_combo
			create l_ev_horizontal_box_4
			create l_ev_label_4
			create background_color_combo
			create l_ev_horizontal_box_5
			create row_selected_button
			create row_operations_frame
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_6
			create l_ev_vertical_box_3
			create l_ev_cell_1
			create swap_row_button
			create l_ev_cell_2
			create move_to_row_finder
			create l_ev_vertical_box_4
			create l_ev_cell_3
			create rows_to_move_button
			create l_ev_cell_4
			create l_ev_table_2
			create remove_row_button
			create unparent_row_button
			create clear_row_button
			
				-- Build_widget_structure.
			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (row_finder)
			extend (row_properties_frame)
			row_properties_frame.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_table_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_label_3)
			l_ev_horizontal_box_3.extend (foreground_color_combo)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_label_4)
			l_ev_horizontal_box_4.extend (background_color_combo)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (row_selected_button)
			extend (row_operations_frame)
			row_operations_frame.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_cell_1)
			l_ev_vertical_box_3.extend (swap_row_button)
			l_ev_vertical_box_3.extend (l_ev_cell_2)
			l_ev_horizontal_box_6.extend (move_to_row_finder)
			l_ev_horizontal_box_6.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_cell_3)
			l_ev_vertical_box_4.extend (rows_to_move_button)
			l_ev_vertical_box_4.extend (l_ev_cell_4)
			l_ev_vertical_box_2.extend (l_ev_table_2)
			
			row_properties_frame.disable_sensitive
			row_properties_frame.set_text ("Row Properties")
			l_ev_vertical_box_1.set_padding_width (box_padding)
			l_ev_vertical_box_1.set_border_width (box_padding)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_table_1)
			l_ev_table_1.resize (2, 3)
			l_ev_table_1.set_row_spacing (box_padding)
			l_ev_table_1.set_column_spacing (box_padding)
				-- Insert and position all children of `l_ev_table_1'.
			l_ev_table_1.put_at_position (l_ev_label_1, 1, 1, 1, 1)
			l_ev_table_1.put_at_position (row_index_entry, 2, 1, 1, 1)
			l_ev_table_1.put_at_position (l_ev_label_2, 1, 2, 1, 1)
			l_ev_table_1.put_at_position (row_height_entry, 2, 2, 1, 1)
			l_ev_label_1.set_text ("Row Index")
			row_index_entry.set_text ("10")
			row_index_entry.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 1000000))
			row_index_entry.set_value (10)
			l_ev_label_2.set_text ("Row Height")
			row_height_entry.set_text ("100")
			row_height_entry.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 10000))
			row_height_entry.set_value (100)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_3)
			l_ev_label_3.set_text ("Foreground Color : ")
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_4)
			l_ev_label_4.set_text ("Background Color : ")
			row_selected_button.set_text ("Is Row Selected?")
			row_operations_frame.disable_sensitive
			row_operations_frame.set_text ("Row Operations")
			l_ev_vertical_box_2.set_padding_width (box_padding)
			l_ev_vertical_box_2.set_border_width (box_padding)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_vertical_box_2.disable_item_expand (l_ev_table_2)
			l_ev_horizontal_box_6.set_padding_width (box_padding)
			l_ev_horizontal_box_6.disable_item_expand (l_ev_vertical_box_3)
			l_ev_horizontal_box_6.disable_item_expand (move_to_row_finder)
			l_ev_vertical_box_3.disable_item_expand (swap_row_button)
			swap_row_button.set_text ("Move Row ? past Row ?")
			l_ev_vertical_box_4.disable_item_expand (rows_to_move_button)
			rows_to_move_button.set_text ("1")
			rows_to_move_button.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 100))
			rows_to_move_button.set_value (1)
			l_ev_table_2.resize (3, 2)
			l_ev_table_2.set_row_spacing (box_padding)
			l_ev_table_2.set_column_spacing (box_padding)
				-- Insert and position all children of `l_ev_table_2'.
			l_ev_table_2.put_at_position (remove_row_button, 2, 1, 1, 1)
			l_ev_table_2.put_at_position (unparent_row_button, 3, 1, 1, 1)
			l_ev_table_2.put_at_position (clear_row_button, 1, 1, 1, 1)
			remove_row_button.set_text ("Remove Row")
			unparent_row_button.set_text ("Unparent Row")
			clear_row_button.set_text ("Clear Row")
			set_padding_width (box_padding)
			set_border_width (box_padding)
			disable_item_expand (l_ev_horizontal_box_1)
			disable_item_expand (row_properties_frame)
			
				--Connect events.
			row_index_entry.change_actions.extend (agent row_index_entry_changed (?))
			row_height_entry.change_actions.extend (agent row_height_entry_changed (?))
			foreground_color_combo.select_actions.extend (agent foreground_color_combo_selected)
			background_color_combo.select_actions.extend (agent background_color_combo_selected)
			row_selected_button.select_actions.extend (agent row_selected_button_selected)
			swap_row_button.select_actions.extend (agent swap_row_button_selected)
			rows_to_move_button.change_actions.extend (agent rows_to_move_button_selected (?))
			remove_row_button.select_actions.extend (agent remove_row_button_selected)
			unparent_row_button.select_actions.extend (agent unparent_row_button_selected)
			clear_row_button.select_actions.extend (agent clear_row_button_selected)
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	foreground_color_combo, background_color_combo: EV_COMBO_BOX
	row_finder, move_to_row_finder: GRID_ITEM_FINDER
	row_index_entry,
	row_height_entry, rows_to_move_button: EV_SPIN_BUTTON
	swap_row_button, remove_row_button, unparent_row_button,
	clear_row_button: EV_BUTTON
	row_selected_button: EV_CHECK_BUTTON
	row_properties_frame, row_operations_frame: EV_FRAME

feature {NONE} -- Implementation

	l_ev_cell_1, l_ev_cell_2, l_ev_cell_3, l_ev_cell_4: EV_CELL
	l_ev_table_1, l_ev_table_2: EV_TABLE
	l_ev_horizontal_box_1,
	l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4, l_ev_horizontal_box_5,
	l_ev_horizontal_box_6: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1, l_ev_vertical_box_2, l_ev_vertical_box_3,
	l_ev_vertical_box_4: EV_VERTICAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3, l_ev_label_4: EV_LABEL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	row_index_entry_changed (a_value: INTEGER)
			-- Called by `change_actions' of `row_index_entry'.
		deferred
		end
	
	row_height_entry_changed (a_value: INTEGER)
			-- Called by `change_actions' of `row_height_entry'.
		deferred
		end
	
	foreground_color_combo_selected
			-- Called by `select_actions' of `foreground_color_combo'.
		deferred
		end
	
	background_color_combo_selected
			-- Called by `select_actions' of `background_color_combo'.
		deferred
		end
	
	row_selected_button_selected
			-- Called by `select_actions' of `row_selected_button'.
		deferred
		end
	
	swap_row_button_selected
			-- Called by `select_actions' of `swap_row_button'.
		deferred
		end
	
	rows_to_move_button_selected (a_value: INTEGER)
			-- Called by `change_actions' of `rows_to_move_button'.
		deferred
		end
	
	remove_row_button_selected
			-- Called by `select_actions' of `remove_row_button'.
		deferred
		end
	
	unparent_row_button_selected
			-- Called by `select_actions' of `unparent_row_button'.
		deferred
		end
	
	clear_row_button_selected
			-- Called by `select_actions' of `clear_row_button'.
		deferred
		end
	

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ROW_TAB_IMP
