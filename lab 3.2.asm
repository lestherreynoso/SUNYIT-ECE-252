  ;---------------------------------------------------------------------------------
  ;lAB 3 part 2
  ;Program 2: Extended Direct Addressing
  ;Directives, addressing modes and basic arithmetic programming
  ;Dmitriy, Lesther, Alex P. 2/21/2013
  ;To add two numbers together using extended direct addressing
  ;To find: sum
  ;---------------------------------------------------------------------------------
  
  ABSENTRY Entry  
  INCLUDE 'mc9s12dp256.inc'
  
  ;-------------------------------------------------------
  org $2000 
label dc.w $2356, $7FFF, $005E
	org $1000			 ;start at $1000
Entry:	
	ldd $2000			;D <-- $2356
	addd $2002    ;D <--D+$7FFF
	std $1200     ;m[$1200]<--D
	  
	addd $2004		;D <--D+$005E
	std $1200	  	;m[$1200]<--D               

	
	;------------------------------------------------------------------
  
HERE JMP HERE
  END
  
  ORG $FFFE  
  DC.W ENTRY ;RESET VECTOR
  ;-------------------------------------