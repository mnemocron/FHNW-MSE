




# Important Facts

- Quantum Gates are Unitaries and therefore always reversible.



---

# Own Questions 

### What is universality? Which conditions must be fullfilled?



### What are Paulis?


### What are Cliffords?


### What is the output of applying Gate a to quantum state b ?

(todo table of examples)


### Explain the "No-Cloning Theorem"


### By what method can quantum states be "copied" then?


### Can a QBit be copied / cloned ?

- no because of the "cloning theorem"




### What are some basic gates?




### Explain what each gate does:




### How is a Toffoly Gate formed from basic gates?



### What is an s-dagger? (y-measurement)





### What does an X-gate do before and after a rotation operation?

- it rotates in the opposite direction
- X Rz(theta) X   = Rz(-theta)



### QBit arrangements in physical computers...

- connectivity means physigal interaction. 
- the more connections the more error prone




### Global Phase ...






---

# Real Questions from Quizzes

### Given this code fragment, what is the probability that a measurement would result in |0> ?

```python
qc = QuantumCircuit(1)
qc.ry(3 * math.pi/4, 0)
```

- A. 0.8536
- B. 0.5
- C. 0.1464
- D. 1.0




### What is the result of applying; `|0X0|1>` ?

- `0`
- `1`
- `[1 0]'`
- `[0 0]'`

### What is the result of applying; `|0X0|0>` ?

- `0`
- `1`
- `[1 0]'`
- `[0 0]'`


### What happens if a backend quantum computer does not support complex gates (like Toffoli)?

- transpiling  `qiskit.compiler.transpile`



### What is quantum volume?

- used to compare two machines
- simplifies quantum computer specifications to one benchmark score in order to compare them 
- the bigger, the better



---

# Questions and Answers from Q&A Sessions

### What is quantum volume?

- used to compare two machines
- simplifies quantum computer specifications to one benchmark score in order to compare them 
- the bigger, the better

### What physical architecture does the quantum backends use?

They use different ones depending on the backend. You can find the details for the backends when you click on the individual machine under https://quantum-computing.ibm.com/services

### Does the choice of the layout matter?

yes, it does because of two things: 1- the topology of the circuit (how qubits are physically connected) if you do a 2-qubit gate you whether need 2 qubits which are connected or add some extra gates to kind of "create" that connection and therefore those extra gates will add noise. 2- the error rates associated to 1-single qubit gates, measurement and connection among qubits, in order to get the best result you may choose wisely the top qubits available so that the noise is minimized



### Why are Bra and Ket used? What is the difference?

For pure Quantum States without superposition it does not matter. Bra and Ket are the same.

### What is the Eigenstate of a Matrix?





### What is an example of a correlated state that is not entangled?

There can be correlated states that are not entangled. But entangled states are always correlated (is this true?).

A mixed state is an example of a correlated state that is not entangled.



### Can we only discriminate orthogonal quantum states?



### Why are quantum States normalized?

- convention
- more useful when working with probabilities




