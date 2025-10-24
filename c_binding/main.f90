program main
	use, intrinsic :: iso_c_binding, only: c_int
	implicit none
  
	interface
	   function add(a, b) bind(C, name="add") result(sum)
		 import :: c_int
		 integer(c_int), value :: a, b      ! passed by value to C
		 integer(c_int) :: sum
	   end function add
	end interface
  
	integer(c_int) :: x, y, s
  
	! Assign values
	x = 3
	y = 7
  
	! Call the C function
	s = add(x, y)
  
	print *, "Sum =", s
  end program main
  