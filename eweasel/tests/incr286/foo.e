class
	FOO

create {FOO_FACTORY}
	make

feature -- Make

	make is
		do
			print ("Creation of " + generating_type.name + "%N")
		end


end
