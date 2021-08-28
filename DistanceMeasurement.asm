
_main:

;DistanceMeasurement.c,8 :: 		void main()
;DistanceMeasurement.c,12 :: 		TRISB = 0b00000100;           //RB2 as Input PIN (ECHO)
	MOVLW      4
	MOVWF      TRISB+0
;DistanceMeasurement.c,13 :: 		T1CON = 0x00;                 //Prescaler value set as 1:1
	CLRF       T1CON+0
;DistanceMeasurement.c,15 :: 		while(1)
L_main0:
;DistanceMeasurement.c,17 :: 		TMR1H = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1H+0
;DistanceMeasurement.c,18 :: 		TMR1L = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1L+0
;DistanceMeasurement.c,20 :: 		PORTB.F0 = 1;               //TRIGGER HIGH
	BSF        PORTB+0, 0
;DistanceMeasurement.c,21 :: 		Delay_us(10);               //10uS Delay
	MOVLW      16
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	NOP
;DistanceMeasurement.c,22 :: 		PORTB.F0 = 0;               //TRIGGER LOW
	BCF        PORTB+0, 0
;DistanceMeasurement.c,24 :: 		while(!PORTB.F2);           //Wait for Echo
L_main3:
	BTFSC      PORTB+0, 2
	GOTO       L_main4
	GOTO       L_main3
L_main4:
;DistanceMeasurement.c,26 :: 		T1CON.F0 = 1;               //Timer Starts
	BSF        T1CON+0, 0
;DistanceMeasurement.c,27 :: 		while(PORTB.F2);            //Waiting for Echo goes LOW
L_main5:
	BTFSS      PORTB+0, 2
	GOTO       L_main6
	GOTO       L_main5
L_main6:
;DistanceMeasurement.c,28 :: 		T1CON.F0 = 0;               //Timer Stops
	BCF        T1CON+0, 0
;DistanceMeasurement.c,30 :: 		a = (TMR1L | (TMR1H<<8));   //Read Timer Value.
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      main_a_L0+0
	MOVF       R0+1, 0
	MOVWF      main_a_L0+1
;DistanceMeasurement.c,45 :: 		a = (a/58.82)/5;            //Since the meter step interval is 0.2
	CALL       _int2double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      main_a_L0+0
	MOVF       R0+1, 0
	MOVWF      main_a_L0+1
;DistanceMeasurement.c,49 :: 		a = a + 1;                  //Distance Calibration (Rounded up because
	MOVF       R0+0, 0
	ADDLW      1
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      main_a_L0+0
	MOVF       R2+1, 0
	MOVWF      main_a_L0+1
;DistanceMeasurement.c,52 :: 		if(a>=2 && a<=50)           //Check if the result is between 2cm and
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      2
	SUBWF      R2+0, 0
L__main23:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main24
	MOVF       main_a_L0+0, 0
	SUBLW      50
L__main24:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
L__main21:
;DistanceMeasurement.c,55 :: 		PORTB.F3=1;              // LED Turns On
	BSF        PORTB+0, 3
;DistanceMeasurement.c,56 :: 		for(counter=0;counter<50;counter++)  //180 Degree
	CLRF       main_counter_L0+0
	CLRF       main_counter_L0+1
L_main10:
	MOVLW      128
	XORWF      main_counter_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main25
	MOVLW      50
	SUBWF      main_counter_L0+0, 0
L__main25:
	BTFSC      STATUS+0, 0
	GOTO       L_main11
;DistanceMeasurement.c,58 :: 		PORTB.F4 = 1;
	BSF        PORTB+0, 4
;DistanceMeasurement.c,59 :: 		Delay_us(2200);
	MOVLW      15
	MOVWF      R12+0
	MOVLW      71
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	NOP
	NOP
;DistanceMeasurement.c,60 :: 		PORTB.F4 = 0;
	BCF        PORTB+0, 4
;DistanceMeasurement.c,61 :: 		Delay_us(17800);
	MOVLW      116
	MOVWF      R12+0
	MOVLW      148
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	NOP
;DistanceMeasurement.c,56 :: 		for(counter=0;counter<50;counter++)  //180 Degree
	INCF       main_counter_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_counter_L0+1, 1
;DistanceMeasurement.c,62 :: 		}
	GOTO       L_main10
L_main11:
;DistanceMeasurement.c,64 :: 		}else{
	GOTO       L_main15
L_main9:
;DistanceMeasurement.c,65 :: 		PORTB.F3=0;          //LED Turns Off
	BCF        PORTB+0, 3
;DistanceMeasurement.c,67 :: 		for(counter=0;counter<50;counter++)    //0 Degree
	CLRF       main_counter_L0+0
	CLRF       main_counter_L0+1
L_main16:
	MOVLW      128
	XORWF      main_counter_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVLW      50
	SUBWF      main_counter_L0+0, 0
L__main26:
	BTFSC      STATUS+0, 0
	GOTO       L_main17
;DistanceMeasurement.c,69 :: 		PORTB.F4 = 1;
	BSF        PORTB+0, 4
;DistanceMeasurement.c,70 :: 		Delay_us(800);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	NOP
;DistanceMeasurement.c,71 :: 		PORTB.F4 = 0;
	BCF        PORTB+0, 4
;DistanceMeasurement.c,72 :: 		Delay_us(19200);
	MOVLW      125
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	NOP
	NOP
;DistanceMeasurement.c,67 :: 		for(counter=0;counter<50;counter++)    //0 Degree
	INCF       main_counter_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_counter_L0+1, 1
;DistanceMeasurement.c,73 :: 		}
	GOTO       L_main16
L_main17:
;DistanceMeasurement.c,74 :: 		}
L_main15:
;DistanceMeasurement.c,75 :: 		}
	GOTO       L_main0
;DistanceMeasurement.c,76 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
