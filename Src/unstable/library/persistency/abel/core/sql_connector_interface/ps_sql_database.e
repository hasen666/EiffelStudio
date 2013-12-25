note
	description: "[
		Provides the interface for a wrapper to a database like MySQL or SQlite.
		Descendants may implement connection pooling, or just open and close connections all the time.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_SQL_DATABASE

inherit

	PS_ABEL_EXPORT

feature {PS_ABEL_EXPORT}

	acquire_connection: PS_SQL_CONNECTION
			-- Get a new connection.
			-- The transaction isolation level of the new connection is the same as in `Current.transaction_isolation_level', and autocommit is disabled.
		deferred
			-- Remarks when implementing this feature:
			-- You can create a new connection to the database or use a pool of connections.
			-- It is also possible to run ABEL with only one connection. However, note that to do this, you have to ensure the following:
				-- This function always returns the same connection (the only one you have).
				-- `release_connection' should not close it
				-- Autocommit always has to stay disabled
				-- To have proper transaction support, you should create ABEL with client-side transaction management support enabled.
		ensure
			autocommit_disabled: not Result.autocommit
		end

	release_connection (a_connection: PS_SQL_CONNECTION)
			-- Release connection `a_connection'.
		deferred
				-- Remarks when implementing this feature:
				-- Close it or add it back to the pool of free connections.
				-- If you only have one connection, don't do anything.
		end

	close_connections
			-- Close all currently open connections.
		deferred
		end

	set_transaction_isolation (settings: PS_TRANSACTION_SETTINGS)
			-- Set the transaction isolation level such that all values in `settings' are respected.
		deferred
		end

end
