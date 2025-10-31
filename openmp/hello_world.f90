program Parallel_Hello_World	
	use omp_lib
	implicit none
	
	!$omp parallel
	print *, "Hello from Thread: ", omp_get_thread_num(), " out of ", omp_get_num_threads()
	!$omp end parallel
end program Parallel_Hello_World