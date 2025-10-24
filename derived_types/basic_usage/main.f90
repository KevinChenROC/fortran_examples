program demo_vector
	use math_types
	use, intrinsic :: iso_fortran_env, only: dp => real64
	implicit none
  
	type(vector3d) :: a, b
  
	! Initialize the components
	a = vector3d(3.0_dp, 4.0_dp, 12.0_dp)
	b%x = 1.0_dp
	b%y = 2.0_dp
	b%z = 3.0_dp
  
	! Access components
	print *, "Vector a =", a%x, a%y, a%z
	print *, "Vector b =", b%x, b%y, b%z
  
	! Compute norm using the module function
	print *, "||a|| =", norm(a)
	print *, "||b|| =", norm(b)
  end program demo_vector
  