note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_IMPORT_DIALOG

inherit
	EB_METRIC_IMPORT_DIALOG_IMP

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_TOOL_INTERFACE
		undefine
			is_equal,
			copy,
			default_create
		end

	EVS_GRID_WRAPPER [EB_METRIC_IMPORT_GRID_ROW]
		rename
			make as wrapper_make,
			grid as wrapped_grid
		undefine
			is_equal,
			copy,
			default_create
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER
		undefine
			is_equal,
			copy,
			default_create
		end

	SHARED_WORKBENCH
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_ITERATOR
		undefine
			is_equal,
			copy,
			default_create
		redefine
			process_domain_item,
			process_application_target_domain_item,
			process_group_domain_item,
			process_folder_domain_item,
			process_class_domain_item,
			process_feature_domain_item,
			process_delayed_domain_item
		end

create
	make

feature {NONE} -- Initialization

	make (a_metric_tool: like metric_tool)
			-- Initialize `metric_tool' with `a_metric_too'.
		require
			a_metric_tool_attached: a_metric_tool /= Void
		do
			metric_tool := a_metric_tool
			default_create
		ensure
			metric_tool_set: metric_tool = a_metric_tool
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_metric_names: like metric_names
			l_name_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_IMPORT_GRID_ROW]
			l_original_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_IMPORT_GRID_ROW]
			l_unit_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_IMPORT_GRID_ROW]
			l_status_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_IMPORT_GRID_ROW]
			l_import_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_IMPORT_GRID_ROW]
		do
			create delayed_check_import_file_timer.make (agent on_check_metric_definition_file, 500)

			set_size (700, 500)
			l_metric_names := metric_names
			set_title (l_metric_names.t_import_metric_title)
			import_file_lbl.set_text (l_metric_names.l_metric_definition_file)

			backup_btn.set_text (l_metric_names.t_backup_user_defined_metrics)
			backup_btn.select_actions.extend (agent on_backup_user_defined_metrics)
			import_btn.set_text (l_metric_names.t_import_selected_metrics)
			metric_list_lbl.set_text (l_metric_names.t_metrics_list)

			browse_metric_file_btn.set_text ("...")
			browse_metric_file_btn.select_actions.extend (agent on_browse_file)

			load_btn.set_text (l_metric_names.t_load)
			load_btn.select_actions.extend (agent on_load_metrics)

			close_btn.set_text (l_metric_names.t_close)
			close_btn.select_actions.extend (agent on_close)

			create grid
			grid.set_column_count_to (5)
			wrapper_make (grid)
			grid.column (1).set_title (l_metric_names.t_import)
			grid.column (2).set_title (l_metric_names.t_status)
			grid.column (3).set_title (l_metric_names.t_metric_name)
			grid.column (4).set_title (l_metric_names.t_metric_original_name)
			grid.column (5).set_title (l_metric_names.t_metric_unit)
			grid.pointer_double_press_item_actions.extend (agent activate_item)
			grid.enable_single_row_selection
			grid.key_press_actions.extend (agent on_key_preseed_in_grid)
			enable_auto_sort_order_change
			create l_import_sort_info.make (agent import_order_tester, ascending_order)
			create l_status_sort_info.make (agent status_order_tester, ascending_order)
			create l_name_sort_info.make (agent name_order_tester, ascending_order)
			create l_original_sort_info.make (agent original_name_order_tester, ascending_order)
			create l_unit_sort_info.make (agent unit_order_tester, ascending_order)
			set_sort_info (1, l_import_sort_info)
			set_sort_info (2, l_status_sort_info)
			set_sort_info (3, l_name_sort_info)
			set_sort_info (4, l_original_sort_info)
			set_sort_info (5, l_unit_sort_info)
			set_sort_action (agent sort_agent)
			metric_list_area.extend (grid)
			create file_open_dialog.make_with_preference (preferences.dialog_data.last_imported_metric_definition_directory_preference)
			file_open_dialog.open_actions.extend (agent on_file_selected_by_open_file_dialog)

			load_btn.disable_sensitive

			file_name_combo.change_actions.extend (agent on_metric_definition_file_name_change)
			import_btn.disable_sensitive
			import_btn.select_actions.extend (agent on_import_metrics)
			select_all_metrics_btn.set_text (l_metric_names.t_select_all_metrics)
			select_all_metrics_btn.disable_sensitive
			deselect_all_metrics_btn.set_text (l_metric_names.t_deselect_all_metrics)
			deselect_all_metrics_btn.disable_sensitive
			select_integral_metrics_btn.set_text (l_metric_names.t_select_integral_metrics)
			select_integral_metrics_btn.disable_sensitive
			deselect_integral_metrics_btn.set_text (l_metric_names.t_deselect_integral_metrics)
			deselect_integral_metrics_btn.disable_sensitive
			select_all_metrics_btn.select_actions.extend (agent on_select_metrics_in_batch (True, True))
			deselect_all_metrics_btn.select_actions.extend (agent on_select_metrics_in_batch (False, True))
			select_integral_metrics_btn.select_actions.extend (agent on_select_metrics_in_batch (True, False))
			deselect_integral_metrics_btn.select_actions.extend (agent on_select_metrics_in_batch (False, False))
			create backup_metrics_dialog.make (metric_tool)

			show_actions.extend (agent file_name_combo.set_focus)
			set_default_cancel_button (close_btn)
			set_icon_pixmap (pixmaps.icon_pixmaps.tool_metric_icon)
			backup_btn.set_minimum_width (190)
			import_btn.set_minimum_width (190)
		end

feature {NONE} -- Actions

	on_close
			-- Action to be performed to close current dialog.
		do
			hide
			destroy
		end

	on_browse_file
			-- Action to be performed to browse a metric definition file
		do
			file_open_dialog.show_modal_to_window (Current)
		end

	on_check_metric_definition_file
			-- Action to be performed to check the availability of selected metric definition file
		local
			l_file: RAW_FILE
		do
			create l_file.make_with_name (file_name_combo.text)
			if l_file.exists and then l_file.is_readable and then not l_file.is_directory then
				load_btn.enable_sensitive
			else
				load_btn.disable_sensitive
			end
		end

	on_file_selected_by_open_file_dialog
			-- Action to be performed to set file name selected in `open_file_dialog' to `file_name_combo'.
		do
			file_name_combo.set_text (file_open_dialog.full_file_path.name)
		end

	on_metric_definition_file_name_change
			-- Action to be performed when text in `file_name_combo' changes.
		do
			delayed_check_import_file_timer.request_call
		end

	on_load_metrics
			-- Action to be performed to load metrics file specified file
		do
			record_loaded_metric_file (file_name_combo.text)
			loaded_metrics := metrics_from_file (create {PATH}.make_from_string (file_name_combo.text))
			metric_rows_internal := Void
			if is_metrics_loaded then
				has_grid_resized := False
				bind_grid (False)
				grid.enable_sensitive
				if not metric_rows.is_empty then
					select_all_metrics_btn.enable_sensitive
					deselect_all_metrics_btn.enable_sensitive
					select_integral_metrics_btn.enable_sensitive
					deselect_integral_metrics_btn.enable_sensitive
				end
			end
		end

	on_metric_name_change (a_old_name: STRING; a_row: EB_METRIC_IMPORT_GRID_ROW)
			-- Action to be performed when name in `a_row' changed from `a_old_name' to a new one
		require
			a_old_name_attached: a_old_name /= Void
			a_row_attached: a_row /= Void
		local
			l_name: STRING
		do
			if not is_in_name_changing_mode then
				l_name := a_row.name.twin
				is_in_name_changing_mode := True
				if not has_metric (a_row.name) then
					change_name (a_old_name, a_row.name)
					if has_existing_metric (l_name) then
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt (metric_names.wrn_metric_name_exists_in_your_metrics (l_name), Current, Void)
					end
					bind_grid (True)
				else
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (metric_names.err_metric_name_exists_in_import_metric_list (l_name, a_old_name), Current, Void)
					a_row.set_name_editable_area_text (a_old_name)
				end
				is_in_name_changing_mode := False
			end
		end

	on_metric_selection_change (a_row: EB_METRIC_IMPORT_GRID_ROW)
			-- Action to be performed when selection status in `a_row' changes
		require
			metrics_loaded: is_metrics_loaded
			a_row_attached: a_row /= Void
		local
			l_referenced_metrics: HASH_TABLE [EB_METRIC_IMPORT_GRID_ROW, STRING]
			l_row: EB_METRIC_IMPORT_GRID_ROW
		do
			if not is_in_selection_changing_mode then
				is_in_selection_changing_mode := True
				if a_row.is_selected then
					create l_referenced_metrics.make (36)
					transitive_referenced_metrics (a_row, l_referenced_metrics)
					if not l_referenced_metrics.is_empty then
						from
							l_referenced_metrics.start
						until
							l_referenced_metrics.after
						loop
							l_row := l_referenced_metrics.item_for_iteration
							if l_row /= Void then
								if not l_row.import_checkbox.is_checked then
									l_row.import_checkbox.set_is_checked (True)
								end
							end
							l_referenced_metrics.forth
						end
					end
				end
				is_in_selection_changing_mode := False
				bind_grid (True)
				update_import_button_status
			end
		end

	on_select_metrics_in_batch (a_select: BOOLEAN; a_all: BOOLEAN)
			-- Select/deselect metrics in batch.
			--- If `a_select' is True, select metrics, otherwise, deselect metrics.
			-- If `a_all' is True, select/deselect all metrics, otherwise only select/deselect integral metrics.
		require
			metrics_loaded: is_metrics_loaded
		local
			l_rows: LINKED_LIST [EB_METRIC_IMPORT_GRID_ROW]
			l_metric_rows: like metric_rows
		do
			is_in_selection_changing_mode := True
			create l_rows.make
			l_metric_rows := metric_rows
			from
				l_metric_rows.start
			until
				l_metric_rows.after
			loop
				if a_all then
					l_rows.extend (l_metric_rows.item_for_iteration)
				elseif is_metric_ok (l_metric_rows.item_for_iteration) then
					l_rows.extend (l_metric_rows.item_for_iteration)
				end
				l_metric_rows.forth
			end
			from
				l_rows.start
			until
				l_rows.after
			loop
				if a_select and then not l_rows.item.is_selected then
					l_rows.item.import_checkbox.set_is_checked (True)
				elseif not a_select and then l_rows.item.is_selected then
					l_rows.item.import_checkbox.set_is_checked (False)
				end
				l_rows.forth
			end
			bind_grid (True)
			update_import_button_status
			is_in_selection_changing_mode := False
		end

	on_key_preseed_in_grid (a_key: EV_KEY)
			-- Action to be performed when `a_key' is pressed in `grid'
		require
			a_key_attached: a_key /= Void
		local
			l_rows: LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_metric: EB_METRIC_IMPORT_GRID_ROW
		do
			l_rows := grid.selected_rows
			if not l_rows.is_empty then
				l_row := l_rows.first
				l_metric ?= l_row.data
				if l_metric /= Void then
					if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
						l_row.item (3).activate
					elseif a_key.code = {EV_KEY_CONSTANTS}.key_space then
						if l_metric.is_selected then
							l_metric.import_checkbox.set_is_checked (False)
						else
							l_metric.import_checkbox.set_is_checked (True)
						end
					end
				end
			end
		end

	on_import_metrics
			-- Action to be performed to imported selected metrics
		require
			metrics_loaded: is_metrics_loaded
		local
			l_cursor: like metric_rows.new_cursor
			l_library_tbl: like library_uuid_table
		do
			library_uuid_table_internal := Void
			l_library_tbl := library_uuid_table
			from
				l_cursor := metric_rows.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				if l_cursor.item.is_selected then
					safe_process_item (l_cursor.item.metric)
					metric_manager.save_metric (l_cursor.item.metric, True, Void)
				end
				l_cursor.forth
			end
			metric_tool.store_metrics
			metric_tool.load_metrics_and_display_error (True, metric_names.t_importing_metrics)
			grid.disable_sensitive
			import_btn.disable_sensitive;

			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (metric_names.t_metrics_imported, Current, Void)
		end

	on_backup_user_defined_metrics
			-- Action to be performed to backup user-defined metrics
		do
			backup_metrics_dialog.show_modal_to_window (Current)
		end

feature -- Status report

	should_metric_be_refreshed: BOOLEAN
			-- Should metrics definition be refreshed?
			-- If import occurred, this is set to True.

	is_metrics_loaded: BOOLEAN
			-- Are metrics loaded successfully?
		do
			Result := loaded_metrics /= Void
		end

	has_metric (a_name: STRING): BOOLEAN
			-- Does metric named `a_name' exist in `metric_rows'?
		require
			metrics_loaded: is_metrics_loaded
			a_name_attached: a_name /= Void
		local
			l_rows: like metric_rows
			l_manager: like metric_manager
			l_cursor: like metric_rows.new_cursor
		do
			l_rows := metric_rows
			l_manager := metric_manager
			from
				l_cursor := l_rows.new_cursor
				l_cursor.start
			until
				l_cursor.after or Result
			loop
				Result := l_manager.is_metric_name_equal (a_name, l_cursor.item.metric.name)
				l_cursor.forth
			end
		end

	has_grid_resized: BOOLEAN
			-- Has `grid' been auto-resized?

feature -- Access

	loaded_metrics: LIST [EB_METRIC]
			-- Metrics loaded from file

	metric_rows: ARRAYED_LIST [EB_METRIC_IMPORT_GRID_ROW]
			-- Rows to hold `loaded_metrics'
		require
			metrics_loaded: is_metrics_loaded
		do
			if metric_rows_internal = Void then
				create metric_rows_internal.make (loaded_metrics.count)
				from
					loaded_metrics.start
				until
					loaded_metrics.after
				loop
					metric_rows_internal.force (create {EB_METRIC_IMPORT_GRID_ROW}.make (loaded_metrics.item))
					loaded_metrics.forth
				end
			end
			Result := metric_rows_internal
		ensure
			result_attached: Result /= Void
		end

	metric_rows_internal: like metric_rows
			-- Implementation of `metric_rows'

	metric_table: HASH_TABLE [EB_METRIC_IMPORT_GRID_ROW, STRING]
			-- Metric row table indexed by metric name
		require
			metric_loaded: is_metrics_loaded
		local
			l_metric_rows: like metric_rows
			l_name: STRING
			l_cursor: like metric_rows.new_cursor
		do
			if metric_table_internal = Void then
				l_metric_rows := metric_rows
				create metric_table_internal.make (l_metric_rows.count)
				from
					l_cursor := l_metric_rows.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					l_name := l_cursor.item.name.as_lower
					l_name.left_adjust
					l_name.right_adjust
					metric_table_internal.force (l_cursor.item, l_name)
					l_cursor.forth
				end
			end
			Result := metric_table_internal
		ensure
			result_attached: Result /= Void
		end

	metric_table_internal: like metric_table
			-- Implementation of `metric_table'

feature{NONE} -- Implementation

	grid: ES_GRID
			-- Grid used to display metrics to be imported

	existing_metrics: LIST [EB_METRIC]
			-- List of existing metrics
		do
			Result := metric_manager.metrics
		ensure
			result_attached: Result /= Void
		end

	predefined_metrics: HASH_TABLE [EB_METRIC, STRING]
			-- Table of predefined metrics, key is metric name, value is that metric
		local
			l_metrics: like existing_metrics
			l_metric: EB_METRIC
			l_name: STRING
		do
			l_metrics := existing_metrics
			create Result.make (50)
			from
				l_metrics.start
			until
				l_metrics.after
			loop
				l_metric := l_metrics.item
				if l_metric.is_predefined then
					l_name := l_metric.name.twin
					l_name.left_adjust
					l_name.right_adjust
					l_name.to_lower
					Result.force (l_metric, l_name)
				end
				l_metrics.forth
			end
		ensure
			result_attached: Result /= Void
		end

	file_open_dialog: EB_FILE_OPEN_DIALOG
			-- Dialog to open a file

	delayed_check_import_file_timer: ES_DELAYED_ACTION
			-- Dealyed timer to check if a file has been entered in `file_name_combo'

	metrics_from_file (a_file_name: PATH): LIST [EB_METRIC]
			-- Load metrics from file `a_file_name'.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
		do
			metric_manager.clear_last_error
			Result := metric_manager.metrics_from_file (a_file_name)
			if metric_manager.has_error then
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (metric_manager.last_error.message_with_location, Current, Void)
			end
			metric_manager.clear_last_error
		end

	bind_grid (a_keep_selection: BOOLEAN)
			-- Bind `load_metrics_and_display_error' in `grid'.
			-- If `a_keep_selection' is True, try to keep focus on current selected row.
		require
			metrics_loaded: is_metrics_loaded
		local
			l_metrics: like metric_rows
			l_metric_row: EB_METRIC_IMPORT_GRID_ROW
			l_grid_row: EV_GRID_ROW
			l_grid: like grid
			l_cursor: like metric_rows.new_cursor
			l_missing_metrics: LINKED_LIST [STRING]
			l_unselected_metrics: LINKED_LIST [STRING]
			l_current_selected_metric: EB_METRIC_IMPORT_GRID_ROW
			l_selected_rows: LIST [EV_GRID_ROW]
		do
			l_grid := grid
			if a_keep_selection then
				l_selected_rows := l_grid.selected_rows
				if not l_selected_rows.is_empty then
					l_current_selected_metric ?= l_selected_rows.first.data
				end
			end
			l_grid.remove_and_clear_all_rows
			l_metrics := metric_rows
			from
				l_cursor := l_metrics.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_grid.insert_new_row (l_grid.row_count + 1)
				l_grid_row := l_grid.row (l_grid.row_count)
				l_metric_row := l_cursor.item
				create l_missing_metrics.make
				create l_unselected_metrics.make
				missing_or_not_selected_metrics (l_metric_row, l_missing_metrics, l_unselected_metrics)
				l_metric_row.bind_row (l_grid_row, has_existing_metric (l_metric_row.name), l_missing_metrics, l_unselected_metrics)
				l_metric_row.selection_change_actions.wipe_out
				l_metric_row.name_change_actions.wipe_out
				l_metric_row.selection_change_actions.extend (agent on_metric_selection_change)
				l_metric_row.name_change_actions.extend (agent on_metric_name_change)
				if a_keep_selection and then l_current_selected_metric /= Void then
					if l_metric_row = l_current_selected_metric then
						l_grid_row.enable_select
					end
				end
				l_cursor.forth
			end
			auto_resize_grid
		end

	activate_item (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM)
			-- Activate `a_item'.
		local
			l_editable_item: EV_GRID_EDITABLE_ITEM
		do
			if a_button = 1 then
				l_editable_item ?= a_item
				if l_editable_item /= Void then
					l_editable_item.activate
				end
			end
		end

	change_name (a_old_name: STRING; a_new_name: STRING)
			-- Change metric named `a_old_name' in `load_metrics_and_display_error' to a new name `a_new_name'.
		require
			metrics_loaded: is_metrics_loaded
			a_old_name_valid: a_old_name /= Void and then not a_old_name.is_empty
			a_new_name_valid: a_new_name /= Void and then not a_new_name.is_empty
			a_old_name_exists: has_metric (a_old_name)
			a_new_name_not_cause_name_crash: not has_metric (a_new_name)
		local
			l_renamer: EB_METRIC_RENAME_VISITOR
			l_cursor: like metric_rows.new_cursor
		do
			create l_renamer.make (a_old_name, a_new_name)
			from
				l_cursor := metric_rows.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_renamer.process_metric (l_cursor.item.metric)
				l_cursor.forth
			end
			metric_table_internal := Void
		end

	transitive_referenced_metrics (a_metric: EB_METRIC_IMPORT_GRID_ROW; a_metric_set: HASH_TABLE [EB_METRIC_IMPORT_GRID_ROW, STRING])
			-- Store transitive referenced metrics by `a_metric' in `a_metric_set'.
			-- For example, if `a_metric' is a linear metric, all its variable metrics are referenced metrics,
			-- and all referenced metrics of those variable metrics are referenced metrics also.
		require
			a_metric_attached: a_metric /= Void
			a_metric_set_attached: a_metric_set /= Void
		local
			l_referenced_metrics: LIST [STRING]
			l_metric: EB_METRIC_IMPORT_GRID_ROW
			l_name: STRING
		do
			l_referenced_metrics := a_metric.metric.direct_referenced_metrics
			if not l_referenced_metrics.is_empty then
				from
					l_referenced_metrics.start
				until
					l_referenced_metrics.after
				loop
					l_name := l_referenced_metrics.item.as_lower
					l_name.left_adjust
					l_name.right_adjust
					l_metric := metric_table.item (l_name)
					if l_metric /= Void then
						if not a_metric_set.has (l_name) then
							a_metric_set.force (l_metric, l_name)
							transitive_referenced_metrics (l_metric, a_metric_set)
						end
					else
						a_metric_set.force (Void, l_referenced_metrics.item)
					end
					l_referenced_metrics.forth
				end
			end
		end

	missing_referenced_metrics (a_metric: EB_METRIC_IMPORT_GRID_ROW): LIST [STRING]
			-- List of metric names which are referenced recursively in `a_metric' and not found in `metric_rows'.
		require
			metrics_loaded: is_metrics_loaded
			a_metric_attached: a_metric /= Void
		local
			l_referenced_metrics: HASH_TABLE [EB_METRIC_IMPORT_GRID_ROW, STRING]
			l_predefined_metrics: like predefined_metrics
			l_name, l_ori_name: STRING
			l_metric: EB_METRIC_IMPORT_GRID_ROW
		do
			create {LINKED_LIST [STRING]} Result.make
			create l_referenced_metrics.make (10)
			transitive_referenced_metrics (a_metric, l_referenced_metrics)
			if not l_referenced_metrics.is_empty then
				l_predefined_metrics := predefined_metrics
				from
					l_referenced_metrics.start
				until
					l_referenced_metrics.after
				loop
					l_metric := l_referenced_metrics.item_for_iteration
					if l_metric /= Void then
						l_ori_name := l_metric.name.twin
						if not l_metric.is_selected then
							Result.extend (l_ori_name)
						end
					else
						l_ori_name := l_referenced_metrics.key_for_iteration
						l_name := l_ori_name.twin
						l_name.left_adjust
						l_name.right_adjust
						if not l_predefined_metrics.has (l_name) then
							Result.extend (l_ori_name)
						end
					end
					l_referenced_metrics.forth
				end
			end
		ensure
			result_attached: Result /= Void
		end

	missing_or_not_selected_metrics (a_metric: EB_METRIC_IMPORT_GRID_ROW; a_missing_metrics: LIST [STRING]; a_unselected_metrics: LIST [STRING])
			-- Given `a_metric', fill `a_missing_metrics' and `a_unselected_metrics' with its
			-- missing and unselected recursively referenced metrics respectively.
		require
			a_metric_attached: a_metric /= Void
			a_missing_metrics_attached: a_missing_metrics /= Void
			a_unselected_metrics_attached: a_unselected_metrics /= Void
		local
			l_referenced_metrics: HASH_TABLE [EB_METRIC_IMPORT_GRID_ROW, STRING]
			l_predefined_metrics: like predefined_metrics
			l_name, l_ori_name: STRING
			l_metric: EB_METRIC_IMPORT_GRID_ROW
		do
			create l_referenced_metrics.make (10)
			transitive_referenced_metrics (a_metric, l_referenced_metrics)
			if not l_referenced_metrics.is_empty then
				l_predefined_metrics := predefined_metrics
				from
					l_referenced_metrics.start
				until
					l_referenced_metrics.after
				loop
					l_metric := l_referenced_metrics.item_for_iteration
					if l_metric /= Void then
						l_ori_name := l_metric.name.twin
						if not l_metric.is_selected then
							a_unselected_metrics.extend (l_ori_name)
						end
					else
						l_ori_name := l_referenced_metrics.key_for_iteration
						l_name := l_ori_name.twin
						l_name.left_adjust
						l_name.right_adjust
						if not l_predefined_metrics.has (l_name) then
							a_missing_metrics.extend (l_ori_name)
						end
					end
					l_referenced_metrics.forth
				end
			end
		end

	is_in_name_changing_mode: BOOLEAN
			-- Is in name changing mode?

	is_in_selection_changing_mode: BOOLEAN
			-- Is current in selection changing mode?

	selected_metrics: LIST [EB_METRIC_IMPORT_GRID_ROW]
			-- List of selected metric in `grid'		
		require
			metrics_loaded: is_metrics_loaded
		local
			l_rows: like metric_rows
			l_cursor: like metric_rows.new_cursor
		do
			create {LINKED_LIST [EB_METRIC_IMPORT_GRID_ROW]} Result.make
			l_rows := metric_rows
			from
				l_cursor := l_rows.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				if l_cursor.item.is_selected then
					Result.extend (l_cursor.item)
				end
				l_cursor.forth
			end
		ensure
			result_attached: Result /= Void
		end

	is_metric_ready_to_be_imported: BOOLEAN
			-- Are metrics ready to be imported?
			-- Ready means:
			--	1. At least one metric has been selected.
			--	2. All selected metrics will cause no name crash in existing metrics.
		local
			l_selected_metrics: like selected_metrics
		do
			l_selected_metrics := selected_metrics
			if not l_selected_metrics.is_empty then
				Result := l_selected_metrics.for_all (agent (a_metric: EB_METRIC_IMPORT_GRID_ROW): BOOLEAN do Result := not a_metric.has_name_crash end)
			end
		end

	record_loaded_metric_file (a_file: STRING)
			-- Record `a_file' into file list of `file_name_combo'.
		require
			a_file_attached: a_file /= Void
		local
			l_name_combo: like file_name_combo
			l_exists: BOOLEAN
		do
			l_name_combo := file_name_combo
			from
				l_name_combo.start
			until
				l_name_combo.after or l_exists
			loop
				l_exists := l_name_combo.item.text.is_equal (a_file)
				l_name_combo.forth
			end
			if not l_exists then
				if l_name_combo.count = 10 then
					l_name_combo.go_i_th (10)
					l_name_combo.remove
				end
				l_name_combo.put_front (create {EV_LIST_ITEM}.make_with_text (a_file))
			end
		end

	is_metric_ok (a_metric: EB_METRIC_IMPORT_GRID_ROW): BOOLEAN
			-- Is `a_metric' OK for import?
			-- e.g., it has no name crash and all its recursively referenced metrics can be found and have no name crash either.
		require
			a_metric_attached: a_metric /= Void
		local
			l_referenced_metrics: HASH_TABLE [EB_METRIC_IMPORT_GRID_ROW, STRING]
			l_predefined_metrics: like predefined_metrics
			l_name: STRING
		do
			Result := not a_metric.has_name_crash
			if Result then
				create l_referenced_metrics.make (36)
				transitive_referenced_metrics (a_metric, l_referenced_metrics)
				if not l_referenced_metrics.is_empty then
					l_predefined_metrics := predefined_metrics
					from
						l_referenced_metrics.start
					until
						l_referenced_metrics.after or not Result
					loop
						if l_referenced_metrics.item_for_iteration /= Void then
							Result := is_metric_ok (l_referenced_metrics.item_for_iteration)
						else
							l_name := l_referenced_metrics.key_for_iteration.twin
							l_name.left_adjust
							l_name.right_adjust
							l_name.to_lower
							Result := l_predefined_metrics.has (l_name)
						end
						l_referenced_metrics.forth
					end
				end
			end
		end

	library_uuid_table: STRING_TABLE [READABLE_STRING_GENERAL]
			-- Table of UUIDs from all referenced libraries of current application			
			-- Key is string representation of a UUID, value is the library name with that UUID.
		local
			l_libraries: STRING_TABLE [CONF_LIBRARY]
		do
			if library_uuid_table_internal = Void then
				create library_uuid_table_internal.make (16)
				l_libraries := universe.conf_system.application_target.libraries
				if l_libraries /= Void then
					from
						l_libraries.start
					until
						l_libraries.after
					loop
						if l_libraries.item_for_iteration.library_target /= Void then
							library_uuid_table_internal.force (l_libraries.key_for_iteration, l_libraries.item_for_iteration.library_target.system.uuid.string)
						end
						l_libraries.forth
					end
				end
			end
			Result := library_uuid_table_internal
		ensure
			result_attached: Result /= Void
		end

	library_uuid_table_internal: like library_uuid_table
			-- Implementation of `library_uuid_table'

	update_import_button_status
			-- Update sensitivity status of `import_btn' according to current metrics' selections.
		do
			if is_metric_ready_to_be_imported then
				import_btn.enable_sensitive
			else
				import_btn.disable_sensitive
			end
		end

	backup_metrics_dialog: EB_METRIC_BACKUP_METRICS_DIALOG
			-- Dialog to backup user-defined metrics

	auto_resize_grid
			-- Auto resize columns in `grid'.
		local
			l_size_table: HASH_TABLE [TUPLE [INTEGER, INTEGER], INTEGER]
			l_font: EV_FONT
		do
			if not has_grid_resized then
				create l_font
				create l_size_table.make (6)
				l_size_table.put ([l_font.string_width (metric_names.t_import) + 20, 150], 1)
				l_size_table.put ([l_font.string_width (metric_names.t_status) + 20, 150], 2)
				l_size_table.put ([100, 300], 3)
				l_size_table.put ([130, 300], 4)
				l_size_table.put ([100, 200], 5)
				auto_resize_columns (grid, l_size_table)
				has_grid_resized := True
			end
		end

feature{NONE} -- Order testers

	import_order_tester (a_row, b_row: EB_METRIC_IMPORT_GRID_ROW; a_order: INTEGER): BOOLEAN
			-- Tester to decide order between `a_row' and `b_row' using import information
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		do
			if a_order = ascending_order then
				Result := a_row.is_selected and then not b_row.is_selected
			else
				Result := not a_row.is_selected and then b_row.is_selected
			end
		end

	unit_order_tester (a_row, b_row: EB_METRIC_IMPORT_GRID_ROW; a_order: INTEGER): BOOLEAN
			-- Tester to decide order between `a_row' and `b_row' using unit information
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		do
			if a_order = ascending_order then
				Result := a_row.unit.name < b_row.unit.name
			else
				Result := a_row.unit.name >= b_row.unit.name
			end
		end

	name_order_tester (a_row, b_row: EB_METRIC_IMPORT_GRID_ROW; a_order: INTEGER): BOOLEAN
			-- Tester to decide order between `a_row' and `b_row' using name information
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		do
			if a_order = ascending_order then
				Result := a_row.name < b_row.name
			else
				Result := a_row.name >= b_row.name
			end
		end

	original_name_order_tester (a_row, b_row: EB_METRIC_IMPORT_GRID_ROW; a_order: INTEGER): BOOLEAN
			-- Tester to decide order between `a_row' and `b_row' using original name information
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		do
			if a_order = ascending_order then
				Result := a_row.original_name < b_row.original_name
			else
				Result := a_row.original_name >= b_row.original_name
			end
		end

	status_order_tester (a_row, b_row: EB_METRIC_IMPORT_GRID_ROW; a_order: INTEGER): BOOLEAN
			-- Tester to decide order between `a_row' and `b_row' using status information
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		local
			l_a_order: INTEGER
			l_b_order: INTEGER
		do
			l_a_order := status_order (a_row)
			l_b_order := status_order (b_row)
			if a_order = ascending_order then
				Result := l_a_order <= l_b_order
			else
				Result := l_b_order <= l_a_order
			end
		end

	status_order (a_metric: EB_METRIC_IMPORT_GRID_ROW): INTEGER
			-- Order of status of `a_metric'
		require
			a_metric_attached: a_metric /= Void
		do
			if a_metric.has_name_crash then
				Result := 2
			elseif a_metric.has_warning then
				Result := 1
			end
		end

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EB_METRIC_IMPORT_GRID_ROW])
			-- Action used to sort.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty:
		local
			l_sorter: QUICK_SORTER [EB_METRIC_IMPORT_GRID_ROW]
		do
			if grid.row_count > 0 then
				create l_sorter.make (a_comparator)
				l_sorter.sort (metric_rows)
				bind_grid (True)
			end
		end

	has_existing_metric (a_name: STRING): BOOLEAN
			-- Dose metric named `a_name' exist in `existing_metrics'?
		require
			a_name_attached: a_name /= Void
		local
			l_metrics: like existing_metrics
			l_manager: like metric_manager
		do
			l_metrics := existing_metrics
			from
				l_manager := metric_manager
				l_metrics.start
			until
				l_metrics.after or Result
			loop
				Result := l_manager.is_metric_name_equal (l_metrics.item.name, a_name)
				l_metrics.forth
			end
		end

feature{NONE} -- Process

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM)
			-- Process `a_item'.
		local
			l_libraries: like library_uuid_table
			l_id: STRING
		do
			if a_item.library_target_uuid /= Void then
				l_libraries := library_uuid_table
				if l_libraries.has (a_item.library_target_uuid) then
					l_id := substitute_target_uuid (a_item.id.twin, universe.target.system.uuid.out)
					l_id := substitute_target_name (l_id, universe.target.name)
					l_id := substitute_group (l_id, l_libraries.item (a_item.library_target_uuid))
					a_item.set_id (l_id)
				end
			end
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item (a_item)
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item (a_item)
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item (a_item)
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item (a_item)
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item (a_item)
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item (a_item)
		end

invariant
	grid_attached: grid /= Void
	delayed_check_import_file_timer_attached: delayed_check_import_file_timer /= Void
	file_open_dialog_attached: file_open_dialog /= Void
	backup_metrics_dialog_attached: backup_metrics_dialog /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
end
