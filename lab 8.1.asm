;Mohammed Abdallah                                                      
    
;************************************LAB8********************************************    
    
          ;INCLUDE 'mc9s12dp512.inc'  
;********************************************************************************

          INCLUDE "C:\mohammed\mohammed\hcs12.inc"
	        org	$2000
cnt   	dc.b	0

	        org	$1000
start	    movb	#$FF,DDRB	    ; configure port B for output
         	bset	DDRJ,$02	    ; configure PJ1 pin for output
        	bclr	PTJ,$02	      ; enable LEDs to light
        	
        	movb	#$FF,DDRP	    ; configure port P for output
          movb	#$0F,PTP	    ; disable it
          
          movb	#$00,PORTB	    ;
          movb  #$00, DDRH 
          clr cnt
          
          
        	
loop      ldaa PTH
          cmpa #$FE
          beq sw2
          cmpa #$F7
          beq sw5
          bra loop
          
          
sw2       inc cnt
          
          ldab cnt
          stab PORTB
          ldy #1
          jsr delayby10ms
          
sw2down   ldaa PTH
          cmpa #$FE
          beq sw2down
          
          bra loop
          
          
          
sw5       dec cnt
          
          ldab cnt
          stab PORTB
          ldy #1
          jsr delayby10ms
          
sw5down   ldaa PTH
          cmpa #$F7
          beq sw5down
          
          bra loop
	
	
	
	
      	INCLUDE	"C:\mohammed\mohammed\delay.asm"
      	org	$FFFE	        ; uncomment this line for CodeWarrior
	      dc.w	start     	; uncomment this line for CodeWarrior
	      
	      
	      end