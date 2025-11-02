program pack_example
    use mpi
    implicit none

    integer :: ierr, rank, nprocs
    integer :: position
    integer :: i
    integer :: int_value
    real    :: real_array(3)
    character(len=10) :: str
    integer :: bufsize
    integer(kind=MPI_ADDRESS_KIND) :: extent
    integer, parameter :: root = 0

    ! A byte buffer large enough to hold all packed data
    integer, parameter :: maxbuf = 1000
    character(len=1), dimension(maxbuf) :: buffer

    call MPI_Init(ierr)
    call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)
    call MPI_Comm_size(MPI_COMM_WORLD, nprocs, ierr)

    if (rank == root) then
        int_value = 42
        real_array = [1.1, 2.2, 3.3]
        str = "HELLOMPI"
	else if (rank /= root) then
		int_value = 0
		real_array = [0.0, 0.0, 0.0]
		str = ""
	end if

	position = 0
	if (rank == root) then
		call MPI_Pack(int_value,  1, MPI_INTEGER,   buffer, maxbuf, position, MPI_COMM_WORLD, ierr)
		call MPI_Pack(real_array, 3, MPI_REAL,      buffer, maxbuf, position, MPI_COMM_WORLD, ierr)
		call MPI_Pack(str,        len(str), MPI_CHARACTER, buffer, maxbuf, position, MPI_COMM_WORLD, ierr)
		bufsize = position
		! 1) Tell everyone the exact byte count
	end if
	
	call MPI_Bcast(bufsize, 1, MPI_INTEGER, root, MPI_COMM_WORLD, ierr)
	! 2) Now broadcast exactly that many bytes
	call MPI_Bcast(buffer,  bufsize, MPI_PACKED,  root, MPI_COMM_WORLD, ierr)
	

    ! 3) All processes now unpack the data in the same order
    position = 0
    call MPI_UNPACK(buffer, bufsize, position, int_value, 1, MPI_INTEGER, MPI_COMM_WORLD, ierr)
    call MPI_UNPACK(buffer, bufsize, position, real_array, 3, MPI_REAL, MPI_COMM_WORLD, ierr)
    call MPI_UNPACK(buffer, bufsize, position, str, len(str), MPI_CHARACTER, MPI_COMM_WORLD, ierr)

    print *, 'Rank', rank, 'received:', int_value, real_array, trim(str)

    call MPI_Finalize(ierr)
end program pack_example
