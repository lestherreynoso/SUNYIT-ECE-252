  ;---------------------------------------------------------------------------------
  ;lAB 2
  ;Basic Arithmetic programming
  ;Dmitriy, Lesther, Alex P. 2/14/2013
  ;To practice using arithmatic functions  
  ;To find: sum, average, differance
  ;---------------------------------------------------------------------------------
  
  ABSENTRY Entry  
  INCLUDE 'mc9s12dp256.inc'
  
  ;-------------------------------------------------------
  
  org $2000				                ;start at memory location $2000

label dc.b 50, 188, 63, 211, 3 		;store these into memory locations $2000-$2004

  ;-------------------------------------------------------------------------
  org $1000      		             	;start program at memory location $1000
  
Entry:
  
  ldab $2000			               	;B <- 50
  ldx #0		                      ;x <- 0
  abx					                    ;X <- B + X (50+0), X is now 50
  ldab $2001	              			;B <- 188
  abx				                     	;X <- B + X (188+50), X is now 238
  ldab $2002		              		;B <- 63
  abx					                    ;X <- B + X (63+238), X is now 301
  ldab $2003	              			;B <- 211
  abx					                    ;X <- B + X (211+301), X is now 512 
  ldab $2004		              		;B <- 3
  abx					                    ;X <- B + X (3+512), X is now 515 
  stx $2010				                ;m[$2010] <- X 	store sum in [$2010]
  ldd $2010			                	;D <- m[2010]
  ldx #5				                  ;X <- 5
  idiv				                  	;X <- D/X	515/5
  stx $2012			                 	;m[2012] <- X  average
  std $2008			                 	;m[2008] <- D   remainder if there is one which there isnt
  ldd $2010			                	;D <- m[2010]
  subd $2012			               	;D <- D - m[2012]
  std $2014			                	;m[2014] <- D
  
  ;------------------------------------------------------------------
  
HERE JMP HERE
  END
  
  ORG $FFFE  
  DC.W ENTRY ;RESET VECTOR
  ;--------------------------------------------