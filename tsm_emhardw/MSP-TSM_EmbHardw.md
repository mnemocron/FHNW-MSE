
# TSM_EmbHardw - possible exam questions

---

## Notes:

- Requirement Specifications: `01 10 TSM_EmbHardw Introduction.pdf` (p. 30)
- Requirement Specifications: `01 Exercises V-Model.pdf`
- Voltage Scheduling Formulas: `09 Voltage Scheduling.pdf` (technology brief)

---

### SoC

---

#### Define what a System-on-Chip architecture is

non-Soc has bottlenecks in interfaces, bandwidth, scheduling, cpu power.

SoC seeks to reduce the footprint of a functionality by reducing the number of necessary components to one.

---

#### Explain Plattform based design

- architect a platform for a vercital application space
- uses pre-defined and verified functional blocks (certain degree of modularity)
- (sometimes) application specific blocks (custom RTL IP)
- Integration of blocks using direct or bus interconnect topologies

---

#### What is the "moment of truth" ?

The moment of truth reveals the answer to the question "Will it work?" - "it" being the complete integrated system with all components and functionalities.

The moment in the project phase, usually at integration or testing, when the results are showing if the system works or not.

---

#### How does HW/SW codesign work? What are the advantages?

Reduces the Risk by moving the Moment of Truth as forward as possible. (e.g. unit tests). So that the Moment of Truth is on the Unit level and not the System level.

Offloading is used to translate functional requirements into specifications for the software domain. Same goes with hardware requirements for the SoC Design.

---

#### Explain specification derived design:

Reduces risk by generating HW and SW from the same specification/description.

[System-on-Chip (SoC) Design- and Development Considerations – Part 2](https://www.embedded-computing.com/guest-blogs/system-on-chip-soc-design-and-development-considerations-part-2)

---

#### Explain in detail what Design Space Exploration is:

DSE is a systematic approach to compare the complex cost/benefit ratio of a modular system design. Each subcomponent can be implemented in different ways, the DSE helps to rule out unwanted points by looking at properties like energy consumption, cost, size, complexity etc.

> Design Space Exploration (DSE) refers to systematic analysis and pruning of unwanted design points based on parameters of interest.
A tradeoff analysis between each of the implementation option based on a certain parameter of interest forms the basis of DSE. The parameter of interest could vary across systems, but the commonly used parameters are power, performance, and cost. [Wikipedia]

Iterative process:

- (allocation + binding = partitioning)
    + select HW components (**allocation**) (Graphic: connect HW blocks to Bus block...)
    + **bind** functions to HW components (Graphic: Data Flow Graph -> Architecure Graph)
- (binding + scheduling = mapping)
    + define execution order (**scheduling**) (Graphic: tasks on time axis)
- do **performance analysis**
- re-iterate by changing components (e.g. add another CPU)

---

#### Name three methods to reduce the risk in embedded design:

- iterative development
- specification derived design
- move "moment of truth" forward into unit level instead of system level

---

### DMA

---

#### What is a transfer table?


---

#### Name 3 bus access modes for DMA

- burst mode (full bus access, blocks CPU)
- cycle stealing mode (yields back to CPU, transfer takes longer, CPU is not blocked)
- transparent mode (only transfer when CPU does not need Bus)

---

#### Explain the cycle stealing DMA mode: (_explicitly stated as exam question_)

- CPU uses the bus sometimes
- DMA controller continuously requests bus access to transfer data
- if CPU requires bus access, the DMA yields to the CPU and waits for another access request to be granted

---

What are some disadvantages of using DMA?

- the DMA must be initialized (setup time)
- only efficient for large data

---

### Distributed Systems

---

#### Why are distributed systems needed?

Centralize data collection from remote sensors

---

#### What are distributed Systems?

> A distributed system is a system whose components are located on different networked computers, which communicate and coordinate their actions by passing messages to one another. [Wikipedia]

---

#### What traffic types exist on a (Field-) BUS?

- Cyclinc Traffic (Data Samples)
- Setup
- Alarm

---

#### What are lock-step processors?

- two CPUs that execute the same code in parallel
- a monitor that checks if both CPUs are doing the exact same thing
- for safety systems

---

#### Can two CPUs exist on the same BUS?

- yes, if a bus arbiter is used

---

#### How can two CPUs be de-synchronized on the BUS?

- By using a dual port ram on each end of the field bus (e.g. FiFo buffer)

---

### Bus Systems

---

#### What is AMBA? - Advanced Microprocessor Bus Architecture

- a series of bus systems specification for SoC architecutres
- for Risc (ARM) processors
- uses bridging concept

---

#### Explain AHB, ASB, APB

- Advanced High Performance Bus (standard bus)
- Advanced System Bus
- Advanced Peripheral Bus (for slow peripherals)
- AXI: Advanced Extensible Interfaces --> protocol (not topology)
- ATB: Test Bus

---

#### What is the task of a Bus Arbiter?

- To decide and schedule which Mater on the Bus can access the Bus (multi master)

---

#### Does Bus arbitration use priorities?

- Yes. e.g. for Burst Transfers

---

#### What is the default master on an arbitrated Bus?

- a master that is in default master mode
- may only transfer IDLE transfers
- a default master is requrired for bus arbitration

---

#### What is the difference between Multi-Level and Multi-Layer in Bus arbitraion?

1.

- Multi-Level: system and peripheral Bus (different buses)
- Multi-Layer: parallel access with multiple masters/slaves (bus interconnect has multiple layers)

2.

- multi level: multiple busses for different purposes: e.g. peripheral / system 
- multi layer: there are multiple interconnect layers to allow parallel master accesses

---

#### Can masters communicate with masters?

- not necessarily, as it requires tri-state buses

---

### What are the tasks of the AXI?

- tries to minimize timing effects
- increases slave complexity
- defines a transmit/receive protocol stack

---

### Scheduling

---

#### Name three scheduling algorithms

- Rate Monotonic
- Round Robin
- First Come First Served

---

#### What is voltage Scheduling?

- Tasks have deadlines, the initial schedule is known. If the tasks are finished before their deadline, the system can be slowed down by a factor. This elongates execution time to still meet the deadline (all).
- by slowing down the CPU, the voltage can be reduced and power saved.

---

#### Explain List scheduling

- used for scheduling instructions and functional blocks (add, multiply...)
- the "critical path" with the most following steps has highest priority

---

#### What is slack?

- unused CPU time

---

#### Explain FCFS Scheduling

- tasks that arrive first are executed first
- run to completion / non-preemptive
- no priority
- long tasks dominate

---

#### What is the difference between hard realtime and soft realtime scheduling?

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

---

#### Explain loop fusion:

- combines two loops adjacent with the same loop count and different data

---

#### Explain loop reversal:

- reverses the iteration variable to make use of assembler oprimizations e.g. jump if not zero

---

#### Explain loop skewing:

- used where nested loops depend on the previously calculated value e.g. `d[i] = d[i-1] + d[i]`

---

#### Explain loop splitting / peeling:

- split parts of the loop into prolog/epilog or multiple loops to avoid branching

---

#### Explain loop unrolling:

- loop is "unrolled", no loop, all statements hardcoded in sequence
- only works for fixed loop size

---

#### Explain loop hoisting:

- invariant code is taken out of the loop

---

#### Explain the 3 stages that the compiler optimizes for before generating machine instructions.

- Allocation: ALU / registers etc.
- Binding: hold a variable in one CPU register
- Scheduling: order of the instructions (number of instructions for number of registers)

---

#### The code is written in C - in what order are the matrices stored in? 

C uses row-major order (lexographical access order).

| Address  |  Access  |    Value  |
|:--------:|:--------:|:---------:|
|    0     | `A[0][0]`  |  a11      |
|    1     | `A[0][1]`  |  a12      |
|    2     | `A[0][2]`  |  a13      |
|    3     | `A[1][0]`  |  a21      |
|    4     | `A[1][1]`  |  a22      |
|    5     | `A[1][2]`  |  a23      |

---

#### How do you calculate the hit rate?


---

#### What is address pipelining?

Peripherals should reply to a CPU r/w request immediately so that CPU does not have to wait. A pipeline is used to pre fetch data/instruction from the peripheral. While the ALU is decoding/executing the current command, the next address is already applied to the peripheral, so that the CPU can immediately access the peripheral in the following cycles.

#### What is prefetching?

In a loop, while the current data is being processed, the next iteration's data can be prefetched. The address of the next data is requested so that the data is ready in the cache at the next iteration cycle.

---

#### Where is out of order completion/execution used?

Where the data output is not required for the ongoing program
Out of order completion tasks can be run separately to complete whenever.

- to make use of instruction cycles that would otherwise be wasted
- original order: as given by the C-code
- new order: defined by availability of input data and execution units

---

#### What does a profiler do?

A profiler shows how much time the CPU spends int which code sections. It is a way to show utilization.








