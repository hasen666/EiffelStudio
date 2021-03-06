note
	description: "Controls used to modify objects of type EV_PIXMAPABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAPABLE_CONTROL

inherit
	EV_FRAME

create
	make
	
feature {NONE} -- Initialization

	make (box: EV_BOX; pixmapable: EV_PIXMAPABLE; output: EV_TEXT)
			-- Create controls to manipulate `pixmapable', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_PIXMAPABLE")
			create vertical_box
			extend (vertical_box)
			create pixmap
			pixmap.set_with_named_file ("bm_About.png")
			create button.make_with_text ("Set_pixmap")
			create button1.make_with_text ("Remove_pixmap")
			button.select_actions.extend (agent pixmapable.set_pixmap (pixmap))
			button.select_actions.extend (agent button.disable_sensitive)
			button.select_actions.extend (agent button1.enable_sensitive)
			vertical_box.extend (button)
			button1.select_actions.extend (agent pixmapable.remove_pixmap)
			button1.select_actions.extend (agent button1.disable_sensitive)
			button1.select_actions.extend (agent button.enable_sensitive)
			vertical_box.extend (button1)
			box.extend (Current)
		end
	

feature {NONE} -- Implementation

		-- Widgets used to create controls.
	vertical_box: EV_VERTICAL_BOX
	button, button1: EV_BUTTON
	pixmap: EV_PIXMAP;

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


end -- class PIXMAPABLE_CONTROL

