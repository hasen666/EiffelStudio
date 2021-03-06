note
	description: 
		"Implementation of XConfigureEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CONFIGURE_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	event_widget: MEL_WIDGET
			-- Widget that received the event
		do
			Result := retrieve_widget_from_window (event)
		end;

	x: INTEGER
            -- X position in window
		do
			Result := c_event_x (handle)
		end

	y: INTEGER
            -- Y position in window
		do
			Result := c_event_y (handle)
		end;

	width: INTEGER
			-- New width of window
		do
			Result := c_event_width (handle)
		end

	height: INTEGER
			-- New height of window
		do
			Result := c_event_height (handle)
		end;

	border_width: INTEGER
			-- New border width of window
		do
			Result := c_event_border_width (handle)
		end;

	above_window_widget: MEL_WIDGET
			-- Sibling widget
		do
			Result := retrieve_widget_from_window (above_window)
		end;

	override_redirect: BOOLEAN
			-- Will the window manager not intercept the
			-- configuration request?
		do
			Result := c_event_override_redirect (handle)
		end

feature -- Pointer access

	event: POINTER
			-- Window that received the event
		do
			Result := c_event_event (handle)
		end;

	above_window: POINTER
			-- Sibling window
		do
			Result := c_event_above (handle)
		end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_width (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_border_width (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_above (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_POINTER"
		end;

	c_event_override_redirect (event_ptr: POINTER): BOOLEAN
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_BOOLEAN"
		end;

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




end -- class MEL_CONFIGURE_EVENT


