  ;---------------------------------------------------------------------------------
  ;lAB 3
  ;Program 1: Immediate Addressing
  ;Directives, addressing modes and basic arithmetic programming
  ;Dmitriy, Lesther, Alex P. 2/21/2013
  ;To add two numbers together 
  ;To find: sum
  ;---------------------------------------------------------------------------------
  
  ABSENTRY Entry  
  INCLUDE 'mc9s12dp256.inc'
  
  ;-------------------------------------------------------
  
                    
	org $1000			;start at $1000
Entry:	
	ldd # $2356			;D <-- $2356
	addd # $7FFF		;D <-- D + $7FFF
	std $3000			  ;D--> m[$3000]
	addd # $005E		;D <-- D + $005E
	std $1200			  ;D--> m[$1200]
	
	;------------------------------------------------------------------
  
HERE JMP HERE
  END
  
  ORG $FFFE  
  DC.W ENTRY ;RESET VECTOR
  ;-------------------------------------