note
	description	: "Command to undo diagram commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_UNDO_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			initialize
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- Initialize default values.
		local
			l_shortcut: MANAGED_SHORTCUT
		do
			l_shortcut := preferences.misc_shortcut_data.undo_shortcut
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			set_referred_shortcut (l_shortcut)
		end

feature -- Basic operations

	execute
			-- Perform operation.
		do
			if is_sensitive then
				history.undo
			end
		end

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Accelerator action

	on_ctrl_z
			-- Undo last action if possible and if the diagram
			-- has the focus.
		do
			if is_sensitive and then tool.projector.widget.has_focus and then not history.undo_exhausted then
				execute
			end
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_undo_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_undo_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_undo
		end

	name: STRING = "Undo_command";
			-- Name of the command. Used to store the command in the
			-- preferences.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_UNDO_DIAGRAM_COMMAND
