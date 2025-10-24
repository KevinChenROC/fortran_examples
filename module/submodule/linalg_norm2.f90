submodule(linalg) linalg_norm2
  implicit none
contains
  pure module function norm2_vec_dp(x) result(n)
    use, intrinsic :: iso_fortran_env, only: dp => real64
    real(dp), intent(in) :: x(:)
    real(dp)             :: n
    n = sqrt(sum(x*x))
  end function norm2_vec_dp

  pure module function norm2_matcol_dp(A, j) result(n)
    use, intrinsic :: iso_fortran_env, only: dp => real64
    real(dp), intent(in) :: A(:,:)
    integer,  intent(in) :: j
    real(dp)             :: n
    n = sqrt(sum(A(:, j)*A(:, j)))
  end function norm2_matcol_dp
end submodule linalg_norm2
