indexing
	description: "Implemented `IEnumClusterExcludes' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IENUM_CLUSTER_EXCLUDES_IMPL_STUB

inherit
	IENUM_CLUSTER_EXCLUDES_INTERFACE

	ECOM_STUB

feature -- Access

	count: INTEGER is
			-- No description available.
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	next (rgelt: CELL [STRING]; pcelt_fetched: INTEGER_REF) is
			-- No description available.
			-- `rgelt' [out].  
			-- `pcelt_fetched' [out].  
		do
			-- Put Implementation here.
		end

	skip (celt: INTEGER) is
			-- No description available.
			-- `celt' [in].  
		do
			-- Put Implementation here.
		end

	reset is
			-- No description available.
		do
			-- Put Implementation here.
		end

	clone1 (ppenum: CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE]) is
			-- No description available.
			-- `ppenum' [out].  
		do
			-- Put Implementation here.
		end

	ith_item (an_index: INTEGER; rgelt: CELL [STRING]) is
			-- No description available.
			-- `an_index' [in].  
			-- `rgelt' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IENUM_CLUSTER_EXCLUDES_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEnumClusterExcludes_impl_stub %"ecom_eiffel_compiler_IEnumClusterExcludes_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IENUM_CLUSTER_EXCLUDES_IMPL_STUB

