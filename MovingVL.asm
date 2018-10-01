TITLE multisegments     (mseg.asm)

Comment @
Author : Eran Barak
Creation Date : Apr 7, 2016
@ 
  

Include Irvine32.inc
 
.data			 
	
	;array for normal intials
    array1 byte 2,' ',1,'x' ,7,' ',1,'x',2,' ',1,'x',4,' '                
	array2 byte 3,' ',1,'x' ,5,' ',1,'x',3,' ',1,'x',4,' '    
	array3 byte 4,' ',1,'x' ,3,' ',1,'x',4,' ',1,'x',4,' '	
	array4 byte 5,' ',1,'x' ,1,' ',1,'x',5,' ',1,'x',4,' '    
	array5 byte 6,' ',1,'x' ,6,' ',5,'x',1,' '    
	
	L1 = lengthof array1/2    ;l1=4
	L2 = lengthof array2/2    ;l2=6
	L3 = lengthof array3/2    ;l3=4
	L4 = lengthof array4/2    ;l4=6
	L5 = lengthof array5/2    ;l5=6 
	
	
			
	;array for upsideDown initials
	array6 byte 5,' ',1,'x',8,' ',5,'x',5,' '
	array7 byte 4,' ',1,'x',1,' ',1,'x',7,' ',1,'x',5,' '
	array8 byte 3,' ',1,'x',3,' ',1,'x',6,' ',1,'x',5,' '
	array9 byte 2,' ',1,'x',5,' ',1,'x',5,' ',1,'x',5,' '
   array10 byte 1,' ',1,'x',7,' ',1,'x',4,' ',1,'x',5,' '
   
    ;ecx count for upsidedownInitals
   	L6 = lengthof array6/2
	L7 = lengthof array7/2
	L8 = lengthof array8/2
	L9 = lengthof array9/2
   L10 = lengthof array10/2
   
     
   ;array for backwords initails
   array11 byte 1,' ',1,'x',4,' ',1,'x',8,' ',1,'x',5,' '
   array12 byte 1,' ',1,'x',5,' ',1,'x',6,' ',1,'x',5,' '
   array13 byte 1,' ',1,'x',6,' ',1,'x',4,' ',1,'x',5,' '
   array14 byte 1,' ',1,'x',7,' ',1,'x',2,' ',1,'x',5,' '
   array15 byte 1,' ',5,'x',4,' ',1,'x',5,' '
   ;ecx count for backword initails
   L11 = lengthof array11/2
   L12 = lengthof array12/2
   L13 = lengthof array13/2
   L14 = lengthof array14/2
   L15 = lengthof array15/2
	
	
		
    xstart byte 3           ;3
    ystart byte 12           ;12	
    grandarray dword 10 dup(?)
    symbol byte ? 
	delta dword ?
	a dword 1
	b dword 14

		

.code
;=============================================================================
main PROC
	
	  
         call clrscr
		 call makeDelta
	     call randomize
		 
		 mov ecx,5	 
		 loop1:
		     call createGrand
		     push ecx
		     call moveRight
		     pop ecx
		 loop loop1
		 
		 mov ecx,1
		 loop3:
		     call createGrand3
		     push ecx
		     call movedown
		     pop ecx
		 loop loop3
		 
		 
		 mov ecx,4 
		 loop2:	 
		    call createGrand2
		    push ecx
		    call moveLeft
		    pop ecx
		 loop loop2
		 
	
		 mov ecx,3
		 loop4:
		     call createGrand
		     push ecx
		     call moveup
		     pop ecx
		 loop loop4
   
         mov ecx,3
		 loop5:
		     call createGrand3
		     push ecx
		     call movedown
		     pop ecx
		 loop loop5
		 
		  mov ecx,3
		 loop6:
		     call createGrand2
		     push ecx
		     call moveright
		     pop ecx
		 loop loop6
		 
		  mov ecx,3
		 loop7:
		     call createGrand
		     push ecx
		     call moveup
		     pop ecx
		 loop loop7
		 
		  mov ecx,3
		 loop8:
		     call createGrand3
		     push ecx
		     call movedown
		     pop ecx
		 loop loop8
		 
		  mov ecx,3
		 loop9:
		     call createGrand2
		     push ecx
		     call moveleft
		     pop ecx
		 loop loop9
		 
		  mov ecx,3
		 loop10:
		     call createGrand3
		     push ecx
		     call moveright
		     pop ecx
		 loop loop10
		 
		  mov ecx,3
		 loop11:
		     call createGrand2
		     push ecx
		     call moveright
		     pop ecx
		 loop loop11
		 
		  mov ecx,3
		 loop12:
		     call createGrand3
		     push ecx
		     call moveup
		     pop ecx
		 loop loop12
		 
		  mov ecx,3
		 loop13:
		     call createGrand2
		     push ecx
		     call moveleft
		     pop ecx
		 loop loop13
		 
		  mov ecx,3
		 loop14:
		     call createGrand
		     push ecx
		     call moveleft
		     pop ecx
		 loop loop14
   
	  	   
 
	 exit

main ENDP


;====================================================================================

makeDelta PROC
        mov eax,b
		sub eax,a
		inc eax
		mov delta,eax


ret
MakeDelta ENDP
;===========================================================================
moveRight PROC

		 mov ecx,20
       right:                              ;This loop makes the initials move horizontally.  
                 push ecx
                 call createpicture
                 mov eax,50
                 call delay
                 inc xstart             ;Increasing the xStart value will move the initials left to right.
                 pop ecx
       loop right	    
ret
moveRight ENDP

;============================================================================================================
moveLeft PROC

       mov ecx,20
       right:                   
                 push ecx
                 call createpicture
                 mov eax,50
                 call delay
                 dec xstart             
                  pop ecx
        loop right
		
ret
moveLeft ENDP


;==============================================================================================================
moveDown PROC
    		
		  mov ecx,20
          down:	   
               push ecx
               call createpicture
		       mov ecx,20
		       mov dl,xstart
			   mov dh,ystart
			   call gotoxy
			   
		          spaceLoop:
		                 mov al," "
					    call writechar
		          loop spaceLoop
				  
              mov eax,50
              call delay
              inc ystart             
              pop ecx
       loop down
	   


ret
moveDown ENDP

;===========================================================================================
moveUP PROC

      mov ecx,20
	      up:	   
             push ecx
             call createpicture
		     mov ecx,30
		     mov dl,xstart
			 call gotoxy
			 
		       spaceLoop2:
		               mov al,' '
					   call writechar
		        loop spaceLoop2
				
           mov eax,50
           call delay
           dec ystart             
           pop ecx
       loop up


ret
moveUP ENDP


;=================================================================================================    
drawline proc
              
              lineloop:
			         mov eax,delta
				     call randomRange
				     inc eax
				     call setTextCOlor
		             mov al,symbol
		             call writechar
	          loop lineloop  
                  ret
drawline endp


;=====================================================================================================

                            
							;set values into grandArray from all 5 arrays and L1-L5.
creategrand proc                                         
         mov esi, offset grandarray

         mov [esi], offset array1
         add esi,4                            
         mov eax,L1
         mov [esi], eax
         add esi,4
     
         mov [esi], offset array2
         add esi,4
         mov eax,L2
         mov [esi], eax
         add esi,4

         mov [esi], offset array3
         add esi,4
         mov eax,L3
         mov [esi], eax
         add esi,4

         mov [esi], offset array4
         add esi,4
         mov eax,L4
         mov [esi], eax
         add esi,4

         mov [esi], offset array5
         add esi,4
         mov eax,L5
         mov [esi], eax
         add esi,4
		 
		 
       ret
creategrand endp
;==========================================================================


createGrand2 PROC
 
   mov esi,offset grandArray
   
   
   mov [esi],offset array6
   add esi,4
   mov eax,L6
   mov [esi],eax
   add esi,4
   
   mov [esi],offset array7
   add esi,4
   mov eax,L7
   mov [esi],eax
   add esi,4
   
   mov [esi],offset array8
   add esi,4
   mov eax,L8
   mov [esi],eax
   add esi,4
   
   mov [esi],offset array9
   add esi,4
   mov eax,L9
   mov [esi],eax
   add esi,4
   
   mov [esi],offset array10
   add esi,4
   mov eax,L10
   mov [esi],eax
   add esi,4
   
   
  

ret
createGrand2 ENDP

;=========================================================================================

createGrand3 PROC
   mov esi,offset grandArray
   
   mov [esi],offset array11
   add esi,4
   mov eax,L11
   mov [esi],eax
   add esi,4
   
   mov [esi],offset array12
   add esi,4
   mov eax,L12
   mov [esi],eax
   add esi,4
   
   mov [esi],offset array13
   add esi,4
   mov eax,L13
   mov [esi],eax
   add esi,4
   
   mov [esi],offset array14
   add esi,4
   mov eax,L14
   mov [esi],eax
   add esi,4
   
   mov [esi],offset array15
   add esi,4
   mov eax,L15
   mov [esi],eax
   add esi,4

ret
createGrand3 ENDP

;===========================================================================================s
    
printInit proc 

          mov eax,0
                
          ;call gotoxy  
           mov esi,grandarray[edi]       ;Esi has the offset of all 5 arrays
           mov ecx,grandarray[edi+4]     ;Ecx will be equal to L1,L2,L3,L4,or L5
    
           reada1:
              push ecx
              mov al,[esi]       ;for the loop of drawline. ;Number
              mov ecx,eax
              inc esi            ;Increase esi by 1 because array1,array2,array3... are byte type.
              mov al,[esi]       ;symbol
              mov symbol,al
              inc esi
              call drawline
              pop ecx
           loop reada1
           
          add edi,8            ;To move to the third element of grandarray
          ret
printinit endp
;=============================================================================

createpicture proc
      
       mov ecx,5              ;loop 5 times because of 5 arrays
       mov edi,0
       mov dl,xstart         ;dl and dh are 8 bits of EDX
       mov dh,ystart
       
           myint:  
              call gotoxy
              push ecx
              call printinit
              pop ecx
              mov dl,xstart
              inc dh         
          loop myint
      ret
createpicture endp

;=======================================================================
END main



 