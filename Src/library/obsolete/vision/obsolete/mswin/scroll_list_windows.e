note
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SCROLL_LIST_WINDOWS

inherit
	LIST_MAN_WINDOWS

	WEL_SINGLE_SELECTION_LIST_BOX
		rename
			set_focus as wel_set_focus,
			text_length as wel_text_length,
			text as wel_text,
			release_capture as wel_release_capture,
			set_capture as wel_set_capture,
			set_text as wel_set_text,
			make as wel_make,
			unselect as wel_unselect_item,
			selected_item as wel_selected_item,
			selected_string as wel_selected_string,
			selected as wel_single_selected,
			select_item as wel_single_select_item,
			set_y as wel_set_y,
			set_x as wel_set_x,
			width as wel_width,
			count as wel_count,
			show as wel_show,
			font as wel_font,
			height as wel_height,
			set_height as wel_set_height,
			hide as wel_hide,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as wel_shown,
			parent as wel_parent,
			set_width as wel_set_width,
			y as wel_y,
			x as wel_x,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			move as wel_move,
			item as wel_item
		undefine
			on_hide,
			on_show,
			on_left_button_up,
			on_key_up,
			on_left_button_down,
			on_key_down,
			on_right_button_up,
			on_set_cursor,
			on_right_button_down,
			on_mouse_move,
			on_size,
			on_move,
			default_style,
			on_destroy,
			background_brush
		redefine
			on_lbn_selchange
		select
			wel_single_selected,
			wel_single_select_item
		end

	WEL_MULTIPLE_SELECTION_LIST_BOX
		rename
			selected as wel_multiple_selected,
			set_focus as wel_set_focus,
			text_length as wel_text_length,
			text as wel_text,
			release_capture as wel_release_capture,
			set_capture as wel_set_capture,
			set_text as wel_set_text,
			make as wel_make,
			select_items as wel_select_items,
			unselect_items as wel_unselect_items,
			select_all as wel_select_all,
			select_item as wel_multiple_select_item,
			unselect_all as wel_unselect_all,
			set_caret_index as wel_set_caret_index,
			count_selected_items as wel_count_selected_items,
			selected_items as wel_selected_items,
			selected_strings as wel_selected_strings,
			caret_index as wel_caret_index,
			set_y as wel_set_y,
			set_x as wel_set_x,
			width as wel_width,
			count as wel_count,
			show as wel_show,
			font as wel_font,
			height as wel_height,
			set_height as wel_set_height,
			hide as wel_hide,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as wel_shown,
			parent as wel_parent,
			set_width as wel_set_width,
			y as wel_y,
			x as wel_x,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			move as wel_move,
			item as wel_item
		undefine
			on_hide,
			on_show,
			on_left_button_up,
			on_key_up,
			on_left_button_down,
			on_key_down,
			on_right_button_up,
			on_set_cursor,
			on_right_button_down,
			on_mouse_move,
			on_size,
			on_move,
			default_style,
			on_destroy,
			background_brush
		redefine
			on_lbn_selchange
		end

	PRIMITIVE_IMP
		redefine
			realize,
			unrealize,
			set_form_height,
			set_height,
			set_size,
			set_width
		end

	SIZEABLE_WINDOWS

	SCROLL_L_I

create
	make

feature -- Initialization

	make (a_list: SCROLL_LIST; man, is_fixed: BOOLEAN; oui_parent: COMPOSITE)
			-- Initialize the list.
		do
			create private_attributes
			parent ?= oui_parent.implementation
			managed := man
			a_list.set_font_imp (Current)
			a_list.set_list_imp (Current)
			create private_list.make (10)
			private_attributes.set_width (100)
			private_attributes.set_height (100)
			private_visible_item_count := 1
			fixed_size_flag := is_fixed
			oui_widget := a_list
		end

	realize
			-- Create the scrollable list.
		local
			i: INTEGER
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				resize_for_shell
				if multiple_selection then
					default_style := Multiple_select_style
				else
					default_style := Single_select_style
				end
				wc ?= parent
				wel_make (wc, x, y, width, height, id_default)
				from
					i := 1
				variant
					private_list.count + 1 - i
				until
					i > private_list.count
				loop
					insert_item (private_list.i_th (i), -1)
					i := i + 1
				end
				if private_visible_item_count > 1 then
					set_visible_item_count (private_visible_item_count)
				elseif not has_height and not fixed_size then
					if count > 0 then
						set_visible_item_count (count)
					else
						set_visible_item_count (1)
					end
					has_height := false
				end
				if multiple_selection then
					from
						private_selected_positions.start
					variant
						private_selected_positions.count + 1 - private_selected_positions.index
					until
						private_selected_positions.after
					loop
						select_i_th (private_selected_positions.item)
						private_selected_positions.forth
					end
				else
					if private_selected_position > 0 then
						select_i_th (private_selected_position)
					end
				end
				shown := true
				if parent.wel_shown then
					wel_show
				end
			end
		end

	unrealize
			-- Remember the attributes and destroy the scrolled list.
		do
			private_visible_item_count := visible_item_count
			private_selected_count := selected_count
			private_selected_item := selected_item
			private_selected_items := selected_items
			private_selected_position := selected_position
			private_selected_positions := selected_positions
			wel_destroy
		end

feature -- Status setting

	add_browse_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when items are
			-- selected with browse selection mode in current scroll list.
		do
			selection_change_actions.add (Current, a_command, argument)
		end

	add_click_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when items are
			-- selected with click selection mode in current scroll list.
		do
			selection_change_actions.add (Current, a_command, argument)
		end

	add_extended_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when items are
			-- selected with extended selection mode in current scroll list.
		do
			selection_change_actions.add (Current, a_command, argument)
		end

	add_multiple_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when items are
			-- selected with multiple selection mode in current scroll list.
		do
			selection_change_actions.add (Current, a_command, argument)
		end

	add_single_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when items are
			-- selected with single selection mode in current scroll list.
		do
			selection_change_actions.add (Current, a_command, argument)
		end

feature -- Removal

	remove_browse_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with browse selection mode in current scroll list.
		do
			selection_change_actions.remove (Current, a_command, argument)
		end

	remove_click_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with click selection mode in current scroll list.
		do
			selection_change_actions.remove (Current, a_command, argument)
		end

	remove_extended_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with extended selection mode in current scroll list.
		do
			selection_change_actions.remove (Current, a_command, argument)
		end

	remove_multiple_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with multiple selection mode in current scroll list.
		do
			selection_change_actions.remove (Current, a_command, argument)
		end

	remove_single_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' to the list of action to execute when items
			-- are selected with single selection mode in current scroll list.
		do
			selection_change_actions.remove (Current, a_command, argument)
		end

	set_height (new_height: INTEGER)
			-- Set the height to closest `new_height' possible.
		local
			a_visible_count: INTEGER
			old_height: INTEGER
		do
			has_height := True
			old_height := height
			private_attributes.set_height (new_height)
			if realized then
				a_visible_count := new_height // item_height
				set_visible_item_count (a_visible_count.max(1))
				private_attributes.set_height (height)
			end
			if old_height /= height then
				parent.child_has_resized
			end
		end

	set_form_height (new_height: INTEGER)
			-- Set the height to closest `new_height' possible.
		local
			a_visible_count: INTEGER
		do
			private_attributes.set_height (new_height)
			if realized then
				a_visible_count := new_height // item_height
				if a_visible_count > 0 then
					set_visible_item_count (a_visible_count)
				else
					wel_set_height (2 * Border_height)
				end
			end
		end

	set_size (new_width, new_height: INTEGER)
			-- Set the height to closest `new_height' possible
			-- and the width to `new_width'.
		local
			a_visible_count: INTEGER
		do
			has_height := True
			private_attributes.set_height (new_height)
			private_attributes.set_width (new_width)
			if realized then
				a_visible_count := new_height // item_height
				set_visible_item_count (a_visible_count.max (1))
				private_attributes.set_height (height)
				set_width (new_width)
			end
		end

	set_visible_item_count (a_count: INTEGER)
		local
			old_height: INTEGER
		do
			old_height := height
			private_visible_item_count := a_count
			if realized then
				private_attributes.set_height (a_count * item_height + 2 * Border_height)
				wel_set_height (item_height * a_count + 2 * Border_height)
				if (height /= old_height) then
					parent.child_has_resized
				end
			end
		end

	set_largest_width
			-- Set the largest width to the current width
		do
			largest_width := width
		end

	set_width (new_width: INTEGER)
			-- Set the width to `new_width'
		local
			old_width: INTEGER
		do
			old_width := width
			if realized then
				wel_set_width (new_width)
			end
			private_attributes.set_width (width)
			if (width /= old_width) then
				parent.child_has_resized
			end
		end

feature {NONE} -- Implementation

	Border_height: INTEGER
			-- Height of the border
		once
			Result := window_border_height
		end

	insert_item (s: STRING; iti: INTEGER)
			-- Insert `s' at index `iti'.
			-- Indexes start at 1.
		local
			t_width: INTEGER
		do
			t_width := font.implementation.width_of_string (s)
			largest_width := largest_width.max (t_width)
			if t_width + 25 > width then
				if not fixed_size then
					set_width (t_width+25)
				else
					set_horizontal_extent (largest_width)
					show_horizontal_scroll_bar
				end
			end
			if iti = -1 then
				add_string (s)
			else
				if iti <= wel_count then
					insert_string_at (s, iti)
				else
					add_string (s)
				end
			end
		end

	delete_item (i: INTEGER)
			-- Delete the item at index `i'.
			-- Indexes start at 1.
		do
			if realized then
				delete_string (i - 1)
			end
		end

	has_height: BOOLEAN

	has_width: BOOLEAN

	largest_width : INTEGER
		-- Width of largest string in scrolled list

	selected_items: LINKED_LIST[STRING]
			-- All the selected items.
		local
			al : ARRAYED_LIST [STRING]
		do
			if multiple_selection then
				create Result.make
				al ?= wel_selected_strings.linear_representation
				check
					al_exists: al /= Void
				end
				Result.append (al)
			end
		end

	selected_item: STRING
		require else
			single_selection: not multiple_selection
		do
			if exists and wel_single_selected then
				Result := wel_selected_string
			end
		end

	visible_item_count: INTEGER
		do
			if exists then
				Result := (wel_height - 2 * Border_height) // item_height
			else
				Result := private_visible_item_count
			end
		end

	selected_positions: LINKED_LIST [INTEGER]
		local
			al : ARRAYED_LIST [INTEGER]
		do
			if multiple_selection then
				create Result.make
				al ?= wel_selected_items.linear_representation
				check
					al_exists: al /= Void
				end
				Result.append (al)
				from
					Result.start
				until
					Result.after
				loop
					Result.put (result.item + 1)
					Result.forth
				end
			else
				create Result.make
				if wel_single_selected then
					Result.extend (selected_position)
				end
			end
		end

	selected_count: INTEGER
		do
			if multiple_selection then
				Result := wel_count_selected_items
			elseif wel_single_selected then
				Result := 1
			end
		end

	selected_position: INTEGER
		do
			if exists and then wel_single_selected and then not multiple_selection then
				Result := wel_selected_item + 1
			else
				Result := private_selected_position
			end
		end

	remove_right (n: INTEGER)
			-- Remove min (`n', count - position) items
			-- to the right of cursor position.
			-- Do not move cursor.
		local
			i, cursor_index: INTEGER
		do
			cursor_index := private_list.index
			from
				i := 1
			variant
				private_list.count + 1 - i
			until
				i > n or cursor_index = private_list.count
			loop
				private_list.remove_right
				if realized then
					delete_string (i)
				end
				i := i + 1
			end
		end

	selected: BOOLEAN
			-- Is there at least one item selected?
		do
			if multiple_selection then
				Result := wel_multiple_selected
			else
				Result := wel_single_selected
			end
		end

	deselect_all
			-- Deselect all selected items.
		do
			if exists then
				if multiple_selection then
					wel_unselect_all
				else
					wel_unselect_item
				end
			end
		end

	remove_left (n: INTEGER)
			-- Remove min (`n', index - 1) items
			-- to the left of cursor index.
			-- Do not move cursor
			-- (but its index will be decreased by up to n).
		local
			i, cursor_index: INTEGER
		do
			cursor_index := private_list.index
			from
				i := cursor_index
			variant
				private_list.count + 1 - i
			until
				i = 1 or private_list.isfirst
			loop
				private_list.remove_left
				if exists then
					delete_string (private_list.index - 1)
				end
				index := index - 1
				i := i - 1
			end
		end

	remove
			-- Remove item at cursor index
			-- and move cursor to its right neighbor
			-- (or after if no right neighbor).
		local
			cursor_index: INTEGER
		do
			cursor_index := index
			private_list.go_i_th (index)
			private_list.remove
			if exists then
				delete_string (index - 1)
			end
		ensure then
			not_empty_unchanged_index: not is_empty implies index = old index
		end

	prune_all (an_item: STRING)
			-- Remove all items `an_item' from list.
			-- Put cursor after.
		do
			from
				private_list.start
			variant
				private_list.count + 1 - private_list.index
			until
				private_list.after or private_list.is_empty
			loop
				if private_list.item.is_equal (an_item) then
					if exists then
						delete_string (private_list.index - 1)
					end
					private_list.remove
				else
					private_list.forth
				end
			end
		end

	wipe_out
			-- Make list empty
		do
			if not is_empty then
				private_list.wipe_out
				if realized then
					reset_content
				end
				index := 0
			end
		end

	select_i_th (i: INTEGER)
			-- Select item at `i'-th position.
		do
			if multiple_selection then
				wel_multiple_select_item (i-1)
			else
				wel_single_select_item (i-1)
			end
		end

	list_resize (a_width, a_height: INTEGER)
			-- Resize the window with `a_width', `a_height'.
		require
			exists: exists
			a_width_small_enough: a_width <= maximal_width
			a_width_large_enough: a_width >= minimal_width
			a_height_small_enough: a_height <= maximal_height
			a_height_large_enough: a_height >= minimal_height
			not_minimized: not minimized
		do
			cwin_set_window_pos (wel_item, default_pointer,
				0, 0, a_width, a_height,
				Swp_nomove + Swp_nozorder + Swp_noactivate)
		ensure
			width_set: width = a_width
		end

	default_style: INTEGER
			-- Style of list to realize

	Single_select_style : INTEGER
		once
			Result := Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Ws_vscroll +
				Lbs_notify + Ws_visible
		end

	Multiple_select_style: INTEGER
		once
			Result := Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Ws_vscroll +
				Lbs_notify + Lbs_multiplesel + Ws_visible
		end

	on_lbn_selchange
			-- The selection is changed, update the
			-- private attributes.
		local
			cd: SINGLE_DATA
		do
			create cd.make (oui_widget, selected_position, "")
			selection_change_actions.execute (Current, cd)
		end

	oui_widget: SCROLL_LIST
			-- Widget for context data

	is_destroyed: BOOLEAN
		do
			Result := not exists
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




end -- class SCROLL_LIST_WINDOWS

