# How to use
This program uses *mmap()* which is **Unix** system call.
*>* ./a.out *amount_of_strings* *file_name*

# Performance analysis

The results of stability tests are listed as follows.

**Valgrind/Memcheck** shows the following result for each sorting algorithm on test:

>HEAP SUMMARY:

>in use at exit: 0 bytes in 0 blocks

>total heap usage: 'number' allocs, 'number' frees, 'bytes' bytes allocated

>All heap blocks were freed -- no leaks are possible

>ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

>ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

**AddressSanitizer** shows no problems.
