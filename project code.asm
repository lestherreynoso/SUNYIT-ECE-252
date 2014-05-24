;DC motor control using the H-Bridge on Dragon12 with Channel 0 PWM
;Dragon12 board comes with TI's 754410 H-bridge driver (Google for data sheet and study it)
;On Dragon12 board PORTB and PORTP are used to control BOTH 754410 chip and 7-seg LEDs
;WE CANNOT USE BOTH 7-SEG LEDs and 754410 AT THE SAME TIME.
;J24 (on left side of CPU) is used to provide power to 7-seg LEDs driver 
;and J18 (at the bottom left side of the board by the buzzer) is used to provide power to H-bridge driver.
;ONLY ONE OF THEM SHOULD HAVE A JUMPER
;The Dragon12 is shipped with J24 (7-Seg LEDs) power enabled and nothing on J18.
;If you want to use H-Bridge you MUST move the jumper from J24 to J18. ONLY ONE OF THEM SHOULD HAVE A JUMPER

;On Dragon12 the PP0 (PWM chan 0) is connected to EN12 pin of 754410.
;PB0 is connected to 1A and PB1 to 2A input pins of the 754410. That means M1 (1Y) and M2 (2Y) outputs are controled by PB0,PB1 and PP0.
;Also the PP1 (PWM chan 1) is connected to EN34 pin of 754410.
;PB2 is connected to 3A and PB3 to 4A input pins of the 754410. That means M3 (3Y) and M4 (4Y) outputs are controled by PB2,PB3 and PP1.


;The 754410 chip allows to have an external power source of up to 36V (4.5V-36V) to drive DC motor. DO NOT USE MORE THAN 9 V
;The Dragon12 board allows you to use an external power source of your own. See T4 screw terminal on the bottom left of the board
;To use your own external power source for 754410 PUT the jumper on lower 2 pins.

;Steps to connect and run this program to control DC motor
;1)move jumper from J24 to J18 to power the 754410 chip
;2)Connect an external 5V-9V DC power to the VEXT and GND pins on T4 Terminal Block
;3)Next to the VEXT place a jumper to lower 2 pins.
;4)Connect the + lead of your DC motor to M1 pin in T4 Terminal block
;5)Connect the - lead of your DC motor to M2 pin in T4 Terminal block

;Now, power your Dragon12 board and 
;Compile (F7), Download (F5) and run(F5), this program
;This program will turn the DC motor clockwise (CW)for 3 seconds,
;then it stops and turns CCW for 3 seconds. It always stops and rest for 1 second before changing direction
;It does that continuosly.       

;Written, modified, and tested by M. Mazidi based on Example 17-12 of Mazidi HCS12 book. 

;for PWM and DC motor control see chapter 17 of HCS12 book by Mazidi & Causey.  

   
        ABSENTRY Entry        ; for absolute assembly: mark this as application entry point
    
; Include derivative-specific definitions 
		INCLUDE 'mc9s12dp256.inc'     ;CPU used by Dragon12+ board
 
 
;----------------------USE $1000-$2FFF for Scratch Pad 
R1      EQU     $1001
R2      EQU     $1002
R3      EQU     $1003
R4      EQU     $1004


;code section
        ORG   $4000     ;Flash ROM address for Dragon12+
Entry:
	      LDS     #$4000    ;Stack
        BSET    DDRB,%00000011		;PORTB as output since the M1 and M2 drivers are controlled by PB0 and PB1 pins
        BCLR    PORTB,%00000000;  ;Stop DC motor(PB0=0 and PB1=0). 
                    ;NOTICE ONLY ONE OF THEM CAN BE ON FOR TURNING CLOCKWISE (CW PB0=1) OR COUNTER CLOCKWISE (CCW PB1=1)
                    ;DO NOT NOT USE PB0=1 AND PB1=1 AT THE SAME TIME.
         	bclr  DDRB,%00000100      ; pin 2 floor btn input
         	bset  DDRB,%00001000     ; pin 3 floor btn output
         	bclr  DDRB,%00010000      ; pin 4 door btn input
         	bset  DDRB,%00100000     ; pin 5 door btn output
         bset  PTB, %00001000       ; pin 5 door btn output to 5v
         	bset  PTB, %00100000       ; pin 3 floor output to 5v
          bset  DDRH, %11111110
 ;movb #$FF, DDRH
 
loop2:  
         brset PTH, %00000001, preb
         ;ldaa PTH	 ;read in Port H to see switch 
         ;cmpa #$FE   ;check if switch 2 has been pressed
         ;beq mtn     ;simulate sensor branch to sensor on
         bra loop2
         
;-------Toggling ALL LEDs connected to PORTB

preb:   
        MOVB #$05,PWMPRCLK    ;ClockA=Fbus/2**5=24 MHz/32=750000 Hz   	
	      MOVB #$0,PWMCLK		    ;use ClockA for chan 0 PWM
	      MOVB #01,PWMPOL		    ;high then low for polarity
	      MOVB #0,PWMCAE		    ;left aligned
	      MOVB #$0,PWMCTL	      ;8-bit channel, PWM during freeze and wait
	      MOVB #0,PWMCNT0		    ;set the initial PWM count to zero
	      BSET PWME,%00000001   ;turn on PWM chan 0

BACK    MOVB #100,PWMPER0	    ;PWM_Freq =ClockA/100=750000 Hz/100=7500 Hz
	      MOVB #60,PWMDTY0	    ;60% duty cycle(60% x 100=60). Change this value and experiment with duty Cycle
        BSET PORTB, %00000001 ;PB0=1 to turn DC motor clockwise (DO NOT USE %00000011 FOR BOTH ON)
       
doorbtn:           
          brset PTB, %00010000, btnprsd  ;branch if door btn pin 4 in on (pressed)
          bra doorbtn   
btnprsd:       
        ;LDAA #3                                                      
        ;JSR  SDELAY            ;keep turning for 3 sec 
        BCLR PORTB, %00000001 ;stop the motor
        LDAA #3               ;and rest for 3 sec before changing direction
        JSR  SDELAY
        BSET PORTB, %00000010 ;PB1=1 to turn DC motor counter clockwise (DO NOT USE %00000011 FOR BOTH ON)
        LDAA #3               ;do it for 3 sec
        JSR  SDELAY
        BCLR PORTB, %00000010 ;stop the motor
        
floor:     
        brset PTB, %00000100, flrprsd  ;branch if floor button is pressed
        bra floor
          
flrprsd:
        BSET PORTB, %00000001 ;PB0=1 to turn DC motor clockwise (DO NOT USE %00000011 FOR BOTH ON)
        brset PTB, %00010000, btnprsd2  ;branch if door btn pin 4 in on (pressed)
          bra flrprsd
          
btnprsd2:
        BCLR PORTB, %00000001 ;stop the motor
        LDAA #3               ;and rest for 3 sec before changing direction
        JSR  SDELAY
        BSET PORTB, %00000010 ;PB1=1 to turn DC motor counter clockwise (DO NOT USE %00000011 FOR BOTH ON)
        LDAA #3               ;do it for 3 sec
        JSR  SDELAY
        BCLR PORTB, %00000010 ;stop the motor                
        
        LDAA #5               ;and rest for 1 sec before changing direction
        JSR  SDELAY            ;keep doing it.
         
        BRA loop2    
  
;----------SDELAY IS ONE SECCOND 
SDELAY

        PSHA		;Save Reg A on Stack
        STAA    R4
        CMPA    #0      ;if zero sec then exit
        BEQ     OVER 
;--1 Second delay. The Serial Monitor works at speed of 48MHz with XTAL=8MHz on Dragon12+ board
;Freq. for Instruction Clock Cycle is 24MHz (1/2 of 48Mhz). 
;(1/24MHz) x 10 Clk x240x100x100 = 1 sec. Overheads are excluded in this calculation.         

L4      LDAA    #100	  
        STAA    R3		
L3      LDAA    #100
        STAA    R2
L2      LDAA    #240
        STAA    R1
L1      NOP         ;1 Intruction Clk Cycle
        NOP         ;1
        NOP         ;1
        DEC     R1  ;4
        BNE     L1  ;3
        DEC     R2  ;Total Instr.Clk=10
        BNE     L2
        DEC     R3
        BNE     L3
        DEC     R4
        BNE     L4
        
;--------------        
OVER    PULA			;Restore Reg A
        RTS
;-------------------

            
;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry     ;Reset Vector. CPU wakes here and it is sent to start of the code at $4000

