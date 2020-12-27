# TSM Emb Real

---

## Workflow

Always execute from:

`cd tsm-embreal/HiFive1/work`

open source:

`subl ../src/app-anatomy-1.cc`

`nano ../src/app-anatomy-1.cc`

`vim ../src/app-anatomy-1.cc`

compile

`make app-anatomy-1`

flash

`../tools/flash.sh app-anatomy-1`

Terminal

```bash
../tools/comm.sh
```

Exit Termianl with:

`Ctrl` + `A` then `Ctrl` + `X`

---

## Questions / C++ Specifics

### What is `*const` ? 

```c++
volatile GPIO*const gpio=(volatile GPIO*const)0x10012000;
```

A pointer declared as constant. In this case pointing to a hardware address. The address of the hardware itself obviously does not change.

### Inheritance / Subclasses

- single colon `:` for subclass ("extends")
- comma `,` for multiple parent classes

```c++
class App:sys::Event, sys::Event::Listener
//subclass of Event
//subclass of Event::Listener
{
 static App app;
//----------------------- implementation Event::Listener
 void onEvent(sys::Event&);
 App();
};
```

### What is an `inline` function?

Compiler replaces the definition of inline functions at compile time instead of referring function definition at runtime. 

- speeds up program by avoiding function calling and variable push/pop
- increases code size

```c++
inline void App::onExternal(){
}
```

### What does "atomic" instruction mean?

This means that hardware interrupts, other processors and hyper-threads cannot interrupt the read or store and read or write a partial value to the same location.

Non atomic example:

```c++
if (foo == 0)   // CPU 0 reads memory as 0
{
    // CPU 1 writes some other value to foo
    foo = some_function();  // CPU 0 believes foo is still 0
}
```

### Static, constant values

Constexpr means const.

```c++
const     int a = 2;   // constant, defined not necessarily at compile time old C
constexpr int a = 2;   // same as above but C++14
```

Constexpr can evaluate a constant value from a function at compile time.

```c++
constexpr int foo(int a, int b){
    return a - b;
}
```

e.g. make the GPIO Table

```c++
static constexpr const sys::SOC::Table Table=SOC::set({
         {SOC::GPIO_20,sys::Pin::In::onPin<sys::reg::GPIO::P_20>}, //the interrupt handler
    });
```



---

## Various

### Trap vs. Interrupt

| Trap | Interrupt |
|:-----|:----------|
| Software to Hardware | Hardware to Software |
| synchronous / deterministic | asynchronous |
| User generated | Hardware generated |
| is an "exception" | - |

--- 

## Software Documentation

> - // [1] manuals/hifive1-getting-started-v1.0.2.pdf
> - // [2] manuals/FE310-G000.pdf
> - // [3] manuals/riscv-privileged-v1.10.pdf

--- 

### Abbreviations

- deb = debug
- pa = privileged architecture
- reg = register
- csr = Control and status registers 
- plic = Platform-Level Interrupt Controller
- mie/mip =  Machine Interrupt Registers enable/pending
- wpri = Writes Preserve / Reads Ignore Values

---

### Libraries

The following libraries are used for the exercieses. 

```c++
#include "sys/deb/deb.h"   // Debug
#include "sys/msg.h"       // UART messages
#include "sys/reg/gpio.h"  // GPIO registers
#include "sys/pa/csr.h"    // for Interrupt Controller mtvec
#include "sys/event.h"     // Event queues
#include "sys/reg/plic.h"  // main Interrupt Controller (all interrupts)priorities
```

---

### Print to Console

The `sys::msg` Interface is straight forward in its use for outputting both strings and other datatypes.

```c++
sys::msg << "Hello, World!\n";
sys::msg << "onPin " << sys::reg::GPIO.pin(p) << "\t" << (++cnt) << " times\n";

sys::deb::out(sys::deb::in()); // echo
sys::deb::hex("onExternal ", claim);
sys::msg << "onExternal " << io::ascii::hex() << claim << " not handled\n";
```

---

### GPIO

#### Initialisation

See Table below for Pinout.

```c++
static const auto myPin = sys::reg::GPIO::P_22;    // 
static const auto myBtn = sys::reg::GPIO::P_20;    // Arduino Pin 4

sys::reg::GPIO.output(myPin);   // set as output
sys::reg::GPIO.input(myBtn);   // set as input

// enable rising interrupt on pin
sys::reg::GPIO.rise_ie |= sys::reg::GPIO.mask(myBtn);  
// enable internal pull-up
sys::reg::GPIO.pue |= sys::reg::GPIO.mask(myBtn);  

```

#### Interrupt Masking

This is how you manually access the pending interrupt registers. It also shows how to clear the interrupt flag after dealing with the interrupt.

> Once the interrupt is pending, it will remain set until a 1 is written to the *_ip register at that bit.

```c++
// check the interrupt pending register
if(sys::reg::GPIO.rise_ip & sys::reg::GPIO.mask(myBtn)){
    sys::reg::GPIO.rise_ip |= sys::reg::GPIO.mask(myBtn);  // clear pending by writing '1'
    onPin(myBtn);  // call ISR
}
```

#### All Pins

Taken from `sys/reg/gpio.h`. See also `hifive.b01.schematics.pdf`.

```c++
P_00= 0,    // Arduino Pin 8 
P_01= 1,    // Arduino Pin 9 (PWM)
P_02= 2,    // Arduino Pin 10 SS (PWM)
P_03= 3,    // Arduino Pin 11 MOSI (PWM)
P_04= 4,    // Arduino Pin 12 MISO 
P_05= 5,    // Arduino Pin 13 SCK
P_08= 8,    // ?? 
P_09= 9,    // Arduino Pin 15
P_10=10,    // Arduino Pin 16
P_11=11,    // Arduino Pin 17
P_12=12,    // Arduino Pin 18 SDA
P_13=13,    // Arduino Pin 19 SCL
P_16=16,    // Arduino Pin 0 RX
P_17=17,    // Arduino Pin 1 TX
P_18=18,    // Arduino Pin 2
P_19=19,    // Arduino Pin 3 (PWM) Green LED
P_20=20,    // Arduino Pin 4
P_21=21,    // Arduino Pin 5 (PWM) Blue LED
P_22=22,    // Arduino Pin 6 (PWM) Red LED
P_23=23,    // Arduino Pin 7
```

#### All GPIO Config Properties / Interrupts

Taken from `sys/reg/gpio.h`.

> Table 52: GPIO Peripheral Register Offsets. Only naturally aligned 32-bit memory accesses are supported. Registers marked with an * are asynchronously reset to 0. All other registers are synchronously reset to 0.

```c++
unsigned value;      //0x000  pin value
unsigned input_en;   //0x004  input enable
unsigned output_en;  //0x008  pin output enable
unsigned port;       //0x00C  output port value 
unsigned pue;        //0x010  internal pull-up enable
unsigned ds;         //0x014  Pin Drive Strength
unsigned rise_ie;    //0x018  rise interrupt enable
unsigned rise_ip;    //0x01C  rise interrupt pending
unsigned fall_ie;    //0x020  fall interrupt enable
unsigned fall_ip;    //0x024  fall interrupt pending
unsigned high_ie;    //0x028  high interrupt enable
unsigned high_ip;    //0x02C  high interrupt pending
unsigned low_ie;     //0x030  low interrupt enable
unsigned low_ip;     //0x034  low interrupt pending 
unsigned iof_en;     //0x038  HW I/O Function enable
unsigned iof_sel;    //0x03C  HW I/O Function select
unsigned out_xor;    //0x040  Output XOR (invert)
```

---

### Interrupt Controller

#### Machine Trap-Vector Base-Address Register (`mtvec`)

> The mtvec register is an XLEN-bit read/write register that holds trap vector conﬁguration, consisting of a vector base address (BASE) and a vector mode (MODE).

#### Register a **callback** function to `mtvec`

> When MODE=Direct, all traps into machine mode cause the pc to be set to the address in the BASE ﬁeld. When MODE=Vectored, all synchronous exceptions into machine mode cause the pc to be set to the address in the BASE ﬁeld, whereas interrupts cause the pc to be set to the address in the BASE ﬁeld plus four times the interrupt cause number.

```c++
class App{
 static void onTrap(); //the callback
};

// Implementation:
void App::onTrap(){
 app.onPin(IN);
}

App::App(){
 sys::pa::CSR::mtvec = &App::onTrap;  // callback function for all interrupts
}


```

#### Platform-Level Interrupt Controller (PLIC)

> The PLIC connects global interrupt sources, which are usually I/O devices, to interrupt targets, which are usually hart contexts.

```c++
 // register a callback for Traps
 sys::pa::CSR::mtvec = &App::onTrap;
 // Machine Interrupt Enable in the Status register
 sys::pa::CSR::mstatus.set(1<<3);        // MIE = 1 in mstatus
 // enable specifig Interrupt Sources in the MIE
 //  7 = MTIP = Timer
 // 11 = MEIP = External (GPIO)
 sys::pa::CSR::mie.set((1<<11)|(1<<7));

 sys::reg::GPIO.input(myBtn);
 sys::reg::GPIO.rise_ie |= sys::reg::GPIO.mask(myBtn);
 sys::reg::GPIO.pue |= sys::reg::GPIO.mask(myBtn);

 sys::reg::PLIC.init();
 sys::reg::PLIC.enable(8+myBtn);  // see Table 26

```

> Table 26: PLIC Interrupt Source Mapping

| Source Start | Source End | Source |
|---:|---:|:---|
| 1  | 1  | AON Watchdog |
| 2  | 2  | AON RTC |
| 3  | 3  | UART0 |
| 4  | 4  | UART1 |
| 5  | 5  | QSPI0 |
| 6  | 6  | SPI1 |
| 7  | 7  | SPI2 |
| 8  | 39 | GPIO |
| 40 | 43 | PWM0 |
| 44 | 47 | PWM1 |
| 48 | 51 | PWM2 |
| 52 | 52 | I2C |


`mie` / `mip` Registers

- lower-privilege software interrupts (USIP, SSIP)
- machine interrupts MSIP

> Figure 3.11: Machine interrupt-pending register (`mip`).

| Bit | Name | Description |
|----:|:----:|:------------|
| 11  | MEIP | External (GPIO) |
|  9  | SEIP | External (GPIO) |
|  8  | UEIP | External (GPIO) |
|  7  | MTIP | Timer |
|  5  | STIP | Timer |
|  4  | UTIP | Timer |
|  3  | MSIP | Software |
|  1  | SSIP | Software | 
|  0  | USIP | Software |

> Figure 3.12: Machine interrupt-enable register (`mie`).

| Bit | Name | Description |
|----:|:----:|:------------|
| 11  | MEIE | External (GPIO) |
|  9  | SEIE | External (GPIO) |
|  8  | UEIE | External (GPIO) |
|  7  | MTIE | Timer |
|  5  | STIE | Timer |
|  4  | UTIE | Timer |
|  3  | MSIE | Software |
|  1  | SSIE | Software | 
|  0  | USIE | Software |

> Figure 3.6: Machine-mode status register (`mstatus`) for RV32.

| Bit | Name | Description |
|----:|:----:|:------------|
| 31  | SD |  |
| 22  | TSR | Trap SRET |
| 21  | TW | Timeout Wait |
| 20  | TVM | Trap Virtual Memory |
| 19  | MXR | Make eXecutable Readable |
| 18  | SUM | permit Supervisor User Memory access |
| 17  | MPRV | Modify PRiVilege |
| 16  | XS[1] |  |
| 15  | XS[0] |  |
| 14  | FS[1] |  |
| 13  | FS[0] |  |
| 12  | MPP[1] |  |
| 11  | MPP[0] |  |
|  8  | SPP |  |
|  7  | MPIE |  |
|  5  | SPIE |  |
|  4  | UPIE |  |
|  3  | **MIE** | Machine Interrupt Enable |
|  1  | SIE | Software Interrupt Enable |
|  0  | UIE | User Interrupt Enable |


### Claim

> On receiving a claim message, the PLIC core will atomically determine the ID of the highest-priority pending interrupt for the target and then clear down the corresponding source’s IP bit.

```c++
sys::msg<<"------------------ onTrap\n" 
         <<"mcause="<<io::ascii::hex()<<sys::pa::CSR::mcause<<"\n"  //see [3] 3.1.20
         <<"claim ="<<io::ascii::hex()<<sys::reg::PLIC.claim<<"\n"; //see [3] 7.10
```



