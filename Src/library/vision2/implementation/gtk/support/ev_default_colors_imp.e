indexing
	description: "List of default colors used by the system.%
		% Gtk implementation."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_DEFAULT_COLORS_IMP

inherit
	EV_GTK_EXTERNALS

feature -- Access

	Color_dialog: EV_COLOR is
			-- Color usely used for the background of dialogs
		local
			r, g, b: INTEGER
		do			
			c_gtk_style_default_bg_color ($r, $g, $b)
			create Result.make_rgb (r, g, b)
		end

	Color_dialog_fg: EV_COLOR is
			-- Color usely used for the foreground of dialogs
		local
			r, g, b: INTEGER
		do
			c_gtk_style_default_fg_color ($r, $g, $b)
			create Result.make_rgb (r, g, b)
		end

	Color_read_only: EV_COLOR is
			-- Color usely used for the background of editable
			-- when they are in read-only mode
		do
			check True end
			Result := Color_dialog
		end

	Color_read_write: EV_COLOR is
			-- Color usely used for the background of editable
			-- when they are in read / write mode
		do
			check True end
			Result := Color_dialog
		end

	default_background_color: EV_COLOR is
			-- Default background color for most of the widgets.
		do
			check True end
			Result := Color_dialog
		end

	default_foreground_color: EV_COLOR is
			-- Default foreground color for most of the widgets.
		do
			check True end
			Result := Color_dialog_fg
		end

end -- class EV_DEFAULT_COLORS_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
