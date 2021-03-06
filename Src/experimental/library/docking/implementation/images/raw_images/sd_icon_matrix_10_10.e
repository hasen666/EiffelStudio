note
	description: "Pixel buffer that replaces orignal image file.%
		%The orignal version of this class has been generated by Image Eiffel Code."
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	SD_ICON_MATRIX_10_10

inherit
	EV_PIXEL_BUFFER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			make_with_size (89, 12)
			fill_memory
		end

feature {NONE} -- Image data

	c_colors_0 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)
				A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(FF,FF,43,5C)A(FF,B7,01,2E)A(FF,9D,02,27)A(FF,70,01,1D)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,B8,C4,FD)A(FF,A8,BA,F8)A(FF,99,B0,F2)A(FF,89,A7,ED)A(FF,79,9D,E7)A(FF,6A,93,E2)A(FF,5A,89,DD)A(FF,4A,7F,D7)A(FF,3A,76,D2)A(FF,2B,6C,CC)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,D1,DC,FF)A(FF,C0,D0,FF)A(FF,AE,C6,FF)A(FF,9C,BA,FC)A(FF,8A,B0,F5)A(FF,78,A4,EF)A(FF,55,8E,E3)A(FF,DA,E2,F3)A(FF,D4,DF,F2)A(FF,34,60,AC)A(FF,34,60,AC)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,34,60,AC)A(FF,34,60,AC)A(FF,D4,DF,F2)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)
				A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(FF,FF,80,8F)A(FF,D1,00,34)A(FF,B7,01,2E)A(FF,70,01,1D)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,A8,BA,F8)A(FF,9B,B2,F3)A(FF,8F,AA,EF)A(FF,82,A2,EA)A(FF,76,9A,E6)A(FF,69,92,E1)A(FF,5C,8B,DC)A(FF,50,83,D8)A(FF,43,7B,D3)A(FF,37,73,CF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,BC,CF,FF)A(FF,B5,CA,FF)A(FF,A7,C1,FF)A(FF,99,B8,FA)A(FF,8A,AF,F5)A(FF,7C,A6,F0)A(FF,54,8C,E0)A(FF,DA,E2,F3)A(FF,34,60,AC)A(FF,D4,DF,F2)A(FF,BD,CE,EB)A(FF,34,60,AC)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,34,60,AC)A(FF,BD,CE,EB)A(FF,D4,DF,F2)A(FF,34,60,AC)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)
				A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,28,28,28)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,28,28,28)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,FF,43,5C)A(FF,73,00,00)A(FF,9D,02,27)A(FF,9D,02,27)A(FF,9D,02,27)A(FF,9D,02,27)A(FF,9D,02,27)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(FF,FF,80,8F)A(FF,D1,00,34)A(FF,B7,01,2E)A(FF,70,01,1D)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,99,B0,F2)A(FF,E0,E8,FC)A(FF,DA,E4,FA)A(FF,D4,E0,F8)A(FF,CE,DC,F6)A(FF,C8,D8,F4)A(FF,C1,D4,F3)A(FF,BB,D0,F1)A(FF,B5,CC,EF)A(FF,2A,69,C8)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,A8,C2,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,53,8B,DE)A(FF,DA,E2,F3)A(FF,34,60,AC)A(FF,BD,CE,EB)A(FF,FF,FF,FF)A(FF,BD,CE,EB)A(FF,34,60,AC)A(FF,34,60,AC)A(FF,BD,CE,EB)A(FF,FF,FF,FF)
				A(FF,BD,CE,EB)A(FF,34,60,AC)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DC,DC,DC)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DC,DC,DC)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DE,00,37)A(FF,C1,00,10)A(FF,FF,43,5C)A(FF,FF,80,8F)A(FF,FF,80,8F)A(FF,FF,80,8F)A(FF,FF,43,5C)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(FF,FF,80,8F)A(FF,D1,00,34)A(FF,B7,01,2E)A(FF,70,01,1D)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,89,A7,ED)A(FF,E9,EB,FF)A(FF,EB,ED,FF)A(FF,ED,EF,FF)A(FF,EF,F1,FF)A(FF,F2,F3,FE)A(FF,F4,F5,FE)A(FF,F6,F7,FE)A(FF,F8,F9,FE)A(FF,2A,68,C6)A(FF,DA,E2,F3)A(FF,B8,C4,FD)A(FF,A4,B7,F6)A(FF,90,AB,EF)A(FF,7C,9E,E8)A(FF,67,92,E1)A(FF,53,85,DA)A(FF,2B,6C,CC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,52,89,DA);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_1 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,DA,E2,F3)A(FF,D4,DF,F2)A(FF,34,60,AC)A(FF,BD,CE,EB)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,BD,CE,EB)A(FF,34,60,AC)A(FF,D4,DF,F2)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,28,28,28)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,28,28,28)A(FF,10,10,10)A(FF,DD,DD,DD)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,9D,02,27)A(FF,9D,02,27)A(FF,9D,02,27)A(FF,C8,00,32)A(FF,8D,00,04)A(FF,A7,00,0A)A(FF,D1,00,34)A(FF,D1,00,34)A(FF,D1,00,34)A(FF,B7,01,2E)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(FF,FF,43,5C)A(FF,D1,00,34)A(FF,B7,01,2E)A(FF,70,01,1D)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,79,9D,E7)A(FF,EC,EE,FF)A(FF,F7,F8,FF)A(FF,F5,F5,FF)A(FF,F3,F4,FF)A(FF,F2,F3,FF)A(FF,F1,F2,FF)A(FF,EF,F1,FF)A(FF,F7,F8,FE)A(FF,29,66,C4)A(FF,DA,E2,F3)A(FF,A0,B5,F5)
				A(FF,98,B0,F2)A(FF,88,A6,EC)A(FF,78,9C,E6)A(FF,67,91,E1)A(FF,57,87,DB)A(FF,2A,6A,C9)A(FF,C1,C1,C1)A(FF,FF,FF,FF)A(FF,52,86,D7)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(FF,D4,DF,F2)A(FF,34,60,AC)A(FF,D4,DF,F2)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,D4,DF,F2)A(FF,34,60,AC)A(FF,D4,DF,F2)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DC,DC,DC)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DA,E2,F3)A(FF,00,00,00)A(FF,00,00,00)A(FF,EF,EB,E7)A(00,FF,FF,FF)A(FF,00,00,00)A(FF,00,00,00)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,B2,00,2D)A(FF,73,00,00)A(FF,8D,00,04)A(FF,B7,01,2E)A(FF,B7,01,2E)A(FF,B7,01,2E)A(FF,9D,02,27)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(FF,EB,00,3A)A(FF,B7,01,2E)A(FF,9D,02,27)A(FF,70,01,1D)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,6A,93,E2)A(FF,EF,F0,FF)A(FF,F6,F7,FF)
				A(FF,F3,F4,FF)A(FF,F2,F3,FF)A(FF,F1,F2,FF)A(FF,EF,F1,FF)A(FF,EE,EF,FF)A(FF,F4,F6,FE)A(FF,28,65,C2)A(FF,DA,E2,F3)A(FF,89,A7,ED)A(FF,FC,FC,FC)A(FF,FA,FA,FA)A(FF,F9,F9,F9)A(FF,F8,F8,F8)A(FF,F6,F6,F6)A(FF,29,68,C6)A(FF,C1,C1,C1)A(FF,FF,FF,FF)A(FF,51,84,D5)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,34,60,AC)A(FF,D4,DF,F2)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,D4,DF,F2)A(FF,34,60,AC)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(F7,B6,C3,FD)A(FF,A3,B6,F6)A(FF,8F,AA,EF)A(FF,7B,9E,E8)A(FF,68,92,E2)A(FF,55,86,DB)A(FF,40,79,D4)A(FB,2D,6D,CD)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9C,01,27)A(FF,46,00,00)A(FF,46,00,00)A(FF,46,00,00)A(FF,70,01,1D)A(FF,70,01,1D)A(FF,70,01,1D)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(FF,FF,43,5C)A(FF,DE,00,37)
				A(FF,C8,00,32)A(FF,B2,00,2D)A(FF,9C,01,27)A(FF,86,01,22)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,5A,89,DD)A(FF,F2,F3,FE)A(FF,F5,F5,FF)A(FF,F2,F3,FF)A(FF,F1,F2,FF)A(FF,EF,F1,FF)A(FF,EE,EF,FF)A(FF,ED,EE,FF)A(FF,F2,F3,FE)A(FF,28,64,BF)A(FF,DA,E2,F3)A(FF,72,98,E4)A(FF,FB,FB,FB)A(FF,F9,F9,F9)A(FF,F8,F8,F8)A(FF,F6,F6,F6)A(FF,F5,F5,F5)A(FF,28,66,C2)A(FF,44,6A,A4)A(FF,51,84,D5)A(FF,50,83,D2)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(FF,34,60,AC)A(FF,BD,CE,EB)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,BD,CE,EB)A(FF,34,60,AC)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(CE,A6,B9,F7)A(CE,A6,B9,F7)A(FF,93,AD,F0)A(FF,7E,9F,E9)A(FF,69,92,E1)A(FF,53,85,D9)A(FF,3E,78,D1)A(FF,3E,78,D1)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DD,DD,DD)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,86,01,22)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)
				A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,70,01,1D)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,4A,7F,D7)A(FF,F4,F6,FE)A(FF,F3,F4,FF)A(FF,F1,F2,FF)A(FF,EF,F1,FF)A(FF,EE,EF,FF)A(FF,ED,EE,FF)A(FF,EC,ED,FF)A(FF,EF,F0,FF)A(FF,28,62,BD)A(FF,DA,E2,F3)A(FF,5A,89,DC)A(FF,FA,FA,FA)A(FF,F8,F8,F8)A(FF,F6,F6,F6)A(FF,F5,F5,F5)A(FF,F4,F4,F4)A(FF,28,63,BF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,34,60,AC)A(FF,BD,CE,EB)A(FF,FF,FF,FF)A(FF,BD,CE,EB)A(FF,34,60,AC)A(FF,34,60,AC)A(FF,BD,CE,EB)A(FF,FF,FF,FF)A(FF,BD,CE,EB)A(FF,34,60,AC)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(FF,3A,76,D2)A(FF,FA,FB,FE)A(FF,F8,F9,FE)A(FF,F4,F5,FE)A(FF,F2,F3,FE)A(FF,ED,EF,FF)A(FF,EB,ED,FF)A(FF,27,61,BB)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_2 (a_ptr: POINTER; a_offset: INTEGER)
			-- Fill `a_ptr' with colors data from `a_offset'
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,70,01,1D)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,3A,76,D2)A(FF,FA,FB,FE)A(FF,F8,F9,FE)A(FF,F6,F7,FE)A(FF,F4,F5,FE)A(FF,F2,F3,FE)A(FF,EF,F1,FF)A(FF,ED,EF,FF)A(FF,EB,ED,FF)A(FF,27,61,BB)A(FF,DA,E2,F3)A(FF,42,7B,D4)A(FF,F9,F9,F9)A(FF,F6,F6,F6)A(FF,F5,F5,F5)A(FF,F4,F4,F4)A(FF,F3,F3,F3)A(FF,27,61,BC)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,34,60,AC)A(FF,D4,DF,F2)A(FF,BD,CE,EB)A(FF,34,60,AC)A(FF,D4,DF,F2)A(00,FF,FF,FF)A(FF,34,60,AC)A(FF,BD,CE,EB)A(FF,D4,DF,F2)A(FF,34,60,AC)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(FF,2B,6C,CC)A(FF,2A,6B,CA)A(FF,2A,69,C8)A(FF,29,66,C4)A(FF,28,65,C2)A(FF,28,62,BD)A(FF,27,61,BB)A(FF,26,5F,B9)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(FF,E3,E3,E3)A(FF,29,29,29)A(FF,10,10,10)A(FF,DD,DD,DD)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)
				A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,9D,02,27)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,2B,6C,CC)A(FF,2A,6B,CA)A(FF,2A,69,C8)A(FF,2A,68,C6)A(FF,29,66,C4)A(FF,28,65,C2)A(FF,28,64,BF)A(FF,28,62,BD)A(FF,27,61,BB)A(FF,26,5F,B9)A(FF,DA,E2,F3)A(FF,2B,6C,CC)A(FF,2A,6A,C9)A(FF,29,68,C6)A(FF,28,66,C2)A(FF,28,63,BF)A(FF,27,61,BC)A(FF,26,5F,B9)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,D4,DF,F2)A(FF,34,60,AC)A(FF,34,60,AC)A(FF,D4,DF,F2)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,34,60,AC)A(FF,34,60,AC)A(FF,D4,DF,F2)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)
				A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(00,FF,FF,FF)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)
				A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3)A(FF,DA,E2,F3);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	build_colors (a_ptr: POINTER)
			-- Build `colors'
		do
			c_colors_0 (a_ptr, 0)
			c_colors_1 (a_ptr, 400)
			c_colors_2 (a_ptr, 800)
		end

feature {NONE} -- Image data filling

	fill_memory
			-- Fill image data into memory
		local
			l_pointer: POINTER
		do
			if attached {EV_PIXEL_BUFFER_IMP} implementation as l_imp then
				l_pointer := l_imp.data_ptr
				if not l_pointer.is_default_pointer then
					build_colors (l_pointer)
					l_imp.unlock
				end
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- SD_ICON_MATRIX_10_10
