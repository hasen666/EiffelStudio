indexing
	description: "OLE Automation."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	FONTSIZE_ALIAS

inherit
	ECOM_CURRENCY

create
	make,
	make_by_pointer,
	make_from_alias

feature {None}  -- Initialization

	make_from_alias (an_alias: ECOM_CURRENCY) is
			-- Create from alias
		require
			non_void_alias: an_alias /= Void
		do
			make_by_pointer (an_alias.item)
			an_alias.set_shared
		end

end -- FONTSIZE_ALIAS

