indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Multiline -> Accelerators_resource | Dialog_resource | DialogEx_resource | Menu_resource |
--              MenuEx_resource | Rcdata_resource | VersionInfo_resource | Textinclude_resource |
--              Dlginit_resource | Tool_bar_resource

class S_MULTILINE 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "MULTILINE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			accelerators: ACCELERATORS_RESOURCE
			dialog: DIALOG_RESOURCE
			dialogEx: DIALOGEX_RESOURCE
			menu: MENU_RESOURCE
			menuEx: MENUEX_RESOURCE
			rcdata: RCDATA_RESOURCE
			version: VERSIONINFO_RESOURCE
			textinclude: TEXTINCLUDE_RESOURCE
			dlginit: DLGINIT_RESOURCE
			toolbar: TOOLBAR_RESOURCE
		once
			!! Result.make
			Result.forth

			!! accelerators.make
			put (accelerators)

			!! dialog.make
			put (dialog)

			!! dialogEx.make
			put (dialogEx)

			!! menu.make
			put (menu)

			!! menuEx.make
			put (menuEx)

			!! rcdata.make
			put (rcdata)

			!! version.make
			put (version)

			!! textinclude.make
			put (textinclude)

			!! dlginit.make
			put (Dlginit)

			!! toolbar.make
			put (toolbar)
		end

indexing
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
end -- class S_MULTILINE

