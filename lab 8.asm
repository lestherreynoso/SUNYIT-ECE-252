  ;---------------------------------------------------------------------------------
  ;Lab 8
  ;Parallel I/O
  ;Dmitriy, Lesther, Alex P. 4/18/2013
  ;To make use of the parallel ports to interface simple devices 
  ;in a program tha countrs and displays switch activations on the LEDs
  ;---------------------------------------------------------------------------------
  
  ABSENTRY Entry  
  INCLUDE 'mc9s12dp256.inc'
  
;Data section------------------------------------------ 

  
     
out:				;end of program 
  end  
  
  
  ;----------------------------------------------
  
HERE JMP HERE
  END
  
  ORG $FFFE  
  DC.W ENTRY ;RESET VECTOR
  ;-------------------------------------