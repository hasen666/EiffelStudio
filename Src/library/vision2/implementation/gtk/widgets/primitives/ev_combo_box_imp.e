indexing

	description: 
		"EiffelVision combo box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_COMBO_BOX_IMP
	
inherit
	EV_COMBO_BOX_I

	EV_TEXT_FIELD_IMP
		undefine
			make_with_text
		redefine
			make,
			destroy,
			destroyed,
			text,
			set_editable,
			set_text,
			append_text,
			prepend_text,
			position,
			set_position,
			set_maximum_text_length,
			select_region,
			add_return_command,
			add_change_command,
			remove_return_commands,
			remove_change_commands,
			cut_selection,
			copy_selection,
			paste,
			selection_start,
			selection_end,
			has_selection,
			delete_selection,
			select_all,
			deselect_all,
			is_editable
		end

	EV_LIST_IMP
		undefine
			set_default_colors,
			set_default_options,
			is_multiple_selection,
			set_single_selection,
			set_multiple_selection
		redefine
			make,
			select_item,
			selected_item,
			rows,
			selected,
			add_item,
			remove_item,
			destroy,
			destroyed
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a combo-box with `par' as parent.
		do
			-- create of the array where the items will be listed.
			create ev_children.make (1)

			-- create of the gtk object.
			widget := gtk_combo_new
			gtk_object_ref (widget)

			-- Pointer to the text we see.
			entry_widget := c_gtk_combo_entry (widget)

			-- Pointer to the list of items.
			list_widget := c_gtk_combo_list (widget)
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := gtk_entry_get_text (entry_widget)
			create Result.make (0)
			Result.from_c (p)
		end

	select_item (index: INTEGER) is
			-- Give the item of the list at the one-base
			-- index. (Gtk uses 0 based indexs, I think)
		do
			gtk_list_select_item (list_widget, index-1)
		end

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the item which has the focus.
			-- XX Currently just give head of the gtk selection list
		local
			index: INTEGER
		do
			index := c_gtk_list_selected_item(list_widget)
			if index = -1 then
				Result := Void
			else
				-- Gtk has 0 based indicies
				Result ?= (ev_children @ (index+1)).interface
			end
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable
		do
			Result := c_gtk_editable_editable (entry_widget) /= 0
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			Result := c_gtk_editable_has_selection (entry_widget) /= 0
		end

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := gtk_text_get_point (entry_widget) + 1
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := c_gtk_editable_selection_start (entry_widget) + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := c_gtk_editable_selection_end (entry_widget)
		end

	destroyed: BOOLEAN is
			-- Is screen window destroyed?
		do
			Result := (widget = Default_pointer) and (entry_widget = Default_pointer) and (list_widget = Default_pointer)
		end


feature -- Measurement

	extended_height: INTEGER is
			-- height of the combo-box when the list is shown
		do
			check
				Not_yet_implemented: False
			end
		end

feature -- Status report

	destroy is
			-- destroy the gtk objects.
		do
			clear_items
			if not destroyed then
	                        gtk_widget_destroy (list_widget)
	                        gtk_widget_destroy (entry_widget)
	                        gtk_widget_destroy (widget)
			end
			widget := Default_pointer
			list_widget := Default_pointer
			entry_widget := Default_pointer			
		end

	rows: INTEGER is
		 	-- Number of lines
		do
			Result := c_gtk_list_rows (list_widget)
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := c_gtk_list_selected (list_widget)
		end

feature -- Status setting

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			gtk_entry_set_editable (entry_widget, flag)
		end

	set_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			gtk_entry_set_text (entry_widget, $a)
		end
	
	append_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			gtk_entry_append_text (entry_widget, $a)
		end
	
	prepend_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			gtk_entry_prepend_text (entry_widget, $a)
		end
	
	set_position (pos: INTEGER) is
		do
			gtk_text_set_point (entry_widget, pos - 1)
		end
	
	set_maximum_text_length (len: INTEGER) is
		do
			gtk_entry_set_max_length (entry_widget, len)
		end
	
	select_region (start_pos, end_pos: INTEGER) is
		do
			gtk_entry_select_region (entry_widget, start_pos-1, end_pos)
		end	

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		do
			-- XX Not yet implemented.
		end

feature -- Element change

--	clear_items is
--			-- Clear all the items of the list.
--		do
--			clear_ev_children
--			gtk_list_clear_items (list_widget, 0, rows)
--		end

feature -- Basic operation

	select_all is
			-- Select all the text.
		do
			gtk_editable_select_region (entry_widget, 0, text_length)
		end

	deselect_all is
			-- Unselect the current selection.
		do
			gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
			gtk_editable_delete_selection (entry_widget)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		do
			gtk_editable_cut_clipboard (entry_widget)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			gtk_editable_copy_clipboard (entry_widget)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := position
			set_position (index)
			gtk_editable_paste_clipboard (entry_widget)
			set_position (pos)
		end

feature -- Event : command association

	add_return_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the "Return" button is pressed
		do
			add_command (entry_widget, "activate", cmd,  arg, default_pointer)
		end

	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text of the widget have changed.
		do
			add_command (entry_widget, "changed", cmd,  arg, default_pointer)
		end

feature -- Event -- removing command association

	remove_return_commands is
			-- Empty the list of commands to be executed
			-- when the text field is activated, ie when the user
			-- press the enter key.
		local
			p: POINTER
		do
			p := widget
			widget := entry_widget
			remove_commands (widget, activate_id)
			widget := p
		end

	remove_change_commands is
			-- Empty the list of commands to be executed
			-- when the text of the widget have changed.
		local
			p: POINTER
		do
			p := widget
			widget := entry_widget
			remove_commands (widget, changed_id)
			widget := p
		end

feature {EV_LIST_ITEM} -- Implementation

	add_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Add `item' to the list
		local
			s: ANY
		do
			ev_children.extend (item_imp)
			s := item_imp.text.to_c
			gtk_combo_set_item_string (widget, item_imp.widget, $s)
			gtk_container_add (list_widget, item_imp.widget)
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item' from the list
		do
			ev_children.prune_all (item_imp)
			gtk_container_remove (list_widget, item_imp.widget)
		end

feature {NONE} -- Implementation

	entry_widget: POINTER
		-- A pointer on the text field

end -- class EV_COMBO_BOX_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable  components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
