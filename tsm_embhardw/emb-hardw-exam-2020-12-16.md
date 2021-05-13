
# TSM_EmbHardw mid term exam - 2020-12-16

---

## Questions

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

---

The six tasks are expected to run on one core only

1. Assuming RM scheduling is there a guaranteed schedule? Substantiate your answer (2P)
2. Is there a schedule? If so what is it -just list the task sequence. ignore the length of individual time sequences. If not substantiate your answer. (3P)
3. How much system slack is there? (1P)
4. Is there a case to be made for voltage scheduling the tasks. Substantiate your answer (2P)
5. If the tasks can be scheduled on both CPUs - draw a binding (3P)

---

1. The code is written in C - in what order are the matrices stored in? (1P)
2. T1 multiplies two matrices A and B to produce a result C: `C[Ij] = A[Ij] * B[IJ]`. If A is stored at the address `0x100000` where. and in what form would
you suggest locating matrix B? Substantiate your answer (3P)
3. What is the hit rate for matrix A? Explain your answer (3P)
4. If you could prefetch. what kind of cache miss would be saved and how many? (2P)
5. How would you expect the matrix C to be handled in the cache? (3P)
6. Estimate the worst-case L1 hit rate for the code of Task 1 (2P)
7. Can the code be ore-fetched? Substantiate your answer (1P)

---

1. Concisely explain platform-based design (1P)
2. What is address pipelining? (1P)
3. What is the difference between a multilevel and a multi-layer bus system? (1P)
4. Where is out of order completion used (2P)?
5. What does a profiler do? (1P)





