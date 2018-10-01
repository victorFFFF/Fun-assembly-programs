TITLE Program Template     (template.asm)

; Program Description:This program plays 100 games of solitaire and then display the # of loses out of 100 wins.
;                     Duplicates are not allowed.For example Hearts of 3 and hearts of 3 in one game.
;                     Loses if pairs.Example: spade 5 and heart 5 equals a lost.
; Author:Victor Li
; Date Created:12/9/2016
; Last Modification Date:12/11/2016

INCLUDE Irvine32.inc


.data

delta dword 0
a dword 0
b dword 51
                                           
divisor byte 13
youLose byte 'You Lose!',0
Result1 byte 'You have lost ',0
LoseCount dword 0
result2 byte ' times out of 100 games.',0

randomNumber byte ?
remainder1 byte ?
remainder2 byte ?

bar byte '====================================',0

color dword ?
redd dword 4
space byte ' ',0

counter byte 0
counter2 dword 1
element dword 0
loopCount dword 0

storage dword 0

clubs byte 'Clubs',0
border byte '|',0
diamond byte 'Diamond',0
heart byte 'Heart',0
spade byte 'Spade',0

CardList byte                 '2','3','4','5','6','7','8','9','T','J','Q','K','A'
row0Clubs byte                 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10, 11, 12
row1Diamond byte              13 ,14 ,15 ,16 ,17 ,18 ,19 ,20 ,21 ,22 ,23 , 24, 25
row2Heart byte                26 ,27 ,28 ,29 ,30 ,31 ,32 ,33 ,34 ,35 ,36 , 37, 38
row3Spade byte                39 ,40 ,41 ,42 ,43 ,44 ,45 ,46 ,47 ,48 ,49 , 50, 51
picked byte 100 dup(52)        ;dup(52) because we i cannot put #0-51
string1 byte 'Game#',0

.code
main PROC

  
  call randomize
  call makeDelta
  
  mov ecx,100
  
  play100Times:                           ;Play 100 games of solitaire
      push ecx  
	     mov edx,offset string1
		 call writeString
		 mov eax,counter2
		 call writeDec
		 inc counter2	 
         call playGame
		 
		 mov loopCount,0             ;reseting counters and remainders
		 mov counter,0
		 mov remainder1,0
		 mov remainder2,0
		    mov ecx,52   ;52
			mov ebx,0
		    resetArray:                 ;resets all the 52 elements of picked[]array.So  it will NOT be equal to #0-51.
		         mov picked[ebx],100 
				 inc ebx
		    loop resetArray
	  pop ecx
  loop play100Times
  
  call printResults



	exit	
main ENDP

;=======================================

makeDelta PROC

    mov eax,b
	sub eax,a
	inc eax
	mov delta,eax
	
ret
makeDelta ENDP

;=====================================

playGame PROC

  mov ecx,51                          ;ECX=51 when we have 52 cards because first iteration on loop display 2 cards
  ;call crlf                          ;then second iteration it only displays one card.So first loop 2 cards then the rest of the 50
                                      ;loops will be only 1 card

   play51:
     mov storage,ecx
   
       .if(counter<=0)
            call firstCard
        .endIf	
	
	       call SecondCard
	
	       mov ebx,0
	       mov eax,0
	       mov bl,remainder1
	       mov al,remainder2
		   
		   
		   .if(al == bl)
	        mov eax,15
		    call setTextColor
	        mov edx,offset youLose
		    call writeString
	     	inc loseCount
	        jmp nextGame
     	.endIF		
	    

	  mov remainder1,al
	  inc counter
	  mov ecx,storage
   loop play51
   
  nextGame:
  call crlf
  mov eax,15
  call setTextColor
  mov edx,offset bar
  call writeString
  call crlf
     ;mov ecx,0
ret
playGame ENDP

;============================================

gettingCards0 PROC                       ;getting cards from row0
          
		  call crlf
		  mov eax,black+16*white
		  call setTextColor
		  mov edx,offset border
		  call writeString
		  mov edx,offset clubs
		  call writeString
          mov ebx,0
	      mov ebx,esi
	      sub ebx,13              ;subtracting [13(lineNumber+1)] elements will get the element right above it.
		  mov edx,offset space
		  call writeString
	      mov eax,0
	      mov al,row0Clubs[ebx]
	      call writeChar
		  mov edx,offset border
		  call writeString


ret
gettingCards0 ENDP

;============================================
gettingCards1 PROC                   ;getting cards from row1


           call crlf
           mov eax,redd
		   call setTextColor           
		   mov edx,offset border
		   call writeString
           mov edx,offset diamond
		   call writeString
           mov ebx,0
	       mov ebx,esi
	       sub ebx,26
	       mov eax,0
		   mov edx,offset space
		   call writeString
	       mov al,row1Diamond[ebx]
	       call writeChar
		   mov edx,offset border
		   call writeString

		  ret
gettingCards1 ENDP

;=====================================================

gettingCards2 PROC                   ;getting cards from row2
                 
		  call crlf
		  mov eax,redd
		  call setTextColor
		  mov edx,offset border
		  call writeString	
          mov edx,offset heart
		  call writeString
          mov ebx,0
	      mov ebx,esi
	      sub ebx,39
		  mov edx,offset space
		  call writeString
	      mov eax,0
	      mov al,row2Heart[ebx]
	      call writeChar
		  mov edx,offset border
		  call writeString


ret
gettingCards2 ENDP		  

;======================================================

gettingCards3 PROC                       ;getting cards from row3

          call crlf
          mov eax,black+16*white
		  call setTextColor
          mov edx,offset border
		  call writeString
          mov edx,offset spade
		  call writeString
          mov ebx,0
		  mov ebx,esi
		  sub ebx,52
		  mov edx,offset space
		  call writeString
		  mov eax,0
		  mov al,row3Spade[ebx]
		  call writeChar
		  mov edx,offset border
		  call writeString

ret
gettingCards3 ENDP

;=============================================================
FirstCard PROC
     
   mov edi,0
   mov eax,0
   mov eax,delta
   call randomRange
   add eax,a    ;eax = 0-51
   mov randomNumber,al 
   mov picked[edi],al
   ;inc counter2
   inc edi
   mov element,edi

   inc loopCount                ;loopCount is to keep count of the # of elements I need to compare with.
   mov ebx,0
   mov bl,divisor
   div bl                      ;Diving by 8bit value stores quotient in al, and the remainder in ah.
   mov remainder1,ah
   mov esi,0
   movzx esi,ah
     
   
   .if(al==0)                  ;if al=0 that means n/13 is a quotient of zero.  
		  call gettingCards0
	      	   
	 .elseIF(al==1) 
          call gettingCards1
		  
	 .elseIF(al==2) 
          call gettingCards2
     .elseIF(al==3)
	      call gettingCards3
		       	 
   .endIF    
ret
FirstCard ENDP

;============================================

SecondCard PROC

   noDuplicate:                       ;Validating the cards so each game will not have duplicates.
           mov eax,0
           mov eax,delta
           call randomRange
           add eax,a    ;eax = 0-51
           mov randomNumber,al
   
   
              mov ecx,loopCount
	          mov edi,0
           validate1: 
			      mov ebx,0
	              mov bl,picked[edi]
	          .if(randomNumber == bl)   
		          jmp noDuplicate
		     .endIf
		         inc edi
	       loop validate1
	   
  
          mov edi,element
          mov picked[edi],al
		  inc edi
		  mov element,edi
	      jmp endnoDuplicates
  endnoDuplicates:
   
  
       inc loopCount                  
   
       mov ebx,0
       mov bl,divisor
       div bl                      ;Diving by 8bit value stores quotient in al, and the remainder in ah.
       mov remainder2,ah
       mov esi,0
       movzx esi,ah
       
   inc loopCount
   .if(al==0)                  ;if al=0 that means n/13 is a quotient of zero.  
		  call gettingCards0
	      	   
	 .elseIF(al==1) 
          call gettingCards1
		  
	 .elseIF(al==2) 
          call gettingCards2
     .elseIF(al==3)
	      call gettingCards3
		       	 
   .endIF    
ret
SecondCard ENDP

;=========================================================

printResults PROC
    
	 call crlf
	 mov eax,15
     call setTextColor
	 call crlf
	 mov edx,offset result1
	 call writeString
	 mov eax,0
	 mov eax,loseCount
	 call writeDec
	 mov edx,offset result2
	 call writeString
	 
ret
printResults ENDP

;====================================================================

END main