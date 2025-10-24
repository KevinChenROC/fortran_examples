program test_norm
  use mymath, only: vector_norm               ! import the module
  implicit none

  real :: v(3)

  v = [1,2,3]

  print *, 'Vector norm = ', vector_norm(v), vector_norm(v,2)
  print *, 'L1 norm = ', vector_norm(v,1)
end program test_norm
