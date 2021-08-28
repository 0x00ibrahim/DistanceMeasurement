#line 1 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/Proje/DistanceMeasurement.c"
#line 8 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/Proje/DistanceMeasurement.c"
void main()
{
 int a;
 int counter;
 TRISB = 0b00000100;
 T1CON = 0x00;

 while(1)
 {
 TMR1H = 0;
 TMR1L = 0;

 PORTB.F0 = 1;
 Delay_us(10);
 PORTB.F0 = 0;

 while(!PORTB.F2);

 T1CON.F0 = 1;
 while(PORTB.F2);
 T1CON.F0 = 0;

 a = (TMR1L | (TMR1H<<8));
#line 45 "C:/Users/Public/Documents/Mikroelektronika/mikroC PRO for PIC/Examples/Proje/DistanceMeasurement.c"
 a = (a/58.82)/5;



 a = a + 1;


 if(a>=2 && a<=50)

 {
 PORTB.F3=1;
 for(counter=0;counter<50;counter++)
 {
 PORTB.F4 = 1;
 Delay_us(2200);
 PORTB.F4 = 0;
 Delay_us(17800);
 }

 }else{
 PORTB.F3=0;

 for(counter=0;counter<50;counter++)
 {
 PORTB.F4 = 1;
 Delay_us(800);
 PORTB.F4 = 0;
 Delay_us(19200);
 }
 }
 }
 }
