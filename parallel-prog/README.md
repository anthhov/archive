# parallel-prog

## Primes
Calculates prime numbers in given range using *tasks*, *threads* and *tread pool*.

## DirHash
Calculates directory MD5 hash.

## lock-bst
Lock-based Binary Search Tree with *'fine' synchronization*.

We provide synchronization through mutual exclusion on each element.

At any operations, we simultaneously hold the lock current and previous element (not to lose invariant of pred.next == curr).

### Common average time values
1.000.000 random keys to insert; 50.000 random keys to delete; 1.000.000 random keys to find.

All numbers are random numbers (from 0 to 100.000).

| Operation          | Time         |
| ------------------ |:------------:|
| Sequential insert  |  00:00:01.34 |
| Sequential delete  |  00:00:00.61 |
| Sequential search  |  00:00:01.29 |
| Concurrent insert  |  00:00:00.85 |
| Concurrent delete  |  00:00:00.38 |
| Concurrent search  |  00:00:00.74 |

## AtomicSnapshots (wait-free)
This is implementation of The Bounded Single-Writer Algorithm for taking atomic snapshots of shared memory. The algorithm itself was taken from the article ["Atomic Snapshots of Shared Memory"](http://people.csail.mit.edu/shanir/publications/AADGMS.pdf). There is an example for 2 registers.

## HrefParser (await/async)
The parser downloads all web pages referenced from the parent web page in *\<a href="http://..."\>* style.
