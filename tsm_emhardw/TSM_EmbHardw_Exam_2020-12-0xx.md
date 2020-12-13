


### Scheduling

Name three scheduling algorithms

- Rate Monotonic Scheduling
- Round Robin
- First Come First Served







### Loop Optimization

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





