module mymath
    implicit none
    
contains
function vector_norm(vec,p) result(norm)
    real, intent(in) :: vec(:)
    integer, intent(in), optional :: p ! power
    real :: norm
    if (present(p)) then ! compute Lp norm
      norm = sum(abs(vec)**p) ** (1.0/p)
    else ! compute L2 norm
      norm = sqrt(sum(vec**2))
    end if
  end function vector_norm
end module mymath
