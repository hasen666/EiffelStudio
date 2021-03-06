note

	description:
		"Screen. An object of this class must be created before any other %
		%operation of this screen. It will be parent of TOP_SHELL or BASE. %
		%The screen is also a drawing and thus can be used for a world. %
		%Warning: used screen as a drawing can be non-portable. It will work %
		%fin one X window version but the other platforms may not accept it"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SCREEN

inherit

	G_ANY
		export
			{NONE} all
		end;

	DRAWING

create

	make

feature -- Initialization

	make (a_screen_name: STRING)
			-- Create a screen specified by `a_screen_name'.
		do
			if a_screen_name /= Void then
				screen_name := a_screen_name.twin
			else
				screen_name := Void
			end
			create {SCREEN_IMP} implementation.make (Current)
		end;

feature -- Access

	buttons: BUTTONS
			-- Current state of the mouse buttons
		require
			exists: not destroyed
		do
			Result := implementation.buttons
		ensure
			result_exists: Result /= Void
		end;

	screen_name: STRING;
			-- Screen name

	widget_pointed: WIDGET
			-- Widget currently pointed by the pointer
		require
			exists: not destroyed
		do
			Result := implementation.widget_pointed
		end;

feature -- Status report

	destroyed: BOOLEAN
		do
			Result := implementation = Void
		end;

	is_valid: BOOLEAN
			-- Is Current screen created?
		require
			exists: not destroyed
		do
			Result := implementation.is_valid
		end;

feature -- Measurement

	height: INTEGER
			-- Height of screen (in pixel)
		require
			exists: not destroyed
		do
			Result := implementation.height
		ensure
			height_large_enough: Result >= 0
		end;

	width: INTEGER
			-- Width of screen (in pixel)
		require
			exists: not destroyed
		do
			Result := implementation.width
		ensure
			width_large_enough: Result >= 0
		end;

	visible_height: INTEGER
			-- Height of screen (in pixel)
		require
			exists: not destroyed
		do
			Result := implementation.visible_height
		ensure
			visible_height_large_enough: Result >= 0
		end;

	visible_width: INTEGER
			-- Width of screen (in pixel)
		require
			exists: not destroyed
		do
			Result := implementation.visible_width
		ensure
			visible_width_large_enough: Result >= 0
		end;

	x: INTEGER
			-- Current absolute horizontal coordinate of the mouse
		require
			exists: not destroyed
		do
			Result := implementation.x
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < width
		end;

	y: INTEGER
			-- Current absolute vertical coordinate of the mouse
		require
			exists: not destroyed
		do
			Result := implementation.y
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < height
		end

feature -- Comparison

	same (other: like Current): BOOLEAN
			-- Does the current screen and `other' representing the
			-- same screen ?
		require else
			exists: not destroyed;
			other_exists: other /= Void
		do
			Result := other.implementation = implementation
		end;

feature -- Implementation

	implementation: SCREEN_I;;
			-- Implementation of current screen

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




end -- class SCREEN

