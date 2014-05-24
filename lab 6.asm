  ;---------------------------------------------------------------------------------
  ;Lab 6
  ;Subroutines
  ;Dmitriy, Lesther, Alex P. 4/4/2013
  ;To use basic program subroutines instructions 
  ;To find: the number of students who recieved each letter grade
  ;---------------------------------------------------------------------------------
  
  ABSENTRY Entry  
  INCLUDE 'mc9s12dp256.inc'
  
  
;Data section------------------------------------------ 
  org $1000
array dc.b 76, 95, 87, 92, 87, 91, 91, 100, 79, 50
      dc.b 81, 86, 100, 90, 77, 54, 87, 100, 87, 79
	  dc.b 77, 76, 100, 100, 82, 85, 100, 100, 51, 100
	  dc.b 83, 82, 100, 92, 92, 91, 66, 62, 80, 82, 79
aa rmb 1
bb rmb 1
cc rmb 1
dd rmb 1
ff rmb 1
i rmb 1

;Clear results-------------------------------------------------------
  org $2000
Entry:
  ldaa #1			;load a with 1
  staa i			;store a which is 1 into i
  ldaa #0 			;load a with 0
  staa aa			;intialize aa thru ff
  staa bb
  staa cc
  staa dd
  staa ff
  lds #$4000		;set the stack pointer
N equ 41			;N=41
  ldd #$1000		;load d with value $1000
  pshd				;push into stack
  jsr grade_calc	;jump to subroutine grade_calc
  bra out			;leave program
  
swi
grade_calc:			;enter subroutine
  ldy 2, sp			;load the value $1000 into y 
Loop:
  ldaa i			;load a with i
  cmpa #N			;compare i with n
  bgt outside		;if greater than go outside
  ldaa 0,y			;else load the value stored at memory location 0,y
  cmpa #90          ;compare with the value 90
  blt less90		;if less than 90 branch to less90
  inc aa			;else incriment aa
  bra next			;branch to next
less90:
  cmpa #80			;compare with value 80
  blt less80		;if less than 80 branch to less80
  inc bb			;else incriment bb
  bra next			;branch to next
less80:
  cmpa #70			;compare with value 70
  blt less70		;if less than 70 branch to less70
  inc cc			;else increment cc
  bra next			;branch to next 
 less70:
  cmpa #60			;compare with value 60
  blt less60		;if less than 60 branch to less 60
  inc dd 			;else incriment dd
  bra next			;branch to next
less60:
  inc ff			;increment ff because its less than 60
next:
  iny				;increment y to point to the next number
  inc i				;increment counter 
  bra Loop			;branch to loop 
outside:
  rts				;return from subroutine	
  
out:				;end of program 
  end  
  
  
  ;------------------------------------------------------------------
  
HERE JMP HERE
  END
  
  ORG $FFFE  
  DC.W ENTRY ;RESET VECTOR
  ;-------------------------------------