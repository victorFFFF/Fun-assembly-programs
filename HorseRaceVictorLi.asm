TITLE Program HorseRaceVictorLi   (HorseRaceVictorLi.asm)

; Program Description:This program plays a horse race with 4 horses on a 12 unit long track.It then display the first horse to win of the race.
; Author:Victor Li
; Date Created:12/9/2016
; Last Modification Date:12/9/2016

INCLUDE Irvine32.inc



.data

 delta dword 0
 a dword 1
 b dword 4
 string1 byte 'You have picked horse #',0
 MoePath byte   '1)Moe   [-----------G------]',0
 LarryPath byte '2)Larry [-----------O------]',0
 CurlyPath byte '3)Curly [-----------A------]',0
 ShempPath byte '4)Shemp [-----------L------]',0
 question byte 'The following are the avaible horses to choose from.',0
 question2 byte 'Please enter the appropriate number for your choice of horse.',0
 menuList byte '1.Moe       2.Larry       3.Curly       4.Shemp',0
 invalidInput byte 'You have picked an invalid number for your horse.Please reenter your number.(Number must be 1-4 to be valid).',0
 dash byte '>',0
 
 MoeName byte 'Moe',0
 LarryName byte 'Larry',0
 CurlyName byte 'Curly',0
 ShempName byte 'Shemp',0

 MoeYstart byte  10
 MoeXstart byte 19
 LarryYstart byte 11
 LarryXstart byte 19
 CurlyYstart byte 12
 CurlyXstart byte 19
 ShempYstart byte 13
 ShempXStart byte 19
 
 finishLine byte 12
 moeScore byte 0
 larryScore byte 0
 curlyScore byte 0
 shempScore byte 0
 
 
moeWins byte 'Moe is the winner of the race.',0
larryWins byte 'Larry is the winner of the race.',0
curlyWins byte 'Curly is the winner of the race.',0
ShempWins byte 'Shemp is the winner of the race.',0

youWin byte 'Congratulation, you have won the game!!!!!!!!!',0
youLose byte 'Sorry but you have lost the game.',0

Winner byte ?
chosenHorse byte ?
 
 
 


.code
main PROC

call makeDelta
call randomize
call promptUser
call printLayout
call startRace
call printResults

	exit	
main ENDP

;========================================================

makeDelta PROC

    mov eax,b
	sub eax,a
	inc eax
	mov delta,eax


ret
makedelta ENDP

;=======================================================

promptUser PROC

   
    mov eax,0
    mov edx,offset question
    call writeString
    call crlf
	mov edx,offset question2
	call writeString
	call crlf
    mov edx,offset menuList
    call writeString
	call crlf
	mov edx,offset string1
	call writeString
    call readInt
	mov chosenHorse,al
	
	beginWhile1:                ;Valdating the input with while loop.
	    cmp eax,1
		je endWhile1
        cmp eax,2
		je endWhile1
        cmp eax,3
		je endWhile1
        cmp eax,4	
        je endWhile1		
		mov edx,offset invalidInput
		call writeString
		call readInt
	    jmp beginWhile1
	endWhile1:
	mov chosenHorse,al
	
	
ret
promptUser ENDP

;====================================================

printLayout PROC

    mov eax,15
	call setTextColor

    mov dh,10
	mov dl,10
	call gotoxy
	
    mov edx,offset moePath
	call writeString
	
	mov dh,11
	mov dl,10
	call gotoxy
	mov edx,offset LarryPath
	call writeString
	
	
	mov dh,12
	mov dl,10
	call gotoxy
	mov edx,offset CurlyPath
	call writeString
	
	mov dh,13
	mov dl,10
	call gotoxy
	mov edx,offset ShempPath
	call writeString

	
ret
printLayout ENDP

;=======================================================

startRace PROC

     beginWhile2:
	 
		 mov ebx,0
		 call MoeTrack
	.if(moeScore>=12)
	    mov edx,offset Moewins
		mov winner,1
	    jmp endWhile2
			  
    .endif			 

       	 call larryTrack
		 .if(larryScore>=12)
		   mov edx,offset larryWins
		   mov winner,2
		   jmp endWhile2

      .endif
		 
		 
		 call curlyTrack
		 .if(curlyScore>=12)
		    mov edx,offset curlyWins
			mov winner,3
			jmp endWhile2

         .endif
		 
		 
		 call ShempTrack
		 .if(ShempScore>=12)
		   mov edx,offset ShempWins
		   mov winner,4
		   jmp endWhile2
	
	    .endif
		
				  
	
	 	 
	 jmp beginWhile2
	 endWhile2:
   
 
ret
startRace ENDP

;======================================================

MoeTrack PROC

    mov eax,0
    mov eax,delta
	call randomRange
	add eax,a
	
	mov ecx,eax
	add moeScore,al
	mov dl,moeXstart
	mov dh,moeYstart
	call gotoxy
	
	LoopMoe:
	     mov eax,14
		 call setTextColor
	     mov eax,250
		 call delay
	     mov edx,offset dash
		 call writeString
		 inc moeXstart
		 mov dl,moeXstart
		 mov dh,moeYstart
		 call gotoxy
    Loop LoopMoe
		 
	

ret
MoeTrack ENDP

;=========================================

larryTrack PROC

    mov eax,0
    mov eax,delta
	call randomRange
	add eax,a
	
	mov ecx,eax
	add larryScore,al
	mov dl,larryXstart
	mov dh,larryYstart
	call gotoxy
	
	LoopLarry:
	     
		 mov eax,14
		 call setTextColor
	     mov eax,250
		 call delay
	     mov edx,offset dash
		 call writeString
		 inc larryXstart
		 mov dl,larryXstart
		 mov dh,larryYstart
		 call gotoxy
    Loop LoopLarry
  
ret
larryTrack ENDP

;===================================================

curlyTrack PROC

    mov eax,0
    mov eax,delta
	call randomRange
	add eax,a
	
	mov ecx,eax
	add curlyScore,al
	mov dl,curlyXstart
	mov dh,curlyYstart
	call gotoxy
	
	LoopCurly:
	     
		 mov eax,14
		 call setTextColor
	     mov eax,250
		 call delay
	     mov edx,offset dash
		 call writeString
		 inc curlyXstart
		 mov dl,curlyXstart
		 mov dh,curlyYstart
		 call gotoxy
    Loop LoopCurly

ret
curlyTrack ENDP

;=============================================================

ShempTrack PROC

    mov eax,0
    mov eax,delta
	call randomRange
	add eax,a
	
	mov ecx,eax
	add ShempScore,al
	mov dl,ShempXstart
	mov dh,ShempYstart
	call gotoxy
	
	LoopShemp:
	     
		 mov eax,14
		 call setTextColor
	     mov eax,250
		 call delay
	     mov edx,offset dash
		 call writeString
		 inc ShempXstart
		 mov dl,ShempXstart
		 mov dh,ShempYstart
		 call gotoxy
    Loop LoopShemp

ret
shempTrack ENDP

;======================================================

printResults PROC

    mov eax,15
	call setTextColor
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
    call writeString
	call crlf
	
	mov eax,0
	mov ebx,0
	mov al,winner
	mov bl,chosenHorse
	.if(al == bl)
	   mov edx,offset youWin
	   call writeString
	.else 
	    mov edx,offset youLose
		call writeString
   .endIF
	   
		
      

ret
printResults ENDP

END main
