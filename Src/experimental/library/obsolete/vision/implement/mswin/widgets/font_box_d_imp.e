note
	description: "Dialog for choosing fonts for Windows"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	FONT_BOX_D_IMP

inherit
	WEL_CHOOSE_FONT_DIALOG
		rename
			make as wel_make,
			item as wel_item
		undefine
			is_equal, copy, dispose
		select
			destroy_item,
			exists,
			wel_item
		end

	COLORED_FOREGROUND_WINDOWS

	DIALOG_IMP
		rename
			destroy_item as dialog_destroy_item,
			exists as dialog_exists,
			set_title as dialog_set_title,
			set_font as dialog_set_font,
			title as dialog_title,
			wel_parent as dialog_parent,
			wel_item as dialog_item,
			font as dialog_font,
			set_parent as wel_set_parent
		redefine
			is_popped_up,
			popdown,
			popup,
			realize,
			realized,
			unrealize,
			class_name,
			default_style,
			children_count
		end

	FONT_BOX_D_I
		rename
			forbid_recompute_size as forbid_resize,
			allow_recompute_size as allow_resize
		end
create
	make

feature -- Initialization

	make (a_font_box_d: FONT_BOX_D; oui_parent: COMPOSITE)
			-- Create a font box
		do
			wel_make
			create private_attributes
			parent ?= oui_parent.implementation
			a_font_box_d.set_dialog_imp (Current)
			managed := True
		end

feature -- Access

	font: FONT
			-- Selected font
		local
			font_windows: FONT_IMP
			wel_font: WEL_FONT
		do
			create wel_font.make_indirect (log_font)
			create Result.make
			font_windows ?= Result.implementation
			check
				font_windows_not_void: font_windows /= Void
			end
			font_windows.make_by_wel (wel_font)
		end

feature -- Status setting

	set_font (f: FONT)
			-- Edit `a_font'.			
		local
			fontw: FONT_IMP
		do
			fontw ?= f.implementation
			set_log_font (fontw.wel_log_font)
		end

	realize
			-- Realize current widget.
		do
			realized := True
				-- set initial focus
			if initial_focus /= void then
				initial_focus.wel_set_focus
			end
		end

	dialog_realize
			-- Display a file selection dialog box
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			is_popped_up := True
			wc ?= parent
			activate (wc)
			if selected then
				ok_actions.execute (Current, Void)
			else
				cancel_actions.execute (Current, Void)
			end
		end

	popdown
			-- Pop down the font dialog, no effect under Windows
		do
			is_popped_up := False
		end

	unrealize
			-- Unrealizes the font dialog, no effect under Windows.
		do
			realized := False
		end

	popup
			-- Popup a popup shell.
		do
			dialog_realize
		end

feature -- Status report

	realized: BOOLEAN
			-- Is this widget realized?

	is_popped_up: BOOLEAN
			-- Is this widget popped up?

feature -- Element change

	add_ok_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
			ok_actions.add (Current, a_command, arg)
		end

	add_cancel_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
			cancel_actions.add (Current, a_command, arg)
		end

	add_apply_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		do
			ok_actions.add (Current, a_command, arg)
		end

	hide_apply_button
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	hide_cancel_button
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	hide_ok_button
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	show_apply_button
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	show_cancel_button
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	show_ok_button
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

feature -- Removal

	remove_apply_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		do
			apply_actions.remove (Current, a_command, arg)
		end

	remove_cancel_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			cancel_actions.remove (Current, a_command, arg)
		end

	remove_ok_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			ok_actions.remove (Current, a_command, arg)
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Class name
		once
			Result := "EvisionFontBoxDialog"
		end

feature {NONE} -- Inapplicable

	build
		do
		end

	default_style: INTEGER
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	children_count: INTEGER
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	set_label_font, set_text_font, set_button_font (f: FONT)
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	text_font, label_font, button_font : FONT
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- FONT_BOX_D_IMP

