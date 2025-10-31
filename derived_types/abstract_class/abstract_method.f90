module particles
    use iso_fortran_env, only: real64
    implicit none
    private
    public :: particle_base, particle_fullorbit
  
    ! --- Abstract base type
    type, abstract :: particle_base
      real(real64) :: x = 0.0_real64
      real(real64) :: v = 1.0_real64
    contains
      procedure(move_iface), deferred :: move
    end type particle_base
  
    ! --- Abstract interface for the deferred type-bound procedure
    abstract interface
      subroutine move_iface(self, dt)
        import :: particle_base, real64
        class(particle_base), intent(inout) :: self
        real(real64),        intent(in)     :: dt
      end subroutine move_iface
    end interface
  

    ! --- Concrete derived type that implements 'move'
    type, extends(particle_base) :: particle_fullorbit
      real(real64) :: gyro_phase = 0.0_real64
    contains
      procedure :: move => move_fullorbit
    end type particle_fullorbit
  
  contains
  
    ! --- Implementation of the deferred procedure for particle_fullorbit
    subroutine move_fullorbit(self, dt)
      class(particle_fullorbit), intent(inout) :: self
      real(real64),              intent(in)     :: dt
      self%x = self%x + self%v * dt
      print *, 'Full-orbit move called: x =', self%x
    end subroutine move_fullorbit
  
  end module particles
  
  
  program demo_polymorphism
    use iso_fortran_env, only: real64
    use particles
    implicit none
  
    class(particle_base), allocatable :: p
    integer :: i

    allocate(particle_fullorbit :: p)   ! polymorphic allocation
    do i = 1, 5
        call p%move(0.1_real64)             ! dynamic dispatch -> move_fullorbit
    end do
  end program demo_polymorphism
  