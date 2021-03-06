note
	description	: "Dialog to choose a folder among the favorites."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CHOOSE_FAVORITES_FOLDER_DIALOG

inherit
	EB_DIALOG

	EB_CONSTANTS
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		undefine
			default_create, copy
		end

	EB_SHARED_MANAGERS
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_favorites_manager: EB_FAVORITES_MANAGER)
			-- Initialize the dialog
		do
			favorites_manager := a_favorites_manager
			default_create
			set_title (Interface_names.t_Choose_folder_name)
			prepare
		end

	prepare
			-- Create the controls and setup the layout
		local
			buttons_box: EV_VERTICAL_BOX
			controls_box: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
				-- Create the button box
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.set_border_width (Layout_constants.Small_padding_size)

			create ok_button.make_with_text_and_action (Interface_names.b_Ok, agent on_ok)
			extend_button (buttons_box, ok_button)

			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, agent on_cancel)
			extend_button (buttons_box, cancel_button)

			buttons_box.extend (create {EV_CELL})

				-- Create the controls
			build_folders_tree
			create label.make_with_text (Interface_names.l_Choose_folder)

				-- Create the left panel: a Combo Box to type the name of the class
				-- and a tree to select the class.
			create controls_box
			controls_box.set_padding (Layout_constants.Small_padding_size)
			controls_box.set_border_width (Layout_constants.Small_padding_size)
			extend_no_expand (controls_box, label)
			controls_box.extend (folders_tree)
			folders_tree.set_minimum_width (Layout_constants.dialog_unit_to_pixels(200))
			folders_tree.set_minimum_height (Layout_constants.dialog_unit_to_pixels(400))

				-- Pack the buttons_box and the controls.
			create hb
			hb.set_border_width (Layout_constants.Small_border_size)
			hb.extend (controls_box)
			extend_no_expand (hb, buttons_box)
			extend (hb)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			show_actions.extend (agent folders_tree.set_focus)
		end

feature -- Activation

feature -- Access

	selected: BOOLEAN
			-- Has the user selected an item

	folder_name: STRING
			-- Folder name entered by the user, if any.
		require
			selected: selected
		local
			sub_folder: EB_FAVORITES_FOLDER
		do
			sub_folder ?= chosen_folder
			if sub_folder /= Void then
				Result := sub_folder.name
			else
				Result := root_folder_name
			end
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
		end

	chosen_folder: EB_FAVORITES_ITEM_LIST
			-- Chosen folder.
		require
			selected: selected
		do
			Result := internal_chosen_folder
		ensure
			Result_valid: Result /= Void
		end

feature {NONE} -- Vision2 events

	on_ok
			-- Terminate the dialog
		do
			if folders_tree.selected_item /= Void then
				selected := True
				internal_chosen_folder ?= folders_tree.selected_item.data
			end
			hide
			destroy
		end

	on_cancel
			-- Terminate the dialog and clear the selection.
		do
			selected := False
			hide
			destroy
		end

feature {NONE} -- Controls

	ok_button: EV_BUTTON
			-- "Ok" button

	cancel_button: EV_BUTTON
			-- "Cancel" button

	folders_tree: EV_TREE
			-- Tree containing the folders

feature {NONE} -- Implementation

	root_folder_name: STRING = "Favorites"

	internal_chosen_folder: EB_FAVORITES_ITEM_LIST
			-- Chosen folder.

	favorites_manager: EB_FAVORITES_MANAGER
			-- Associated favorites manager

	build_folders_tree
			-- Build the tree corresponding to `a_favorites'.
		local
			tree_item: EV_TREE_ITEM
			an_item: EB_FAVORITES_ITEM
			a_folder_item: EB_FAVORITES_FOLDER
			a_favorites: like favorites
			root_node: EV_TREE_ITEM
		do
			create folders_tree
			create root_node
			root_node.set_pixmap (pixmaps.icon_pixmaps.folder_blank_icon)
			root_node.set_text (root_folder_name)
			root_node.set_data (favorites)
			folders_tree.extend (root_node)

			a_favorites := favorites
			from
				a_favorites.start
			until
				a_favorites.after
			loop
				an_item := a_favorites.item
				if an_item.is_folder and not an_item.is_class then
					a_folder_item ?= an_item
					tree_item := build_tree_folder (a_folder_item)
					tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_blank_icon)
					tree_item.set_text (an_item.name)
					tree_item.set_data (a_folder_item)
					root_node.extend (tree_item)
				end

					-- prepare next iteration
				a_favorites.forth
			end
		end

	build_tree_folder (a_favorites_folder: EB_FAVORITES_FOLDER): EV_TREE_ITEM
			-- Build the tree node corresponding to `a_favorites'.
		local
			tree_item: EV_TREE_ITEM
			an_item: EB_FAVORITES_ITEM
			a_folder_item: EB_FAVORITES_FOLDER
		do
			create Result
			from
				a_favorites_folder.start
			until
				a_favorites_folder.after
			loop
				an_item := a_favorites_folder.item
				if an_item.is_folder and not an_item.is_class then
					a_folder_item ?= an_item
					tree_item := build_tree_folder (a_folder_item)
					tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_blank_icon)
					tree_item.set_text (an_item.name)
					tree_item.set_data (a_folder_item)
					Result.extend (tree_item)
				end

					-- prepare next iteration
				a_favorites_folder.forth
			end
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

end -- class EB_CHOOSE_FAVORITES_FOLDER_DIALOG

