indexing
	description: "Eiffel Vision vertical scroll bar. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VERTICAL_SCROLL_BAR_I

inherit
	EV_SCROLL_BAR_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_SCROLL_BAR

end -- class EV_VERTICAL_SCROLL_BAR_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.5  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.3.6.4  2000/01/31 21:31:34  brendel
--| Changed to comply with revised interface.
--|
--| Revision 1.3.6.3  2000/01/27 19:30:06  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.2  2000/01/06 20:39:50  rogers
--| Fixed to work with major vision2 changes. Removed set_default_options.
--|
--| Revision 1.3.6.1  1999/11/24 17:30:14  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
