note
	description	: "Abstract description of a debug clause. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_AS

inherit
	INSTRUCTION_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (k: like internal_keys; c: like compound; d_as: like debug_keyword; e: like end_keyword)
			-- Create a new DEBUG AST node.
		require
			e_not_void: e /= Void
		do
			internal_keys := k
			compound := c
			end_keyword := e
			if d_as /= Void then
				debug_keyword_index := d_as.index
			end
		ensure
			internal_keys_set: internal_keys = k
			compound_set: compound = c
			end_keyword_set: end_keyword = e
			debug_keyword_set: d_as /= Void implies debug_keyword_index = d_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_debug_as (Current)
		end

feature -- Roundtrip

	debug_keyword_index: INTEGER
			-- Index of keyword "debug" associated with this structure

	debug_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "debug" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, debug_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := debug_keyword_index
		end

feature -- Attributes

	compound: detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound to debug

	keys: detachable EIFFEL_LIST [STRING_AS]
			-- Debug keys
		do
			if attached internal_keys as l_internal_keys then
				Result := l_internal_keys.keys
			end
		ensure
			good_result: (internal_keys = Void implies Result = Void) and
						 (attached internal_keys as l_keys implies Result = l_keys.keys)
		end

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip

	internal_keys: detachable KEY_LIST_AS
			-- Internal debug keys, in which "(" and ")" are stored		

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached keys as l_keys then
					Result := l_keys.first_token (a_list)
				elseif attached compound as l_compound then
					Result := l_compound.first_token (a_list)
				else
					Result := end_keyword.first_token (a_list)
				end
			elseif debug_keyword_index /= 0 then
				Result := debug_keyword (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := end_keyword.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (keys, other.keys)
		end

invariant
	end_keyword_not_void: end_keyword /= Void
	keys_correct: (attached internal_keys as l_keys implies keys = l_keys.keys) and
				  (internal_keys = Void implies keys = Void)

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

end -- class DEBUG_AS
