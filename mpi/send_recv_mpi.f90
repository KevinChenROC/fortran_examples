PROGRAM send_recv_mpi
	include 'mpif.h'
	
	integer process_Rank, size_Of_Cluster, ierror, message_Item,src, dest

	src = 0
	dest = 1
	
	call MPI_INIT(ierror)
	call MPI_COMM_SIZE(MPI_COMM_WORLD, size_Of_Cluster, ierror)
	call MPI_COMM_RANK(MPI_COMM_WORLD, process_Rank, ierror)
	
	IF(process_Rank == 0) THEN
		message_Item = 42
		call MPI_SEND(message_Item, &       !Variable storing the message we are sending.
		1, &                  				!Number of elements handled by the array.
		MPI_INT, &            				!MPI_TYPE of the message we are sending.
		dest, &                  			!Rank of receiving process
		1, &                  				!Message Tag
		MPI_COMM_WORLD, &      				!MPI Communicator
		ierror)              				!Error Handling Variable

		print *, "Sending message containing: ", message_Item
	ELSE IF(process_Rank == 1) THEN
		call MPI_RECV(message_Item, &       !Variable storing the message we are receiving.
		1, &                  				!Number of elements handled by the array.
		MPI_INT, &            				!MPI_TYPE of the message we are sending.
		src, &                  			!Rank of sending process
		1, &                  				!Message Tag
		MPI_COMM_WORLD, &      				!MPI Communicator
		MPI_STATUS_IGNORE, &   				!MPI Status Object
		ierror)              				!Error Handling Variable

		print *, "Received message containing: ", message_Item
	END IF

	call MPI_FINALIZE(ierror)
END PROGRAM