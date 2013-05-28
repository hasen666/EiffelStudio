note
	description: "An Eiffel pixmap matrix accessor, generated by Eiffel Matrix Generator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	SD_ICONS_16_16

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize matrix
		local
			retried: BOOLEAN
		do
			if not retried then
				create {SD_ICON_MATRIX_16_16} raw_buffer.make
			else
					-- Fail safe, use blank pixmap
				create raw_buffer.make_with_size ((3 * 16) + 1,(1 * 16) + 1)
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	pixel_width: INTEGER = 16
			-- Element width

	pixel_height: INTEGER = 16
			-- Element width

	width: INTEGER = 3
			-- Matrix width

	height: INTEGER = 1
			-- Matrix height

	frozen zone_close_icon: EV_PIXMAP
			-- Access to 'close' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (1, 1))
		end

	frozen zone_close_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'close' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (1, 1))
		end

	frozen zone_close_all_icon: EV_PIXMAP
			-- Access to 'close all' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (2, 1))
		end

	frozen zone_close_all_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'close all' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (2, 1))
		end

	frozen editor_area_icon: EV_PIXMAP
			-- Access to 'editor area' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (3, 1))
		end

	frozen editor_area_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'editor area' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (3, 1))
		end

feature {NONE} -- Query

	frozen pixel_rectangle (a_x: INTEGER; a_y: INTEGER): EV_RECTANGLE
			-- Retrieves a pixmap from matrix coordinates `a_x', `a_y'	
		require
			a_x_positive: a_x > 0
			a_x_small_enough: a_x <= 3
			a_y_positive: a_y > 0
			a_y_small_enough: a_y <= 1
		local
			l_x_offset: INTEGER
			l_y_offset: INTEGER
		do
			l_x_offset := ((a_x - 1) * (16 + 1)) + 1
			l_y_offset := ((a_y - 1) * (16 + 1)) + 1

			Result := rectangle
			Result.set_x (l_x_offset)
			Result.set_y (l_y_offset)
			Result.set_width (16)
			Result.set_height (16)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	raw_buffer: EV_PIXEL_BUFFER
			-- raw matrix pixel buffer

	frozen rectangle: EV_RECTANGLE
			-- Reusable rectangle for `pixmap_from_constant'.
		once
			create Result
		end

invariant
	raw_buffer_attached: raw_buffer /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class {SD_ICONS_16_16}