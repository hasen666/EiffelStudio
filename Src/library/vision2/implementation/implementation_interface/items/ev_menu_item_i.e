indexing
	description: "EiffelVision menu item. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_I
	
inherit
	EV_SIMPLE_ITEM_I
		redefine
			interface
		end

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Is `Current' sensitive to user actions?
		deferred
		end

feature -- Status setting

	enable_sensitive is
   			-- Set current item sensitive.
		deferred
 		end

	disable_sensitive is
   			-- Set current item insensitive.
		deferred
  		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM

end -- class EV_MENU_ITEM_I

--!-----------------------------------------------------------------------------
--! EiffelVision library: library of reusable components for ISE Eiffel.
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
--| Revision 1.29  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.28  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.27.6.7  2000/02/04 04:02:41  oconnor
--| released
--|
--| Revision 1.27.6.6  2000/02/03 23:32:00  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.27.6.5  2000/02/02 00:06:45  oconnor
--| hacking menus
--|
--| Revision 1.27.6.4  2000/01/27 19:29:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.27.6.3  1999/12/22 18:40:55  rogers
--| Removed pixmap_size_ok as it is no longer pertinent.
--|
--| Revision 1.27.6.2  1999/12/17 19:12:52  rogers
--| redefined interface to be a a more refined type. EV_PICK_AND_DROPABLE_I
--| replaces EV_PND_SOURCE and EV_PND_TARGET. Added top_parent.
--|
--| Revision 1.27.6.1  1999/11/24 17:30:02  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.27.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.27.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
