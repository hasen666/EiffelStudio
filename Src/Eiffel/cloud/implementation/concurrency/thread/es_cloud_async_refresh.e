note
	description: "Asynchronous call to refresh_token."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ASYNC_REFRESH

create
	make

feature {NONE} -- Initialization

	make (a_access_token: ES_ACCOUNT_ACCESS_TOKEN; a_server_url: READABLE_STRING_8)
		require
			has_refresh_key: a_access_token.has_refresh_key
		do
			access_token := a_access_token
			create server_url.make_from_string (a_server_url)
		end

	access_token: ES_ACCOUNT_ACCESS_TOKEN

	server_url: IMMUTABLE_STRING_8

feature -- Output

	refreshed_token: detachable ES_ACCOUNT_ACCESS_TOKEN

feature -- Access

	execute
		local
			wt: WORKER_THREAD
		do
			if attached access_token.refresh_key as k then
				create wt.make (agent refresh_token (create {IMMUTABLE_STRING_8}.make_from_string (access_token.token), create {IMMUTABLE_STRING_8}.make_from_string (k)))
				wt.launch
			end
		end

	refresh_token (a_token: READABLE_STRING_8; a_refresh_key: READABLE_STRING_8)
		local
			wapi: ES_CLOUD_API
		do
			print ("Going to ping%N")
			(create {EXECUTION_ENVIRONMENT}).sleep (10_000_000_000)
			create wapi.make (server_url)
			print ("Pinging%N")
			refreshed_token := wapi.refreshing_token (a_token, a_refresh_key)
			print ("Ping done.%N")
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
