indexing
	description: "Universal constants about dates"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date

class DATE_CONSTANTS inherit

	TIME_UTILITY
		export
			{NONE} all
		end

feature -- Access

	Days_in_week: INTEGER is 7
				-- Number of days in a week

	Max_weeks_in_year: INTEGER is 53
				-- Maximun number of weeks in a year 
 
	Months_in_year: INTEGER is 12
				-- Number of months in year
	
	Days_in_leap_year: INTEGER is 366
				-- Number of days in a leap year 

	Days_in_non_leap_year: INTEGER is 365
				-- Number of days in a non-leap year

	days_in_i_th_month (i, y: INTEGER): INTEGER is 
			-- Number of days in the `i' th month at year `y' 
		require 
			i_large_enough: i >= 1; 
			i_small_enough: i <= Months_in_year 
		do 
			Result := Days_in_months @ i; 
			if i = 2 and then is_leap_year (y) then
				Result := Result + 1 
			end 
		end; 

	date_default_format_string: STRING is
			-- Default output format for dates
		do
			Result := date_time_tools.date_default_format_string
		end

	days_text: ARRAY [STRING] is
			-- Short text representation of days
		do
			Result := date_time_tools.days_text
		end

	months_text: ARRAY [STRING] is
			-- Short text representation of months
		do
			Result := date_time_tools.months_text
		end

	long_days_text: ARRAY [STRING] is
			-- Long text representation of days
		do
			Result := date_time_tools.long_days_text
		end

	long_months_text: ARRAY [STRING] is
			-- Long text representation of months
		do
			Result := date_time_tools.long_months_text
		end

feature -- Status report

	i_th_leap_year (i: INTEGER): BOOLEAN is 
		obsolete "Use `is_leap_year' instead."
			-- Is the `i'-th year a leap year? 
		do 
			Result := is_leap_year (i)
		end

	is_leap_year (y: INTEGER): BOOLEAN is 
			-- Is year `y' a leap year? 
		do 
			Result := (mod (y, 4) = 0) and ((mod (y, 100) /= 0) or 
				(mod (y, 400) = 0)) 
		end

feature {NONE} -- Implementation

	Days_in_months: ARRAY [INTEGER] is 
			-- Array containing number of days for each month of
			-- a non-leap year.
		once
			Result := <<31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31>>
		ensure
			result_exists: Result /= Void
			valid_count: Result.count = Months_in_year
		end

end -- class DATE_CONSTANTS



--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

