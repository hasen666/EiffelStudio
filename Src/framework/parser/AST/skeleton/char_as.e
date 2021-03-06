note
	description: "Node for character constant. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CHAR_AS

inherit
	ATOMIC_AS
		undefine
			text
		redefine
			string_value_32
		end

	LEAF_AS

	CHARACTER_ROUTINES

create
	initialize

feature {NONE} -- Initialization

	initialize (c: CHARACTER_32; l, co, p, n, cc, cp, cn: INTEGER)
			-- Create a new CHARACTER AST node.
		require
			l_non_negative: l >= 0
			co_non_negative: co >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cn_non_negative: cn >= 0
		do
			value := c
			set_position (l, co, p, n, cc, cp, cn)
		ensure
			value_set: value = c
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_char_as (Current)
		end

feature -- Properties

	value: CHARACTER_32
			-- Character value

	type: detachable TYPE_AS
			-- Associated type (if any)
		do
				-- Void here
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value
		end

feature -- Output

	string_value_32: STRING_32
		do
			Result := wchar_text (value)
			Result.precede ('%'')
			Result.extend ('%'')
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Output

	string_value: STRING
		do
			Result := encoding_converter.utf32_to_utf8 (string_value_32)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

end -- class CHAR_AS
