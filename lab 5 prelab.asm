  ;---------------------------------------------------------------------------------
  ;Lab 5
  ;Nested Loops
  ;Dmitriy, Lesther, Alex P. 4/2/2013
  ;To use basic program loop and branch instructions 
  ;To find: a sorted array in decending order
  ;---------------------------------------------------------------------------------
  
  ABSENTRY Entry  
  INCLUDE 'mc9s12dp256.inc'
  
  
;Data section------------------------------------------ 
  org $1000
array dc.b 15, 20, 14, 13, 17, 9, 10, 5, 18, 7
      dc.b 19, 8, 1, 3, 4, 11, 2, 6, 12, 16

;Results-------------------------------------------------------
  org $1500
tmp rmb 1 
i rmb 1
j rmb 1
;clearing result locations-------------------------------------------------------
  org $2000
Entry:
  movb #0, tmp			;clearing variables
   
;initializing the counter------------------------------------------------------- 
  movb #1, i
  movb #2, j
  
;load first number-------------------------------------------------------
  ldy #array			;load first memory location into y
  ldx #array			;load first memory location into x
  inx					;start x of at the second number
  
;start loops ----------------------------------------------------------
outerloop:
  
  ldaa i 				;load i into a
  cmpa #20				;check if i has reached the last number 
  beq out				;if yes we are done and numbers should be sorted
  ldab 0,y				;else load number at memory location 0,y into b
  
innerloop:

  ldaa j				;load j into a
  cmpa #20				;check if j passed the last number
  bhi skip2				;if yes go to skip 2
    
  cmpb 0,x				;compare b to number at memory location 0,x
  bgt skip				;if b is greater than x go to skip 
  movb 0,y, tmp         ;else move number at 0,y to temp
  movb 0,x, 0,y         ;move number at 0,x to 0,y
  movb tmp, 0,x         ;move number at temp to 0, x

skip: 
  inx					;increment memory location of pointer 2
  inc j					;incrememnt second counter
  bra innerloop         ;branch back to inner loop

skip2:
  iny 					;increment memory location of pointer 1
  inc i					;increment first counter 
  ldaa i				;load new starting point of i into a
  staa j 				;store the new starting point into j
  inc j					;increment j to start next to i
  tfr y,x       ;load into x the starting point of y 				
  inx 					;increment x to start next to y 
  bra outerloop			;branch back to outer loop
  
out: 
  end  
  
  
  ;------------------------------------------------------------------
  
HERE JMP HERE
  END
  
  ORG $FFFE  
  DC.W ENTRY ;RESET VECTOR
  ;-------------------------------------