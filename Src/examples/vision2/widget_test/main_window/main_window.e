indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	MAIN_WINDOW_IMP
	
	WIDGET_TEST_SHARED
		undefine
			copy, default_create, is_equal
		end
		
	SHARED_TEST_CONTROLLER
		undefine
			copy, default_create, is_equal
		end
		
	GENERATION_CONSTANTS
		undefine
			copy, default_create, is_equal
		end
		
	EXECUTION_ENVIRONMENT
		rename
			put as execution_environment_put
		undefine
			copy, default_create, is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			type_selector: GB_TYPE_SELECTOR
			editor: GB_OBJECT_EDITOR
			event_selector: EVENT_SELECTOR
			documentation_display: DOCUMENTATION_DISPLAY
			temp_font: EV_FONT
		do
			register_type_change_agent (agent clear_idle_actions)
				-- Clear any agents from the idle actions, as a new widget
				-- type is being selected.
				
			register_type_change_agent (agent update_title)
			
				-- The first type change agent that we register locks the update, so
				-- that the user does not see the changes taking place.
			register_type_change_agent (agent lock_current)
			
				-- Create the editor and parent.
			create editor
			object_editor.extend (editor)

				-- Create the type selector and parent.
			create type_selector
			widget_selector_parent.extend (type_selector)
			
				-- Create the test controller.
			test_controller.set_class_output (test_class_display)
			controller_parent.extend (test_controller)
			
				-- Create the documentation display
			create documentation_display.make_with_text (flat_short_display)
			register_type_change_agent (agent documentation_display.update_for_type_change)

			
			create event_selector.make_with_list_and_handler (event_selector_list, event_handler)
			register_type_change_agent (agent event_selector.rebuild)
			
				-- Register a change agent which parents the new test widget.
			register_type_change_agent (agent parent_test_widget)
			
				-- Register a change agent which removes the start up screen.
			register_type_change_agent (agent remove_first_screen)
			
				-- The last type change agent we register unlocks the current
				-- window, so that we can see any changes to the interface.
			register_type_change_agent (agent unlock_current)
			
				-- Ensure that the three tool bar buttons behave as radio buttons.
			properties_button.select_actions.extend (agent update_tool_bar_radio_buttons (properties_button))			
			tests_button.select_actions.extend (agent update_tool_bar_radio_buttons (tests_button))			
			documentation_button.select_actions.extend (agent update_tool_bar_radio_buttons (documentation_button))
			main_notebook.selection_actions.extend (agent update_buttons)
			
				-- Connect flatshort text size buttons to agents.
			increase_text_button.select_actions.extend (agent modify_flatshort_text (1))
			increase_text_button.pointer_button_press_actions.force_extend (agent button_pressed (increase_text_button))
			increase_text_button.pointer_double_press_actions.force_extend (agent button_pressed (increase_text_button))
			increase_text_button.pointer_button_release_actions.force_extend (agent button_released (increase_text_button))
			decrease_text_button.select_actions.extend (agent modify_flatshort_text (-1))
			decrease_text_button.pointer_button_press_actions.force_extend (agent button_pressed (decrease_text_button))
			decrease_text_button.pointer_button_release_actions.force_extend (agent button_released (decrease_text_button))
			
				-- Initialize button pixmaps.
			initialize_pixmaps
			
				-- Set up search tool
			search_tool.associate_text_entry (search_field)
			
				-- Now select font for `flat_short_display'
			temp_font := flat_short_display.font
			temp_font.set_family (feature {EV_FONT_CONSTANTS}.Family_typewriter)
			flat_short_display.set_font (temp_font)
			
				-- Connect missing pixmaps to show_actions.
			application.post_launch_actions.extend (agent display_missing_pixmaps)
			
			setup_initial_screen
		end

feature {NONE} -- Implementation

	update_title (a_widget: EV_WIDGET) is
			-- Update `title' based on type of `a_widget'.
		do
			set_title ("Vision2 Tour - " + a_widget.generating_type)
		end
		

	clear_idle_actions (a_widget: EV_WIDGET) is
			-- Clear `idle_actions' from EV_APPLICATION.
		do
			application.idle_actions.wipe_out
		ensure
			actions_empty: application.idle_actions.is_empty
		end

	modify_flatshort_text (value: INTEGER) is
			-- adjust font size of `flat_short_display' by `value'.
		local
			font: EV_FONT
		do
			font := flat_short_display.font
			if font.height + value > 4 then
				font.set_height (font.height + value)
				flat_short_display.set_font (font)
			end
		end
	
	initial_timer, second_timer: EV_TIMEOUT
			-- Timers for adjusting the flatshort text.
		
	button_pressed (a_button: EV_BUTTON) is
			-- The mouse pointer has been pressed on `a_button', so start
			-- timers for adjusting the flatshort text.
		require
			button_valid: a_button = increase_text_button or a_button = decrease_text_button
		do
			if second_timer /= Void then
				second_timer.destroy	
			end
			if not a_button.has_capture then
				a_button.enable_capture
			end
			create initial_timer.make_with_interval (250)
			initial_timer.actions.extend (agent (a_button.select_actions).call ([]))			
		end
		
	button_released (a_button: EV_BUTTON) is
			-- The mouse pointer has been release on `a_button', so start
			-- timers for adjusting the flatshort text.
		require
			button_valid: a_button = increase_text_button or a_button = decrease_text_button
		do
			initial_timer.destroy
			create second_timer.make_with_interval (250)
			if a_button.has_capture then
				second_timer.actions.extend (agent a_button.disable_capture)
			end
			second_timer.actions.extend (agent second_timer.destroy)
		end

	display_about_dialog is
			-- Display an instance of ABOUT_DIALOG
			-- modally to `Current'.
		local
			about_dialog: ABOUT_DIALOG
		do
			create about_dialog.make
			about_dialog.show_modal_to_window (Current)
		end

	set_window_title (a_widget: EV_WIDGET) is
			-- Assign a title to `Current', reflecting type
			-- of widget that is currently being tested.
		do
			set_title ("Testing - " + test_widget_type + ".")
		end

	parent_test_widget (a_widget: EV_WIDGET) is
			-- Ensure `a_widget' is parented in
			-- `widget_holder'.
		do
			widget_holder.wipe_out
			
				-- We must now rebuild `widget_holder' to ensure
				-- that no minimum size settings still apply. This
				-- will ensure that each test will be at the default size,
				-- even if the last was large.
			vertical_spacing_box.prune (widget_holder)
			create widget_holder
			vertical_spacing_box.go_i_th (2)
			vertical_spacing_box.put_left (widget_holder)
			scrollable_widget_area.set_item_height (310)
			scrollable_widget_area.set_item_width (310)
			
			widget_holder.extend (a_widget)
				-- Now clear recorded events, as a widget has changed.
			clear_events
		end
		
	select_all_events is
			-- Select all events in `event_selector_list'.
		do
			from
				event_selector_list.start
			until
				event_selector_list.off
			loop
				event_selector_list.check_item (event_selector_list.item)
				event_selector_list.forth
			end
		end
		
	clear_all_events is
			-- Clear all events in `event_selector_list'.
		do
			from
				event_selector_list.start
			until
				event_selector_list.off
			loop
				event_selector_list.uncheck_item (event_selector_list.item)
				event_selector_list.forth
			end
		end
		
	clear_events is
			-- Reset `event_selector_list'.
		do
			event_handler.reset	
		end
		
	event_handler: ORDERED_STRING_HANDLER is
			-- Once access to an ORDERED_STRING_HANDLER.
		once
			create Result.make_with_textable (event_output)
		end
		
	setup_initial_screen is
			-- Display initial start up scren which will be displayed until a
			-- widget type is selected.
		local
			label: EV_LABEL
		do
			test_class_display.set_background_color ((create {EV_STOCK_COLORS}).white)
			flat_short_display.set_background_color ((create {EV_STOCK_COLORS}).white)
			main_split_area.prune (main_box)
			create label.make_with_text ("Please select a widget to begin exploration")
			main_split_area.extend (label)
			label.set_background_color ((create {EV_STOCK_COLORS}).white)
		end
		
	remove_first_screen (v: EV_WIDGET) is
			-- Remove initial start up screen.
			-- Note that this is called every time the widget type
			-- changes, but will do nothing after the first time.
		do
			if not main_split_area.has (main_box) then
				main_split_area.go_to_second
				main_split_area.replace (main_box)
			end
			
				-- Now enable the tool bar buttons.
			properties_button.enable_sensitive
			properties_button.enable_select
			tests_button.enable_sensitive
			documentation_button.enable_sensitive
				
		ensure
			main_split_area.has (main_box)
		end
		
	lock_current (v: EV_WIDGET) is
			-- Calls `lock_update' but with a signature that allows
			-- it to be registered as a type change agent.
		do
			lock_update
		end
		
	unlock_current (v: EV_WIDGET) is
			-- Calls `unlock_update' but with a signature that allows
			-- it to be registered as a type change agent.
		do
			unlock_update
		end
		
	update_tool_bar_radio_buttons (selected_button: EV_TOOL_BAR_TOGGLE_BUTTON) is
			-- Simulate radio button behaviour on the three buttons in
			-- the seperate tool bars.
		do
			if selected_button /= properties_button then
				properties_button.select_actions.block
				properties_button.disable_select
				properties_button.select_actions.resume
			else
				main_notebook.select_item (main_notebook_properties_item)
				generate_button.disable_sensitive
				file_generate.disable_sensitive
			end
			if selected_button /= tests_button then
				tests_button.select_actions.block
				tests_button.disable_select
				tests_button.select_actions.resume
			else
				main_notebook.select_item (main_notebook_tests)
				generate_button.enable_sensitive
				file_generate.enable_sensitive
			end
			if selected_button /= documentation_button then
				documentation_button.select_actions.block
				documentation_button.disable_select
				documentation_button.select_actions.resume
			else
				main_notebook.select_item (flat_short_display_parent)
				generate_button.disable_sensitive
				file_generate.disable_sensitive
			end
		end
		
	update_buttons is
			-- Update tool bar buttons to track notebook selections.
		do
			if main_notebook.selected_item = main_notebook_properties_item then
				properties_button.enable_select
			end
			if main_notebook.selected_item = main_notebook_tests then
				tests_button.enable_select
			end
			if main_notebook.selected_item = flat_short_display_parent then
				documentation_button.enable_select
			end
		end

	initialize_pixmaps is
			-- Assign pixmaps to buttons as necessary.
		do
			properties_button.set_pixmap (pixmap_by_name ("properties"))
			tests_button.set_pixmap (pixmap_by_name ("testing"))
			documentation_button.set_pixmap (pixmap_by_name ("documentation"))
			generate_button.set_pixmap (pixmap_by_name ("icon_code_generation_color"))
			increase_text_button.set_pixmap (pixmap_by_name ("size_up"))
			decrease_text_button.set_pixmap (pixmap_by_name ("size_down"))
		end
		
	pixmap_by_name (a_name: STRING): EV_PIXMAP is
			-- `Result' is a pixmap corresponding to `a_name'.
		require
			name_not_void: a_name /= Void
		local
			file_name: FILE_NAME
			file_location: STRING
		do
			file_location := get ("ISE_VISION2_TOUR")
			if file_location = Void then
				file_location := get ("ISE_EIFFEL")
				if file_location /= Void then
					create file_name.make_from_string (file_location)
					file_name.extend ("vision2_tour")
				end
			else
				create file_name.make_from_string (file_location)
			end
			if file_location /= Void then
				file_name.extend ("bitmaps")
				file_name.extend (image_extension)
				file_name.extend (a_name + "." + image_extension)
				create Result
				Result.set_with_named_file (file_name.out)
			else
				missing_files.extend (a_name + "." + image_extension)
				Create Result
			end
		ensure
			result_not_void: Result /= Void
		end
		
	display_missing_pixmaps is
			-- Warn user that files are missing.
		local
			warning_dialog: EV_WARNING_DIALOG
			message_text: STRING
		do
			if not missing_files.is_empty then
				create warning_dialog
				message_text := "Unable to locate the following files :%N"
				from
					missing_files.start
				until
					missing_files.off
				loop
					message_text.append (missing_files.item + "%N")
					if missing_files.index = 15 then
						message_text.append ("... + More%N")
						missing_files.go_i_th (missing_files.count)
					end
					missing_files.forth
				end
				message_text.append ("%NIf this tour was included in the EiffelStudio installation, please ensure that ISE_EIFFEL environment variable is correctly set.%N%NIf you downloaded this tour seperately, please ensure the ISE_VISION2_TOUR environment variable is set, and points to the root directory of this tour.")
				warning_dialog.set_text (message_text)
				warning_dialog.show_modal_to_window (Current)
			end
		end
	
	image_extension: STRING is
			-- Extension type of image formats on current platform.
			-- either "png" or "ico"
		once
			if (create {EV_ENVIRONMENT}).supported_image_formats.has ("ICO") then
				Result := "ico"
			else
				Result := "png"
			end
		ensure
			Result_valid: Result.is_equal ("png") or Result.is_equal ("ico")
		end

	perform_generation is
			-- User has requested to generate a test, so
			-- display a GENERATION_DIALOG.
		local
			generation_dialog: GENERATION_DIALOG
		do
			create generation_dialog
			generation_dialog.set_message ("You have selected to generate the " + Test_controller.selected_test_name +
			"%N%NThe following files will be generated:%N" + application_file_name + "%N" + ace_file_name + "%N" + Common_test_file_name + "%N" +
			Test_controller.selected_test_name + ".e%N%NPlease specify a directory and then click %"Ok%" to generate the project:")	
			generation_dialog.show_modal_to_window (Current)
		end
		
	close_test is
			-- Close `Current' and destroy application.
		do
			(create {EV_ENVIRONMENT}).application.destroy
		end

	update_case_matching is
			-- User has selected `match_case_button' so update
			-- search tool.
		do
			if match_case_button.is_selected then
				search_tool.enable_case_matching
			else
				search_tool.disable_case_matching
			end
		end
		
	start_search is
			-- User has selected `search_button' so start
			-- a search
		do
			search_tool.search (search_field.text)
		end
		
	search_tool: SEARCH_TOOL is
			-- Once access to a SEARCH_TOOL which allows
			-- an EV_TEXT to be searched.
		once
			Create Result.make_with_ev_text (flat_short_display)
		end

end -- class MAIN_WINDOW

