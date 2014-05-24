  ;---------------------------------------------------------------------------------
  ;Lab 4
  ;Loop and Branch
  ;Dmitriy, Lesther, Alex P. 2/28/2013
  ;To use basic program loop and branch instructions 
  ;To find: the number of even and odd numbers in an array
  ;---------------------------------------------------------------------------------
  
  ABSENTRY Entry  
  INCLUDE 'mc9s12dp256.inc'
  
  ;-------------------------------------------------------
  
      org $1100		                    ;start at $1100
array dc.w 133, 1200, 1390, 1900, 1881	
      dc.w 3939, 2010, 4080, 9801, 4592
      dc.w 11, 22, 33, 3333, 3242
      dc.w 5435, 8760, 9800, 2876, 9601
n equ 20
i rmb 1
      org $1000
even_cnt rmb 1        ;reserving memory location $1000~$1002
odd_cnt rmb 1
M rmb 1      

  ;-------------------------------------------------------

      org $2000
Entry:
      ldy #array      	;y <- array ($1100)
      movb #0, i        ;initializing the values
      movb #0, even_cnt
      movb #0, odd_cnt
Loop: 
      ldaa i            ;a <- i 
      cmpa #n           ;compare i & n
      beq Sum		        ;if equal go to Sum
      		            	;else
      ldd 0, y	       	;d <- y  (value at memory location y)
      ldx #2	        	;x <- 2
      idiv	          	;d/x remainder in d result in x
      tstb		          ;test if b is zero
      bne Odd	        	;if b is not equal go to odd
			                  ;else (b is zero and number is even)
      inc even_cnt      ;increment even count
      inc i	          	;incrememt i
      iny	            	;increment y twice
      iny
      bra Loop	      	;go back to loop

Odd:  
      inc odd_cnt       ;increment odd count
      inc i		          ;incrememt i
      iny		            ;increment y twice
      iny
      bra Loop	      	;go back to loop

Sum:  
      ldaa even_cnt	    ;a <- even_cnt
      ldab odd_cnt	    ;b <- odd_cnt
      aba		            ;a < a+b
      staa M		        ;M <- a

      end

  ;------------------------------------------------------------------
  
HERE JMP HERE
  END
  
  ORG $FFFE  
  DC.W ENTRY ;RESET VECTOR
  ;-------------------------------------