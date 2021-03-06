note
	description: "Picture Object OLE Automation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPICTURE_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	handle_user_precondition: BOOLEAN
			-- User-defined preconditions for `handle'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	h_pal_user_precondition: BOOLEAN
			-- User-defined preconditions for `h_pal'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	type_user_precondition: BOOLEAN
			-- User-defined preconditions for `type'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	width_user_precondition: BOOLEAN
			-- User-defined preconditions for `width'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	height_user_precondition: BOOLEAN
			-- User-defined preconditions for `height'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	render_user_precondition (hdc: INTEGER; x: INTEGER; y: INTEGER; cx: INTEGER; cy: INTEGER; x_src: INTEGER; y_src: INTEGER; cx_src: INTEGER; cy_src: INTEGER; prc_wbounds: POINTER): BOOLEAN
			-- User-defined preconditions for `render'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_h_pal_user_precondition (phpal: INTEGER): BOOLEAN
			-- User-defined preconditions for `set_h_pal'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	cur_dc_user_precondition: BOOLEAN
			-- User-defined preconditions for `cur_dc'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	select_picture_user_precondition (hdc_in: INTEGER; phdc_out: INTEGER_REF; phbmp_out: INTEGER_REF): BOOLEAN
			-- User-defined preconditions for `select_picture'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	keep_original_format_user_precondition: BOOLEAN
			-- User-defined preconditions for `keep_original_format'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_keep_original_format_user_precondition (pfkeep: BOOLEAN): BOOLEAN
			-- User-defined preconditions for `set_keep_original_format'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	picture_changed_user_precondition: BOOLEAN
			-- User-defined preconditions for `picture_changed'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	save_as_file_user_precondition (pstm: POINTER; f_save_mem_copy: BOOLEAN; pcb_size: INTEGER_REF): BOOLEAN
			-- User-defined preconditions for `save_as_file'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	attributes_user_precondition: BOOLEAN
			-- User-defined preconditions for `attributes'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_hdc_user_precondition (hdc: INTEGER): BOOLEAN
			-- User-defined preconditions for `set_hdc'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	handle: INTEGER
			-- No description available.
		require
			handle_user_precondition: handle_user_precondition
		deferred

		end

	h_pal: INTEGER
			-- No description available.
		require
			h_pal_user_precondition: h_pal_user_precondition
		deferred

		end

	type: INTEGER
			-- No description available.
		require
			type_user_precondition: type_user_precondition
		deferred

		end

	width: INTEGER
			-- No description available.
		require
			width_user_precondition: width_user_precondition
		deferred

		end

	height: INTEGER
			-- No description available.
		require
			height_user_precondition: height_user_precondition
		deferred

		end

	render (hdc: INTEGER; x: INTEGER; y: INTEGER; cx: INTEGER; cy: INTEGER; x_src: INTEGER; y_src: INTEGER; cx_src: INTEGER; cy_src: INTEGER; prc_wbounds: POINTER)
			-- No description available.
			-- `hdc' [in].
			-- `x' [in].
			-- `y' [in].
			-- `cx' [in].
			-- `cy' [in].
			-- `x_src' [in].
			-- `y_src' [in].
			-- `cx_src' [in].
			-- `cy_src' [in].
			-- `prc_wbounds' [in].
		require
			render_user_precondition: render_user_precondition (hdc, x, y, cx, cy, x_src, y_src, cx_src, cy_src, prc_wbounds)
		deferred

		end

	set_h_pal (phpal: INTEGER)
			-- No description available.
			-- `phpal' [in].
		require
			set_h_pal_user_precondition: set_h_pal_user_precondition (phpal)
		deferred

		end

	cur_dc: INTEGER
			-- No description available.
		require
			cur_dc_user_precondition: cur_dc_user_precondition
		deferred

		end

	select_picture (hdc_in: INTEGER; phdc_out: INTEGER_REF; phbmp_out: INTEGER_REF)
			-- No description available.
			-- `hdc_in' [in].
			-- `phdc_out' [out].
			-- `phbmp_out' [out].
		require
			non_void_phdc_out: phdc_out /= Void
			non_void_phbmp_out: phbmp_out /= Void
			select_picture_user_precondition: select_picture_user_precondition (hdc_in, phdc_out, phbmp_out)
		deferred

		end

	keep_original_format: BOOLEAN
			-- No description available.
		require
			keep_original_format_user_precondition: keep_original_format_user_precondition
		deferred

		end

	set_keep_original_format (pfkeep: BOOLEAN)
			-- No description available.
			-- `pfkeep' [in].
		require
			set_keep_original_format_user_precondition: set_keep_original_format_user_precondition (pfkeep)
		deferred

		end

	picture_changed
			-- No description available.
		require
			picture_changed_user_precondition: picture_changed_user_precondition
		deferred

		end

	save_as_file (pstm: POINTER; f_save_mem_copy: BOOLEAN; pcb_size: INTEGER_REF)
			-- No description available.
			-- `pstm' [in].
			-- `f_save_mem_copy' [in].
			-- `pcb_size' [out].
		require
			non_void_pcb_size: pcb_size /= Void
			save_as_file_user_precondition: save_as_file_user_precondition (pstm, f_save_mem_copy, pcb_size)
		deferred

		end

	attributes: INTEGER
			-- No description available.
		require
			attributes_user_precondition: attributes_user_precondition
		deferred

		end

	set_hdc (hdc: INTEGER)
			-- No description available.
			-- `hdc' [in].
		require
			set_hdc_user_precondition: set_hdc_user_precondition (hdc)
		deferred

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




end -- IPICTURE_INTERFACE

