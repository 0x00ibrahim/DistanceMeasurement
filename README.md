# DistanceMeasurement

---

In this study, servo motor control has been done by using PIC16F628A microcontroller and HC-SR04 distance sensor. For the microcontroller, microC compiler and PICkit2 programming board used. The circuit diagram has been drawn by using Proteus.
In order to measure the distance between the obstacle and the sensor, a 10 microsecond trigger signal was sent to the ultrasonic sensor by the microcontroller and the echo signal expected to be received. Then, the elapsed time was calculated with the help of the microcontroller's timer circuit and the distance was measured. If the distance value is within the desired range, the PWM signal was generated, the servo motor was rotated 180 degrees and the LED was turned on.

Keywords: PIC16F628A microcontroller,HC-SR04 ultrasonic sensor,servo motor,MicroC compiler,Proteus,distance measurement.

---

Proteus Drawing

![image](https://user-images.githubusercontent.com/27640916/131229186-a8b7f0b1-c4c2-4a3b-86cc-f4287b1329b0.png)

