﻿note
	description: "[
		A base contract editor ({ES_CONTRACT_EDITOR_WIDGET}) context for class feature-level contracts.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_FEATURE_CONTRACT_EDITOR_CONTEXT

inherit
	ES_CONTRACT_EDITOR_CONTEXT [FEATURE_STONE]
		redefine
			is_stone_usable_internal
		end

feature -- Access

	context_feature: attached E_FEATURE
			-- Context class for contract modifications
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		do
			Result := context_stone.e_feature
		end

feature -- Contracts

	contracts_for_class (a_class: attached CLASS_I; a_live: BOOLEAN): TUPLE [contracts: attached DS_LIST [TAGGED_AS]; modifier: detachable ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]]
			-- <Precursor>
		local
			l_modifier: like create_text_modifier
			l_e_feature: detachable like context_feature
			l_feature_as: detachable FEATURE_AS
			l_assertions: detachable EIFFEL_LIST [TAGGED_AS]
			l_cursor: CURSOR
			l_result: attached DS_ARRAYED_LIST [TAGGED_AS]
		do
			create l_result.make_default

			if a_class = context_class then
				l_modifier := text_modifier
				l_e_feature := context_feature
			elseif attached a_class.compiled_class as l_class_c then
					-- Create a temporary context object to fetch a text modifier.
				check has_feature_table: l_class_c.has_feature_table end
				l_modifier := create_parent_text_modifier (l_class_c)
				l_e_feature := l_modifier.context_feature
			end

			if a_live then
					-- We have a text modifier now, extract the contracts
				if not l_modifier.is_prepared then
						-- Prepare to parse class
					l_modifier.prepare
				end

				if l_modifier.is_ast_available then
						-- Use live AST
					l_feature_as := l_modifier.ast_feature
				end
			end

			if l_feature_as = Void and not a_live then
				check l_e_feature_attached: l_e_feature /= Void end

					-- Class contains syntax errors or request to use the non-live data, use compiled data
				l_feature_as := l_e_feature.ast
			end

			if l_feature_as /= Void then
					-- Extract contracts
				l_assertions := contracts_for_feature (l_feature_as)
				if l_assertions /= Void then
					l_cursor := l_assertions.cursor
					from l_assertions.start until l_assertions.after loop
						l_result.force_last (l_assertions.item)
						l_assertions.forth
					end
					l_assertions.go_to (l_cursor)
				end
			end

			Result := [l_result, {attached ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]} / l_modifier]
		end

feature {NONE} -- Contracts

	contracts_for_feature (a_feature: attached FEATURE_AS): detachable EIFFEL_LIST [TAGGED_AS]
			-- Retrieves a list of contracts given a feature.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
		deferred
		end

feature {NONE} -- Status report

	is_stone_usable_internal (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			Result :=
				Precursor (a_stone) and then
				attached {FEATURE_STONE} a_stone as l_stone and then
				attached {E_ROUTINE} l_stone.e_feature
		ensure then
			is_feature_stone: Result implies attached {FEATURE_STONE} a_stone as s and then attached {E_ROUTINE} s.e_feature
		end

feature {NONE} -- Query

	calculate_parents (a_class: attached CLASS_I; a_list: attached DS_LIST [CLASS_C])
			-- <Precursor>
		local
			l_precusors: detachable ARRAYED_LIST [CLASS_C]
			l_feature_i: detachable FEATURE_I
			l_e_feature: detachable E_FEATURE
			l_class_c: CLASS_C
		do
			if a_class = context_class then
				l_e_feature := context_feature
			elseif a_class.is_compiled then
				l_class_c := a_class.compiled_class
				l_feature_i := l_class_c.feature_table.feature_of_rout_id_set (context_feature.rout_id_set)
				check l_feature_i_attached: l_feature_i /= Void end
				if l_feature_i /= Void then
					l_e_feature := l_feature_i.api_feature (l_class_c.class_id)
					check l_e_feature_attached: l_e_feature /= Void end
				end
			end

			if l_e_feature /= Void then
				l_precusors := l_e_feature.precursors
				if l_precusors /= Void then
					l_precusors.do_all (agent a_list.put_last)
				end
			end
		end

feature {NONE} -- Factory

	create_text_modifier: attached ES_FEATURE_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]
			-- Creates a text modifier
		deferred
		end

;note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
