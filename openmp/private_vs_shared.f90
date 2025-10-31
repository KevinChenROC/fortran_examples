program Private_vs_Shared
    use omp_lib
    implicit none
    
    ! Variables declared outside parallel region
    integer :: shared_var = 0
    integer :: private_var = 100
    integer :: thread_id, i
    
    print *, "=== DEMONSTRATION 1: Default Shared Behavior ==="
    print *, "Initial shared_var value: ", shared_var
    print *
    
    ! All threads share the same variable by default (RACE CONDITION!)
    !$omp parallel
    thread_id = omp_get_thread_num()
    shared_var = shared_var + 1
    print *, "Thread", thread_id, "sees shared_var =", shared_var
    !$omp end parallel
    
    print *
    print *, "Final shared_var (unpredictable due to race condition):", shared_var
    print *
    
    ! Reset for next demonstration
    shared_var = 0
    
    print *, "=== DEMONSTRATION 2: Private Variables ==="
    print *, "Initial private_var value (outside parallel region): ", private_var
    print *
    
    ! Each thread gets its own PRIVATE copy of the variable
    !$omp parallel private(private_var, thread_id)
    thread_id = omp_get_thread_num()
    ! Private variables are UNINITIALIZED when entering parallel region
    print *, "Thread", thread_id, "private_var (uninitialized):", private_var
    
    ! Set private variable to thread-specific value
    private_var = thread_id * 10
    print *, "Thread", thread_id, "set private_var to:", private_var
    !$omp end parallel
    
    print *
    print *, "Original private_var after parallel region:", private_var
    print *, "(Note: Changes inside parallel region don't affect original)"
    print *
    
    print *, "=== DEMONSTRATION 3: FirstPrivate Variables ==="
    private_var = 100
    print *, "Initial private_var value: ", private_var
    print *
    
    ! FIRSTPRIVATE: Each thread gets initialized with the original value
    !$omp parallel firstprivate(private_var) private(thread_id)
    thread_id = omp_get_thread_num()
    print *, "Thread", thread_id, "firstprivate_var starts at:", private_var
    private_var = private_var + thread_id
    print *, "Thread", thread_id, "modified it to:", private_var
    !$omp end parallel
    
    print *
    print *, "Original private_var unchanged:", private_var
    print *
    
    print *, "=== DEMONSTRATION 4: LastPrivate Variables ==="
    private_var = 100
    print *, "Initial value: ", private_var
    print *
    
    ! LASTPRIVATE: The value from the last iteration is copied back
    !$omp parallel do lastprivate(private_var)
    do i = 1, 8
        private_var = i * 100
        print *, "Iteration", i, "set private_var to:", private_var
    end do
    !$omp end parallel do
    
    print *
    print *, "After parallel loop, private_var =", private_var
    print *, "(Value from the LAST iteration is preserved)"
    print *
    
    print *, "=== DEMONSTRATION 5: Proper Shared Usage with Critical Section ==="
    shared_var = 0
    
    !$omp parallel private(thread_id)
    thread_id = omp_get_thread_num()
    
    ! CRITICAL section ensures only one thread accesses shared_var at a time
    !$omp critical
    shared_var = shared_var + 1
    print *, "Thread", thread_id, "incremented shared_var to:", shared_var
    !$omp end critical
    !$omp end parallel
    
    print *
    print *, "Final shared_var (correct result):", shared_var
    
end program Private_vs_Shared
