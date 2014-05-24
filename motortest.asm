                                              ;Mohammed Abdallah                                                      
    
;************************************LAB8********************************************    
    
          ;INCLUDE 'mc9s12dp512.inc'  
;********************************************************************************

          INCLUDE "C:\mohammed\hcs12.inc"

	        org	$1000
start:	    
			;movb	#$EB,DDRB	    ; configure port B as 11101011

         	bset  DDRB,$01	    ; pin 0 motor output
         	bset  DDRB,$02      ; pin 1 motor output
              
loop:          ;set the direction of motor
          bclr PTB, $01  ;set motor pin 0 to ground
          bset PTB, $02  ;set motor pin 1 to on

          ldy #300          ;delay the door dropping by 3 seconds
          jsr delayby10ms
          
            ;reverse the direction of motor
          bclr PTB, $02  ;set motor pin 1 to ground
          bset PTB, $01  ;set motor pin 0 to on
          
          ldy #300          ;delay the door dropping by 200 mseconds
          jsr delayby10ms
		            
         
		  bra loop
	
	
	      swi
	
	
      	INCLUDE	"C:\mohammed\delay.asm"
      	
      	org	$FFFE	        ; uncomment this line for CodeWarrior
	      dc.w	start     	; uncomment this line for CodeWarrior
	      
	      
	      end