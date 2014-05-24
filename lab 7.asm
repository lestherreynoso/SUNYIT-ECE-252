  ;---------------------------------------------------------------------------------
  ;Lab 7
  ;Subroutines
  ;Dmitriy, Lesther, Alex P. 4/11/2013
  ;To use basic program subroutines instructions 
  ;To find: the solution to the quadratic equation 
  ;---------------------------------------------------------------------------------
  
  ABSENTRY Entry  
  INCLUDE 'mc9s12dp256.inc'
  
;Data section------------------------------------------ 
  org $1000 
aa rmb 1
bb rmb 1
cc rmb 1
i rmb 1
r1 rmb 2
r2 rmb 2
r3 rmb 2
r4 rmb 1
r5 rmb 1
r7 rmb 1
  org $1050
fin1 rmb 1
fin2 rmb 1

;Clear results-------------------------------------------------------
  org $2000
Entry:
  movb #1, aa				
  movb #6, bb
  movb #5, cc
  movw #0, r1
  movw #0, r2
  movw #0, r3
  movb #0, r4
  movb #0, r5
  movb #0, r7
  movw #0, fin1
  movw #0, fin2
  movb #0, i
  
;-----------------------------------
start lds #$4000
  ldaa aa
  psha
  ldaa bb
  psha
  ldaa cc
  psha
    
  jsr Qequ
 
  swi
  
  
 Qequ:
 ;Step 1 bsquared----------------------
 
  ldab 3, sp			;load b from the stack into b
  ldaa 3, sp			;load b from the stack into a
  mul					;multiply a and b and store in a:b or D
  std r1				;store the b squared into result 1
  
 ;Step 2 4ac -------------------------------------
 
  ldaa 4, sp			;load a from the stack into a 
  ldab 2, sp            ;load c from the stack into b
  mul 					;multiply a and b and store in a:b or D
  std r2				;store a times c which is in d into result 2
  ldy r2				;load r2 into y
  ldd #$4				;load 4 into d
  emul					;multiply y and d and store into y:d
  std r2				;store the result into result 2
  
 ;Step 3 bsquared - 4ac---------------------------------
  
  ldd r1				;load into d result 1
  subd r2				;subtract from d result 2
  std r3				;store result 3
  
 ;Branch options ---------------------------------------------------  
 
  cpd #0				;compare d to 0
  bgt greater			;brach to greater if greater than 0
  beq equal				;branch to equal if equal
  blt less				;branch to less if less than because that means no solution

;Step 4 -------------------------------------------  
greater:  
Loop:
  inc i            ;start i at 1
  ldaa i
  ldab i
  mul
  cpd r3
  bge continue
  bra Loop
  
continue:
  movb i, r4

;Step 5 r4-b -----------------------------------
  ldaa r4
  ldab 3,sp
  sba 
  staa r5
  
;Step 6 r5/2a------------------------------------
  ldaa #$2				;load 2 into a 
  ldab 4,sp				;load a into b
  mul 
  tfr d, x
  ldd r5
  idivs
  stx fin1
  
;Step 7 r4 + b --------------------------------------
  ldaa r4
  ldab 3,sp
  aba
  staa r7
;Step 8 perform twos compliment ----------------------------
  neg r7
  ldaa #$2				;load 2 into a 
  ldab 4,sp				;load a into b
  mul 
  tfr d, x
  ldd r7
  idivs
  stx fin2
  bra exit
  
equal: 
  neg 3, sp				;makes b negative
  ldaa #$2				;load 2 into a 
  ldab 4,sp				;load a into b
  mul					;multiply a and b 
  tfr d, x				;store result in x
  ldd 3, sp				;load into d negative b
  idivs					;divide d/x and store into x
  stx fin1				; store the result in fin1 and fin2
  stx fin2
  bra exit				;exit 
  
less:
  movb #$FF, $1052		;store all ones in $1052
  bra exit
  
exit:
  rts
  
     
out:				;end of program 
  end  
  
  
  ;------------------------------------------------------------------
  
HERE JMP HERE
  END
  
  ORG $FFFE  
  DC.W ENTRY ;RESET VECTOR
  ;-------------------------------------