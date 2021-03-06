note

	description:
		"A text editor for one line of text. %
		%The position in the text is not the characters but the space between %
		%the characters: the first position is null and located before the text, %
		%the position `i' is located after the `i'-th character of text. %
		%When the text is empty, the only valid position is null"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TEXT_FIELD

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end

create

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a text field with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged text field with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a text field with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {TEXT_FIELD_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	text: STRING
			-- Value of current text field
		require
			exists: not destroyed
		do
			Result := implementation.text
		ensure
			Result.count = count
		end;

feature -- Measurement

	maximum_size: INTEGER
			-- Maximum number of characters in current
			-- text field
		require
			exists: not destroyed
		do
			Result := implementation.maximum_size
		end;

	count: INTEGER
			-- Number of character in current text field
		require
			exists: not destroyed
		do
			Result := implementation.count
		ensure
			Result >= 0
		end;

feature -- Status setting

	clear
			-- Clear current text field.
		require
			exists: not destroyed
		do
			implementation.clear
		end;

	set_maximum_size (a_max: INTEGER)
			-- Set maximum_size to `a_max'.
		require
			exists: not destroyed;
			not_negative_maximum: a_max >= 0
		do
			implementation.set_maximum_size (a_max)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to be executed when
			-- an activate event occurs.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed
			Valid_command: a_command /= Void
		do
			implementation.add_activate_action (a_command, argument)
		end;

	append (a_text: STRING)
			-- Append `a_text' at the end of current text.
		require
			exists: not destroyed;
			not_a_text_void: a_text /= Void
		do
			implementation.append (a_text)
		end;

	insert (a_text: STRING; a_position: INTEGER)
			-- Insert `a_text' in current text field at `a_position'.
			-- Same as `replace (a_position, a_position, a_text)'.
		require
			exists: not destroyed;
			not_a_text_void: a_text /= Void;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		do
			implementation.insert (a_text, a_position)
		ensure
			a_text.count > 0 implies a_text.is_equal (text.substring
					(a_position + 1, a_position + a_text.count))
		end;

	replace (from_position, to_position: INTEGER; a_text: STRING)
			-- Replace text from `from_position' to `to_position' by `a_text'.
		require
			exists: not destroyed;
			not_text_void: a_text /= Void;
			from_position_smaller_th_to_position: from_position <= to_position;
			from_position_large_enough: from_position >= 0;
			to_position_small_enough: to_position <= count
		do
			implementation.replace (from_position, to_position, a_text)
		ensure
			a_text.count > 0 implies a_text.is_equal (text.substring
					(from_position + 1, from_position + a_text.count))
		end;

	set_text (a_text: STRING)
			-- Set `text' to `a_text'.
		require
			exists: not destroyed;
			not_a_text_void: a_text /= Void
		do
			implementation.set_text (a_text)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to be executed
			-- when an activate event occurs.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_activate_action (a_command, argument)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: TEXT_FIELD_I;
			-- Implementation of current text field

feature {G_ANY, G_ANY_I, WIDGET_I} -- Implementation

	is_fontable: BOOLEAN = true;
			-- Is current widget an heir of FONTABLE ?

feature {NONE} -- Implementation

	set_default
			-- Set default text to current text field.
		do
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




end -- class TEXT_FIELD

