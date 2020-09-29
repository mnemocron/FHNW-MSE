//-----------------------
//hardware-register-extern.cc led
//(c) H.Buchmann FHNW 2020
// [1] manuals/hifive1b-getting-started-guide_v1.1.pdf
// [2] manuals/fe310-g002.pdf
//-----------------------
//red LED GPIO bit 22
IMPLEMENTATION(gpio_0,$Id$)
#include "sys/deb/deb.h"
#include "sys/msg.h"

extern struct  //[1] p20 [2] Chapter 17
{
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
} GPIO;

class App
{
 static App app;
 static const unsigned RED = 22; 
 static const unsigned GRN = 19; 
 static const unsigned BLU = 21; 
 App();
};


App App::app;

App::App()
{
 GPIO.output_en |=  ((1 << RED) | (1 << GRN) | (1 << BLU));
 GPIO.input_en  &= ~((1 << RED) | (1 << GRN) | (1 << BLU));
 GPIO.port |=  ((1 << RED) | (1 << GRN) | (1 << BLU));

 while(true)
 {
  sys::msg<<"(s)et (c)lr LED\n";
  switch(sys::deb::in())
  {
   case 's': //set
   {
    auto port = GPIO.port | (1<<RED);
    port  &= ~(1 << GRN);
    GPIO.port = port;
   }
   break;

   case 'c': //clear
   {
    auto port = GPIO.port &~(1<<RED);
    port |=  (1 << GRN);
    GPIO.port = port;
   }
   break;
  }
 } 
}
