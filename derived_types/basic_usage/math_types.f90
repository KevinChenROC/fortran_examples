module math_types
	use, intrinsic :: iso_fortran_env, only: dp => real64
	implicit none
	private
	public :: vector3d, norm
  
	!-----------------------------------------------
	! Derived type definition
	!-----------------------------------------------
	type :: vector3d
	  real(kind=dp) :: x, y, z   ! Components of the vector
	end type vector3d
  
  contains
  
	!-----------------------------------------------
	! Function to compute vector norm
	!-----------------------------------------------
	real(kind=dp) pure function norm(v)
	  type(vector3d), intent(in) :: v
	  norm = sqrt(v%x**2 + v%y**2 + v%z**2)
	end function norm
  
  end module math_types
  