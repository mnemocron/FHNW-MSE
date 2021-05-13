





Clock Gating is forbidden
unless for power saving, if you know what you are doing


Explain the difference between analog and NCO clock jitter:

- analog is random (raises noise floor)
- nco is deterministig (spurs in spectrum)
- 


Explain apperture jitter.

- in sample and hold circuits of ADC, switch has jittered switching delay











---

# Digital Design


Timing Behaviour

How does a gate delay behave if
– The temperature rises
– the process gets better
– the supply voltage is decreased

How does a wiring delay behave if
– the device is cooled down 
– the IC process gets worse 
– the supply voltage is increased 




### We have traces laid out on a PCB using copper wires on FR4 material. What is the wire delay for a trace of 100 mm length?

### Understanding Signaling Methods

a) What is the difference between bit rate and symbol rate? What are the units for the two rates?

> Bit Rate: (digital information) Bits per Second. Symbol Rate: Signal changes per second (Baud - NOT "Baud-per-second"). e.g. in QAM256 there are 256 values transmitted in one symbol, i.e. 8 bits in one symbol

b) Suppose a QAM-256 System in DVB-C (=today's HDTV over cable) on a 8MHz 
channel. Forward error correction is done with Reed-Solomon RS (204,188) code 
(which means that 188 used bytes are coded into 204 transmitted bytes) and (due to SNR) a ratio of 1.15 between bandwidth and symbol rate. What is the resulting maximal bit rate?

> Bandwith / Symbol Rate: 1.15
Reed-Solomon 204/188 = 1.085106
Bits per Symbol = 8
Max. Bit Rate = 8MHz * 8 / 1.15 / 1.085106 = 51.2873 Mbit/s

### Compare data rates
c) What are max. data rates of parallel systems (such as SCSI etc.) and serial systems?

> data rates of parallel interfaces (such as Centronics etc.) are typically much lower than serial channels, because classic parallel interfaces use an asynchronous signalling requiring 2 - 3 clock cycles for one transfer. serial interfaces can also be mutliplied in parallel, but since they are synchrounous they can transport up to 2 bits per clock cycle (DDR interfaces).

d) Which type of communication system (parallel data or serial data) allows for a higher data rate at similar power consumption?

> the power consumption is lower in LVDS interfaces due to the lower voltage swing. besides that the power consumption is basically linked to the frequency - i.e. independent of "parallel" or "serial". But a good signal coding can reduce the number of transitions (e.g. Gray Code instead of standard binary coding)

### Differential signaling

a) What is the reason for differential signaling?

>  remove need for a ground line (note: grounding is still a good joice just for blinding reasons!), remove common mode noise, allow for AC coupling avoiding ground coupling problems

b) Give examples of differential signaling methods

> LVDS, Ethernet, USB, XLR Audio, PCI

c) Explain the function of the SGMII / QSGMII interface and the usage of SERDES 

>  The MII (Media Independent Interface) is the interface between MAC and PHY. For the fastest protocols, a serial interface is used (SGMII with 1.25 Gbps dual-data-rate path and QSGMII for four lines with a 5 Gbps dual-data-rate path). Modern FPGA can directly interface by using their SERDES interfaces – see application notes from Altera/Intel and Xilinx.

### CDR

a) What is the reason to use clock data recovery?

> clock data recovery is necessary whenever there is no clock transported - and by that one (high power) signal line is removed.

b) What is the reason for the use of n-th-rate phase detector? 

> When the data rate is so high that the design of a VCO with the frequency of that data rate becomes too complex. Then the design of the VCO can be simplified by reducing its frequency by a factor of 2n and using a n-th-rate phase detector

c) What are the characteristic differences between the CDR methods?

> The different methods characterize by
> – Proportional or "bang-bang" phase detectors
> – VCO (or low speed NCO) or full digital solution by re-timing
> – Computing requirement / precision
> – Phase Detector / Timing Error Detector are functionally the same


---

### Pre Emphasis

Where is it used?

> digital Signals

Why is it used?

> to emphasize signal edges that are dampened by the low pass characteristic of the pcb trace






