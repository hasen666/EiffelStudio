

class DR_AREA_C 

inherit

	CONTEXT
		rename
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags,
			initialize_transport as old_initialize_transport
		redefine
			add_widget_callbacks, stored_node, 
			context_initialization, widget
		end;

	CONTEXT
		redefine
			initialize_transport, 
			reset_modified_flags, copy_attributes,
			add_widget_callbacks, stored_node, 
			context_initialization, widget
		select
			reset_modified_flags, copy_attributes,
			initialize_transport
		end

feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.drawing_area_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.scroll_page.drawing_area_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!! widget.make_unmanaged (entity_name, a_parent);
			set_size (80, 80);
			set_drawing_area_size (1000, 1000);
		end;

	widget: DRAWING_BOX;
	
feature {NONE}

	add_widget_callbacks is
		do
			add_common_callbacks (widget);
			add_common_callbacks (widget.scrolled_window);
			initialize_transport;
			if (parent = Void) or else not parent.is_group_composite then
				 widget.scrolled_window.add_enter_action (eb_selection_mgr, Current);
			end;
		end;

	initialize_transport is
		do
			old_initialize_transport;
			widget.scrolled_window.add_button_press_action (3, transport_command, Current);
		end;

	namer: NAMER is
		once
			!!Result.make ("Drawing_box");
		end;
	
	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr); 
			opt_list.put (Context_const.drawing_box_att_form_nbr,
					Context_const.Attribute_format_nbr)
		end;

feature 

	eiffel_type: STRING is "DRAWING_BOX";

	-- ***********************
	-- * specific attributes *
	-- **,*********************

	set_fg_color_name (a_name: STRING) is
		local
			a_color: COLOR;
		do
			if a_name = Void or else a_name.empty then
				fg_color_modified := False;
				fg_color_name := Void;
				a_color := default_foreground_color;
				if a_color /= Void then
					widget.set_foreground_color (a_color)
				end
			else
				if fg_color_name = Void then
					save_default_foreground_color
				end;
				fg_color_name := a_name;
				fg_color_modified := True;
				!!a_color.make;
				a_color.set_name (a_name);
				widget.set_foreground_color (a_color)
			end;
		end;

	save_default_foreground_color is
		do
			if default_foreground_color = Void then
				default_foreground_color := widget.foreground_color
			end
		end;

	reset_default_foreground_color is
		do
			widget.set_foreground_color (default_foreground_color);
		end;

	drawing_area_width: INTEGER is
		do
			Result := widget.drawing_area_width
		end;

	drawing_area_height: INTEGER is
		do
			Result := widget.drawing_area_height
		end;

	drawing_area_size_modified: BOOLEAN;

	set_drawing_area_size (new_w, new_h: INTEGER) is
		do
			drawing_area_size_modified := True;
			widget.set_drawing_area_size (new_w, new_h)
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			drawing_area_size_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if drawing_area_size_modified then
				other_context.set_drawing_area_size (drawing_area_width, drawing_area_height)
			end;
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if drawing_area_size_modified then
				function_int_int_to_string (Result, context_name, "set_drawing_area_size", drawing_area_width, drawing_area_height);
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_DR_AREA is
		do
			!!Result.make (Current);
		end;

end
