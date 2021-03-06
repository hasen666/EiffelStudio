﻿note
	description: "Objects that test EV_VERTICAL_SCROLL_BAR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_SCROLL_BAR_ADJUSTING_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			label: EV_LABEL
		do
			create vertical_box

			create scroll_bar
			scroll_bar.set_minimum_height (250)
			scroll_bar.pointer_motion_actions.extend (agent adjust_progress)

			vertical_box.extend (scroll_bar)
			create label.make_with_text ("Move mouse over scroll bar")
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)

			widget := vertical_box
		end

feature {NONE} -- Implementation

	adjust_progress (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Set `value' of `scroll_bar' based on `x'.
			-- The default value of a scroll bar is 0-100.
		do
			scroll_bar.set_value ((((y / scroll_bar.height) *
				(scroll_bar.value_range.capacity - scroll_bar.leap + 1)).truncated_to_integer).max (0).min (100))
		end

	scroll_bar: EV_VERTICAL_SCROLL_BAR;
		-- Widget that test is to be performed on.

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
