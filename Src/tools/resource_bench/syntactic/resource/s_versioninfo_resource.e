note
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- VersionInfo_resource -> "VERSIONINFO" Fixed_info "BEGIN" Block_info "END"

class S_VERSIONINFO_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING
		once
			Result := "VERSIONINFO_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT]
		local
			fixed_info: FIXED_INFO
			begin1: BEGIN_BLOCK
			block_info: BLOCK_INFO
			end1: END_BLOCK
		once
			create Result.make
			Result.forth

			keyword ("VERSIONINFO")
			commit

			create fixed_info.make
			put (fixed_info)

			create begin1.make
			put (begin1)

			create block_info.make
			put (block_info)

			create end1.make
			put (end1)
		end

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
end -- class S_VERSIONINFO_RESOURCE

