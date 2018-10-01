TITLE Program HW301112VLDiamondProgram15    (HW301112VLDiamondProgram15.asm)

; Program Description:This program prints out a array of rainbow diamond.
; Author:Victor Li
; Date Created:11/12/2016
; Last Modification Date:11/12/2016

INCLUDE Irvine32.inc

.data

   a dword 1          ;range of 1-14
   b dword 14
   delta dword 0
   symbol byte 'x'
   y byte 0
   x byte 7
   counter  dword 0    ;outter loop for Triangle PROC
   counter2 dword 1   ;Inner loop for Triangle PROC
   counter3 dword 13  ;Inner loop for UpsidedownTriangle PROC
   counter4 dword 0   ;Outter loop for UpsidedownTriangle PROC
.code
main PROC

  call makeDelta 
  call randomize
  call clrscr
  
  
    mov ecx,6
      myloop:                      ;EACH MYLOOP CREATES DIAMONDS FOR ONE ROW.
            push ecx           
			mov dl,x
            mov dh,y
            call gotoxy	 
            call triangle
            call upsideDownTriangle
			mov y,0                ;Setting y=0 each time after a diamond is made to bring it back into appropriate position.
			add x,14               ;adding x by 14 each time will move to the next diamond position.
			call gotoxy
			pop ecx
     loop myloop
	
	mov ecx,6
	mov y,14
    mov x,7
	   myloop2:
	        push ecx
	       	mov dl,x
            mov dh,y
            call gotoxy	 
            call triangle
            call upsideDownTriangle
			mov y,14
			add x,14
			call gotoxy
            pop ecx
	   loop myloop2
	   
	   
    mov ecx,6
	mov y,28
    mov x,7
	   myloop3:
	        push ecx
	       	mov dl,x
            mov dh,y
            call gotoxy	 
            call triangle
            call upsideDownTriangle
			mov y,28
			add x,14
			call gotoxy
            pop ecx
	   loop myloop3
	   
	   
    mov ecx,6
	mov y,42
    mov x,7
	   myloop4:
	        push ecx
	       	mov dl,x
            mov dh,y
            call gotoxy	 
            call triangle
            call upsideDownTriangle
			mov y,42
			add x,14
			call gotoxy
            pop ecx
	   loop myloop4	 
	

	   
  exit
main ENDP



Triangle PROC
       
   
    
   mov counter,0
   mov counter2,1
   mov ecx,7                   ;Number of rows for the triangle

 loopA:                                  
      mov counter,ecx
      mov ecx,counter2   
  
     loopB: 	 ;print x for each row
	 
	    mov eax,delta
		call randomRange  ;picks random number from 0-delta-1 into eax
		add eax,a
		call setTextColor
		mov eax,10
		call delay
        mov al,symbol
        call writeChar
     loop loopB
	 
        mov eax,counter2
        add eax,2
        mov counter2,eax  
        inc y
		dec x
        mov dh,y
        mov dl,x
        call gotoxy
     mov ecx,counter   
 loop loopA
                        
     inc x               ;Neded to make correct placement for the upsideDownTriangle PROC
     mov dl,x
     call gotoxy


ret
Triangle ENDP



upSidedownTriangle PROC

    mov counter3,13
    mov counter4,0	
    mov ecx,7                     ;;Number of rows for the triangle

     loopC:                       ;number of the rows of upSidedownTriangle
         mov counter4,ecx
         mov ecx,counter3
       loopS: 	   ;Prints out the x for the row
	      mov eax,delta
		  call randomRange            ;1 to delta-1 into eax
		  add eax,a
		  call setTextColor  
		  mov eax,10
		  call delay
          mov al,symbol
          call writeChar        
       loop LoopS
         mov eax,counter3 
		 sub eax,2
		 mov counter3,eax
         inc x 
         inc y
		 mov dl,x
         mov dh,y
         call gotoxy 
         mov ecx,counter4   
     loop loopC
	 
	 
           
ret


makeDelta PROC

   mov eax,b
   sub eax,a
   inc eax
   mov delta,eax

ret
makeDelta ENDP

upsidedownTriangle ENDP

END main