note
	description: "Information tool commander interface"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_INFORMATION_TOOL_COMMANDER_I

inherit
	USABLE_I

feature -- Basic operations

	refresh_list
			-- Refresh the entry list.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	request_eis_visit
			-- Request EIS background visiting to collect information into EIS storage.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	add_information_to (a_stone: ANY)
			-- Add information to `a_stone'.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	class_entries (a_classi: CLASS_I): SEARCH_TABLE [EIS_ENTRY]
			-- EIS entries corresponding to `a_classi'
		require
			is_interface_usable: is_interface_usable
			a_classi_not_void: a_classi /= Void
		deferred
		ensure
			Result_set: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
