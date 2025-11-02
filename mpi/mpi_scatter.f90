PROGRAM scatter_mpi
	include 'mpif.h'
	
	integer process_Rank, size_Of_Cluster, ierror, message_Item
	integer scattered_Data, elem_Per_Process
	integer, dimension(4) :: distro_Array
	distro_Array = [39, 72, 129, 42]
	elem_Per_Process = 1

	call MPI_INIT(ierror)
	call MPI_COMM_SIZE(MPI_COMM_WORLD, size_Of_Cluster, ierror)
	call MPI_COMM_RANK(MPI_COMM_WORLD, process_Rank, ierror)
	call MPI_Scatter( & 	
	distro_Array,&			!Variable storing the values that will be scattered.
	elem_Per_Process,   & 					!Number of elements that will be scattered.
	MPI_INT,   & 			!MPI Datatype of the data that is scattered.
	scattered_Data,   & 	!Variable that will store the scattered data.
	elem_Per_Process,   & 					!Number of data elements that will be received per process.
	MPI_INT,   & 			!MPI Datatype of the data that will be received.
	2,   & 					!The rank of the process that will scatter the information.
	MPI_COMM_WORLD,   & 	!The MPI_Communicator.
	ierror);   				!An error handling variable.
	
	print *, "Process ", process_Rank, "received: ", scattered_Data
	call MPI_FINALIZE(ierror)
	
END PROGRAM