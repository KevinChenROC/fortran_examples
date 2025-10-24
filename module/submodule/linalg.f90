module linalg
    use, intrinsic :: iso_fortran_env, only: dp => real64
    implicit none
    private
    public :: norm2, dot_product! make the generic interface public
    public :: norm2_vec_dp, norm2_matcol_dp ! make the specific functions public

    ! Overloaded interface: same generic name, different argument lists
    interface norm2
        pure module function norm2_vec_dp(x) result(n)
            real(dp), intent(in) :: x(:)
            real(dp)             :: n
        end function norm2_vec_dp

        pure module function norm2_matcol_dp(A, j) result(n)
            real(dp), intent(in) :: A(:,:)
            integer,  intent(in) :: j
            real(dp)             :: n
        end function norm2_matcol_dp
    end interface norm2

    interface dot_product
    pure module function dot_vec(a, b) result(dpval)
      real(dp), intent(in) :: a(:), b(:)
      real(dp) :: dpval
    end function dot_vec

    pure module function dot_mat(A, B) result(dpval)
      real(dp), intent(in) :: A(:,:), B(:,:)
      real(dp) :: dpval
    end function dot_mat
  end interface dot_product

end module linalg
  