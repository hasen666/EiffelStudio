note
	description: "Document Schema attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SCHEMA_ATTRIBUTE

create
	make

feature -- Creation

	make (a_name: STRING; a_parent: DOCUMENT_SCHEMA_ELEMENT)
			-- Make with 'a_name' and 'a_parent'
		require
			parent_not_void: a_parent /= Void
			name_not_void: a_parent /= Void
		do
			name := a_name
			parent := a_parent
		end	
	
feature -- Status Setting

	set_use (a_use: XML_XML_SCHEMA_USE)
			-- Set `use' value
--		require
--			use_not_void: a_use /= Void
		do
			use := a_use
		end	
		
	set_default_value (a_default_value: STRING)
			-- Set `default value'
		require
			value_not_void: a_default_value /= Void
		do
			default_value := a_default_value
		end	
	
feature -- Access

	name: STRING
			-- Name
			
	parent: DOCUMENT_SCHEMA_ELEMENT
			-- Parent
			
	default_value: STRING
			-- Default value
			
	required: BOOLEAN
			-- Required?
		do
			Result := use.to_integer = {XML_XML_SCHEMA_USE}.required.to_integer
		end		
	
	prohibited: BOOLEAN
			-- Prohibited?
		do
			Result := use.to_integer = {XML_XML_SCHEMA_USE}.prohibited.to_integer
		end

	optional: BOOLEAN
			-- Optional?
		do
			Result := use.to_integer = {XML_XML_SCHEMA_USE}.optional.to_integer
		end

feature {NONE} -- Implementation

	use: XML_XML_SCHEMA_USE;
			-- Usage
			
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
end -- class DOCUMENT_SCHEMA_ATTRIBUTE
