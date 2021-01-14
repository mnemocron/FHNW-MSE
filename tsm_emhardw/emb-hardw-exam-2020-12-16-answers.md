
# TSM_EmbHardw mid term exam - 2020-12-16

---

## Questions & Answers

Scenario 1 describes a computer system with the following (part) component diagram:

The tasks to run on this computer system are listed in the table below:

| Task number | WCET | Repetition time | Code size | Task |
|:-----------:|-----:|----------------:|----------:|------|
| Tl | 300 us | 1 ms | 16 kByte | Multiply two 32*32. 32-bit integer matrices |
| T2 | 300 us | l ms | 16 kByte | Multiply and accumulate two 512*512. 32-bit integer matrices |
| T3 |  20 us | 1 ms |  5 kByte | Transpose the result of T1 |
| T4 |  70 us | 1 ms |  5 kByte | Transpose the result of T2 |
| T5 | 100 us | 5 ms | 10 kByte | Display results |
| T6 |  50 us | 5 ms | 10 kByte | Store results in file |

### Task List Scenario 1

The system cache sizes are as follows:

| Cache | Type | Size | Line Size |
|:-----:|------|-----:|----------:|
| L1 | Data 2-way associative | 8 kBytes | 32 Bytes
| L1 | lnstmchondirect mapped | 8 kBytes | 64 Bytes
| L2 | direct mapped | 32 kBytes | 128 Bytes |
| L3 | direct mapped | 64 kBytes | 256 bytes |

### System Cache Sizes

(picture of block diagram missing)

- CPU1 (L1) (L2)
- CPU2 (L1) (L2)
- L3 is shared accross CPU1 and CPU2
- system Bus

---

1. Draw the architecture specification (3P)



2. Offer a short opinion on whether L3 is suitable for inter-processor communication (2P)

Yes, because L3 spans accross both CPUs. Communication can be asynchronous (FIFO).

---

The six tasks are expected to run on one core only

1. Assuming RM scheduling is there a guaranteed schedule? Substantiate your answer (2P)

300/1000 + 300/1000 + 70/1000 + 70/1000 + 100/5000 + 50/5000 = 0.77

has a total Utilization of 77% -->  a schedule can be guaranteed

2. Is there a schedule? If so what is it -just list the task sequence. ignore the length of individual time sequences. If not substantiate your answer. (3P)

```
T1, T2, T3, T4, T5, T6
T1, T2, T3, T4,
T1, T2, T3, T4,
T1, T2, T3, T4,
T1, T2, T3, T4,
T1, T2, T3, T4, T5, T6
T1, T2, T3, T4,
```
... and so on

3. How much system slack is there? (1P)

77%   --> 23% slack

4. Is there a case to be made for voltage scheduling the tasks. Substantiate your answer (2P)

yes! T5 and T6 are only 1/5 as frequent as the other tasks. T5 and T6 could be evenly spread accross 5 x 1ms cycles   (100+50)/5 = 30us per 1ms. T1-T4 use 740us total 1ms - 740us -30us = 230us slack T1 - T4 can be slowed down by: 740us / (740+230)us = 0.76

5. If the tasks can be scheduled on both CPUs - draw a binding (3P)

---

1. The code is written in C - in what order are the matrices stored in? (1P)



2. T1 multiplies two matrices A and B to produce a result C: `C[Ij] = A[Ij] * B[IJ]`. If A is stored at the address `0x100000` where. and in what form would
you suggest locating matrix B? Substantiate your answer (3P)

Store B starting at 0x200000. So that caching can have both A and B matrices in the cache

3. What is the hit rate for matrix A? Explain your answer (3P)



4. If you could prefetch. what kind of cache miss would be saved and how many? (2P)



5. How would you expect the matrix C to be handled in the cache? (3P)



6. Estimate the worst-case L1 hit rate for the code of Task 1 (2P)



7. Can the code be pre-fetched? Substantiate your answer (1P)

---

1. Concisely explain platform-based design (1P)

The design approach of a system is broken down into sub modules. This increases reuse-ability an minimizes errors.
It minimizes errors, because each block can be treated separately and for each block unit tests can be defined.
There is no moment of truth at the end of the project, when everything comes together.

2. What is address pipelining? (1P)

(wrong answer - the following describes prefetching)

In a loop. While the current data is being processed, the next iteration's data can be prefetched. The address of the next data is requested so that the data is ready in the cache at the next iteration cycle.

3. What is the difference between a multilevel and a multi-layer bus system? (1P)

multi level: multiple busses for different purposes: e.g. peripheral / system 
multi layer: there are multiple interconnect layers to allow parallel master accesses

4. Where is out of order completion used (2P)?

Where the data output is not required for the ongoing program
Out of order completion tasks can be run separately to complete whenever.

5. What does a profiler do? (1P)

A profiler shows where in the Code the CPU spends how much time.
It is a way to show utilization.


