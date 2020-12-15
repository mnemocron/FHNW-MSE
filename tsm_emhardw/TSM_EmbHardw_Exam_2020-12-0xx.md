
## Notes:

- Requirement Specifications: `01 10 TSM_EmbHardw Introduction.pdf` (p. 30)
- Requirement Specifications: `01 Exercises V-Model.pdf`
- Voltage Scheduling Formulas: `09 Voltage Scheduling.pdf` (technology brief)





---

### DMA

What is a transfer table?


Name 3 bus access modes for DMA

- burst mode (full bus access, blocks CPU)
- cycle stealing mode (yields back to CPU, transfer takes longer, CPU is not blocked)
- transparent mode (only transfer when CPU does not need Bus)

Explain the cycle stealing DMA mode: (_explicitly stated as exam question_)

- CPU uses the bus sometimes
- DMA controller continuously requests bus access to transfer data
- if CPU requires bus access, the DMA yields to the CPU and waits for another access request to be granted

What is a disadvantage of using DMA?

- the DMA must be initialized (setup time)
- only efficient for large data


---

### Distributed Systems

Why are distributed systems needed?

- Centralize data collection from remote sensors

What are distributed Systems?


What traffic types exist on a (Field-) BUS?

- Cyclinc Traffic (Data Samples)
- Setup
- Alarm

What are lock-step processors?

- two CPUs that execute the same code in parallel
- a monitor that checks if both CPUs are doing the exact same thing
- for safety systems

Can two CPUs exist on the same BUS?

- yes, if a bus arbiter is used

How can two CPUs be de-synchronized on the BUS?

- By using a dual port ram on each end of the field bus

---

### HW / SW Codesign

Explain the term "moment of truth"

- The moment in the project phase, usually at integration or testing, when the results are showing if the system works or not.


What is specification driven design?



Explain "design space exploration"


What is AMBA? - Advanced Microprocessor Bus Architecture

- a series of bus systems specification for SoC architecutres
- for Risc (ARM) processors
- uses bridging concept

Explain AHB, ASB, APB

- Advanced High Performance Bus (standard bus)
- Advanced System Bus
- Advanced Peripheral Bus (for slow peripherals)
- AXI: Advanced Extensible Interfaces --> protocol (not topology)
- ATB: Test Bus

What is the task of a Bus Arbiter?

- To decide and schedule which Mater on the Bus can access the Bus (multi master)

Does Bus arbitration use priorities?

- Yes. e.g. for Burst Transfers

What is the default master on an arbitrated Bus?

- a master master that is in default master mode
- may only transfer IDLE transfers
- a default master is requrired for bus arbitration

What is the difference between Multi-Level and Multi-Layer in Bus arbitraion?

- Multi-Level: system and peripheral Bus (different buses)
- Multi-Layer: parallel access with multiple masters/slaves (bus interconnect has multiple layers)

Can masters communicate with masters?

- not necessarily, as it requires tri-state buses

What is AXI for?

- tries to minimize timing effects
- increases slave complexity
- defines a transmit/receive protocol stack


---

### Scheduling

Name three scheduling algorithms

- Rate Monotonic
- Round Robin
- First Come First Served

What is voltage Scheduling?

- Tasks have deadlines, the initial schedule is known. If the tasks are finished before their deadline, the system can be slowed down by a factor. This elongates execution time to still meet the deadline (all).
- by slowing down the CPU, the voltage can be reduced and power saved.

Explain List scheduling

- used for scheduling instructions and functional blocks (add, multiply...)
- the "critical path" with the most following steps has highest priority

What is slack?

- unused CPU time

Explain FCFS Scheduling

- tasks that arrive first are executed first
- run to completion / non-preemptive
- no priority
- long tasks dominate

What is the difference between hard realtime and soft realtime scheduling?

- hard realtime: deadlines must not be missed
- soft realtime: some deadlines may be missed


---

### Loop Optimization

*Fusion* or combining – this combines the bodies of two adjacent loops that would iterate the same number of times (whether or not that number is known at compile time), as long as they make no reference to each other's data. 

*Reversal* – a subtle optimization that reverses the order in which values are assigned to the index variable. This can help eliminate dependencies and thus enable other optimizations. Certain architectures utilize looping constructs at assembly level that count in a single direction
only (e.g., decrement-jump-if-not-zero [DJNZ]).

*Skewing* – this technique is applied to a nested loop iterating over a multidimensional array, where each iteration of the inner loopdepends on previous iterations, and rearranges its array accesses so that the only dependencies are between iterations of the outer loop.

*Splitting* or peeling – this attempts to simplify a loop or eliminate dependencies by breaking it into multiple loops which have the same bodies but iterate over different portions of the index range. A special case is loop peeling, which can simplify a loop with a problematic first iteration by
performing that iteration separately before entering the loop. 


Explain loop fusion:

- combines two loops adjacent with the same loop count and different data

Explain loop reversal:

- reverses the iteration variable to make use of assembler oprimizations e.g. jump if not zero

Explain loop skewing:

- used where nested loops depend on the previously calculated value e.g. d[i] = d[i-1] + d[i]

Explain loop splitting / peeling:

- split parts of the loop into prolog/epilog or multiple loops to avoid branching

Explain loop unrolling:

- loop is "unrolled", no loop, all statements hardcoded in sequence
- only works for fixed loop size

Explain loop hoisting:

- invariant code is taken out of the loop

Explain the 3 stages that the compiler optimizes for before generating machine instructions.

- Allocation: ALU / registers etc.
- Binding: hold a variable in one CPU register
- Scheduling: order of the instructions (number of instructions for number of registers)





