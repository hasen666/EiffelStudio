indexing
	description: "[
		A base dialog implementation for all dialogs resident in EiffelStudio with a tool bar ribbon.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_TOOL_DIALOG

inherit
	ES_DIALOG
		rename
			build_dialog_interface as build_dialog_tool_interface
		redefine
			internal_recycle,
			internal_detach_entities
		end

feature {NONE} -- Initialization

	frozen build_dialog_tool_interface (a_container: EV_VERTICAL_BOX) is
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			l_tool_bar_container: like create_tool_container_widget
		do
				-- Create tool bar
			l_tool_bar_container := create_tool_container_widget (a_container)
			a_container.extend (l_tool_bar_container)

				-- Create content
			build_dialog_interface (l_tool_bar_container)
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		require
			a_container_attached: a_container /= Void
			not_a_container_is_destoryed: not a_container.is_destroyed
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		deferred
		ensure
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		end

feature {NONE} -- Clean up

    internal_recycle is
            -- Recycle tool.
        do
            if internal_tool_bar_widget /= Void and internal_tool_bar_widget.item /= Void and then not internal_tool_bar_widget.item.is_destroyed then
                internal_tool_bar_widget.item.destroy
            end
            if internal_right_tool_bar_widget /= Void and internal_right_tool_bar_widget.item /= Void and then not internal_right_tool_bar_widget.item.is_destroyed then
                internal_right_tool_bar_widget.item.destroy
            end

            Precursor {ES_DIALOG}
        end

    internal_detach_entities is
            -- Detaches objects from their container
        do
            Precursor {ES_DIALOG}
            internal_tool_bar_widget := Void
            internal_right_tool_bar_widget := Void
        ensure then
            internal_tool_bar_widget_detached: internal_tool_bar_widget = Void
            internal_right_tool_bar_widget_detached: internal_right_tool_bar_widget = Void
        end

feature {NONE} -- Access

    frozen tool_bar_widget: SD_TOOL_BAR
            -- Main tool tool bar
        local
            l_cell: like internal_tool_bar_widget
            l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
        do
            l_cell := internal_tool_bar_widget
            if l_cell = Void then
                create l_cell.put (Void)
                internal_tool_bar_widget := l_cell

                l_items := create_tool_bar_items
                if l_items /= Void then
                    create {SD_WIDGET_TOOL_BAR} Result.make (create {SD_TOOL_BAR}.make)
                    l_items.do_all (agent Result.extend)
                    l_cell.put (Result)
                    Result.compute_minimum_size
                end
            else
                Result := l_cell.item
            end
        ensure
            result_consistent: Result = tool_bar_widget
        end

    frozen right_tool_bar_widget: SD_TOOL_BAR
            -- Secondary right tool bar
        local
            l_cell: like internal_right_tool_bar_widget
            l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
        do
            l_cell := internal_right_tool_bar_widget
            if l_cell = Void then
                create l_cell.put (Void)
                internal_right_tool_bar_widget := l_cell

                l_items := create_right_tool_bar_items
                if l_items /= Void then
                    create {SD_WIDGET_TOOL_BAR} Result.make (create {SD_TOOL_BAR}.make)
                    Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
                    l_items.do_all (agent Result.extend)
                    l_cell.put (Result)
                end
            else
                Result := l_cell.item
            end
        ensure
            result_consistent: Result = right_tool_bar_widget
        end

feature {NONE} -- Status report

    frozen has_tool_bar: BOOLEAN
            -- Indicates if tool has a tool bar
        do
            Result := tool_bar_widget /= Void or right_tool_bar_widget /= Void
        end

feature {NONE} -- Factory

    create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
        deferred
        ensure
            not_reuslt_is_empty: Result /= Void implies not Result.is_empty
            result_contains_attached_items: Result /= Void implies not Result.has (Void)
        end

    create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items that should be displayed at the top, but right aligned.
            -- Note: Redefine to add a right tool bar.
        do
        ensure
            not_reuslt_is_empty: Result /= Void implies not Result.is_empty
            result_contains_attached_items: Result /= Void implies not Result.has (Void)
        end

    create_tool_container_widget (a_widget: EV_VERTICAL_BOX): EV_VERTICAL_BOX
            -- Creates the tool's tool bars if `tool_bar_items' and/or `right_tool_bar_items' contain items
            --
            -- `a_widget': The user widget to place in container.
        require
            a_widget_attached: a_widget /= Void
            has_tool_bar: has_tool_bar
        local
            l_top_padding: EV_CELL
            l_padding: EV_CELL
            l_container: EV_HORIZONTAL_BOX
            l_tool_bar: like tool_bar_widget
            l_right_tool_bar: like right_tool_bar_widget
        do
            l_tool_bar := tool_bar_widget
            l_right_tool_bar := right_tool_bar_widget

                -- Top padding compensates for {SD_TOOL_BAR} not vertically aligning tool bars
            create l_top_padding
            l_top_padding.set_minimum_height (2)

            create l_container
            l_container.set_minimum_height (26)

                -- Add left tool bar
            if l_tool_bar /= Void then
                l_container.extend (l_tool_bar)
            end

                -- Add right tool bar
            if l_right_tool_bar /= Void then
                create l_padding
                l_container.extend (l_padding)
                l_container.extend (l_right_tool_bar)
                l_right_tool_bar.compute_minimum_size
                l_container.disable_item_expand (l_right_tool_bar)
            end

            create Result
            Result.extend (l_top_padding)
            Result.disable_item_expand (l_top_padding)
            Result.extend (l_container)
            Result.disable_item_expand (l_container)
        ensure
            result_attached: Result /= Void
        end

feature {NONE} -- Internal implementation cache

    internal_tool_bar_widget: CELL [like tool_bar_widget]
            -- Cached version of `tool_bar_widget'

    internal_right_tool_bar_widget: CELL [like right_tool_bar_widget]
            -- Cached version of `right_tool_bar_widget'

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
