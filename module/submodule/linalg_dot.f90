submodule(linalg) linalg_dot
  implicit none
contains
  pure module function dot_vec(a, b) result(dpval)
    real(dp), intent(in) :: a(:), b(:)
    real(dp) :: dpval
    dpval = sum(a*b)
  end function dot_vec

  pure module function dot_mat(A, B) result(dpval)
    real(dp), intent(in) :: A(:,:), B(:,:)
    real(dp) :: dpval
    dpval = sum(A*B)
  end function dot_mat

end submodule linalg_dot