note

	description: 
		"Shared instance of dispatcher for MEL"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SHARED_MEL_DISPATCHER

feature {NONE} -- Access

	Mel_dispatcher: MEL_DISPATCHER
			-- MEL dispatcher manager
		once
			create Result.make
		ensure
			valid_result: Result /= void
		end;

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




end -- class SHARED_MEL_DISPATCHER


