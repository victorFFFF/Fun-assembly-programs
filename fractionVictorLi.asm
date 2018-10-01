TITLE Program Template     (template.asm)

; Program Description:This program generate two random fraction and adds them.Then it finds the GCF of the sum with EUCLUD's algorithmn 
;                     and simplifies the sum.Finally,it writes the sum as a mix number IF and ONLY IF the sum's numerator > denominator.
; Author:Victor Li
; Date Created:12/10/2016
; Last Modification Date:12/11/2016

INCLUDE Irvine32.inc



.data

string1 byte ' <------This is a Mix Number, Professor.',0

NumeratorA byte ?
DenominatorB byte ?
NumeratorC byte ?
DenominatorD byte ?

denominator byte ?
numerator byte ?

simplifyNumerator word ?
simplifyDenominator word ?
sumDenominator word ?
sumNumerator word ?
newNumerator word ?
newDenominator word ?
GCF word ?
remainder word ?
WholeNumber word ?
mixNumerator word ?
mixDenominator word ?


range1 dword 1 
range2 dword 30    ;range for denominator

range3 dword 0     ;range for numerator
range4 dword 30

delta dword 0
delta2 dword 0

fractionBar byte '/',0 
plus byte ' + ',0
equal byte ' = ',0
space byte '   ',0
space2 byte ' ',0

.code
main PROC
call randomize
call makeDelta               ;makeDelta is the range for the denominator
call makeDelta2              ;makeDelta2 is the range of the numerator
call printResults
call findGCF
call simplifyFraction


mov ebx,0
mov bx,sumDenominator
    	
 .if(sumNumerator == 0 )
         mov edx,offset equal
         call writeString
         mov eax,0
         mov ax,wholeNumber
         call writeDec
    .elseif(sumNumerator == bx)
         mov edx,offset equal
         call writeString
         mov eax,0
         mov ax,wholeNumber
         call writeDec
     .elseif(sumNumerator > 0 )	 
	     mov edx,offset equal
		 call writeString
		 mov eax,0
		 mov ax,simplifyNumerator
		 call writeDec
		 mov edx,offset fractionBar
		 call writeString
		 mov eax,0
		 mov ax,simplifyDenominator
		 call writeDec
  .endIF

.if (sumNumerator > bx)		
   call mixNumber
   mov edx,offset equal
   call writeString
   mov eax,0
   mov ax,wholeNumber
   call writeDec
   mov edx,offset space2
   call writeString
   mov ax,mixNumerator
   call writeDec
   mov edx,offset fractionBar
   call writeString
   mov ax,mixDenominator
   call writeDec
   mov edx,offset string1
   call writeString
   

.endIF

	exit	
main ENDP

;===================================

makeDelta PROC

   mov eax,range2
   sub eax,range1
   inc eax
   mov delta,eax

ret
makeDelta ENDP

;=====================================

produceDenominator PROC

   mov eax,0
   mov eax,delta
   call randomRange
   add eax,range1
   mov denominator,al
   
ret
produceDenominator ENDP

;==========================================

produceNumerator PROC

 validate:
         mov eax,0
         mov eax,delta2
         call randomRange
	     add eax,range3
		 mov ebx,0
		 movzx ebx,denominator
      .if(eax < ebx)
         mov numerator,al
         jmp validateEND
       .endIF
	   jmp validate
    validateEND:
     
ret  
produceNumerator ENDP

;=================================================

createFraction1 PROC

    call produceDenominator 
	mov DenominatorB,al

    call produceNumerator
	mov NumeratorA,al

    mov eax,0
    mov al,numerator
    call writeDec

    mov edx,offset fractionBar
    call writeString


    mov eax,0 
    mov al,denominator
    call writeDec 

ret
createFraction1 ENDP

;====================================================

createFraction2 PROC

    call produceDenominator 
	mov DenominatorD,al

    call produceNumerator
	mov NumeratorC,al

    mov eax,0
    mov al,numerator
    call writeDec

    mov edx,offset fractionBar
    call writeString


    mov eax,0 
    mov al,denominator
    call writeDec 
 
  
ret
createFraction2 ENDP

;===================================================

addFraction PROC

  mov eax,0
  mov al,numeratorA
  mov ebx,0
  mov bl,denominatorD
  mul bl
  mov esi,0
  movzx esi,ax
  
  mov eax,0
  mov al,numeratorC
  mov ebx,0
  mov bl,denominatorB
  mul bl
  
  add eax,esi
  mov sumNumerator,ax
  
  
  mov eax,0
  mov al,denominatorB
  mov bl,denominatorD
  mul bl
  mov sumDenominator,ax
  
ret
addFraction ENDP

;=============================================================

makeDelta2 PROC

   mov eax,0
   mov eax,range4
   sub eax,range3
   inc eax
   mov delta2,eax

ret
makeDelta2 ENDP

;============================================================

printResults PROC
      call createFraction1
      mov edx,offset plus
      call writeString
      call createFraction2
      mov edx,offset equal
      call writeString
      call addFraction
      mov eax,0
      mov ax,sumNumerator
      call writeDec
      mov edx,offset fractionBar
      call writeString
      mov eax,0
      mov ax,sumDenominator
      call writeDec
ret
printResults ENDP

;=====================================================

findGCF PROC
  
   mov edx,0
   mov eax,0
   mov ax,SumNumerator
   mov ebx,0
   mov ecx,0
   mov bx,SumDenominator
   mov cx,SumDenominator
   mov newNumerator,cx
   div bx  
   
    findingGCF:
       .if(dx == 0)
	      jmp ENDfindingGCF
	   .endIF
	   mov remainder,dx
	   ;mov dx,remainder
	   mov gcf,dx
	   
	   
	     mov newNumerator,cx
	   mov ax,newNumerator
	   mov newDenominator,dx
	   mov bx,newDenominator
	   mov cx,newDenominator
	   
	   
	   mov edx,0
	   ;mov eax,0
	 
	   div bx
   
   
     jmp findingGCF
   ENDfindingGCF:
 
ret
findGCF ENDP

;===================================================

simplifyFraction PROC

mov ebx,0
mov bx,sumDenominator
.if(sumNumerator == bx)
      mov wholeNumber,1

.elseif( sumNumerator == 0 )
     mov wholeNumber,0
.elseif( sumNumerator > 0 )  
     mov edx,0
     mov eax,0
	 mov ax,sumNumerator
	 mov ebx,0
	 mov bx,gcf
	 div bx
	 mov simplifyNumerator,ax
	  
	 mov edx,0
	 mov eax,0
	 mov ax,sumDenominator
	 mov ebx,0
	 mov bx,gcf
	 div bx
	 mov simplifyDenominator,ax

.endIF
	 
ret
simplifyFraction ENDP

;=======================================================

MixNumber PROC

         mov edx,0
		 mov eax,0
		 mov ebx,0
		 mov ax,simplifyNumerator
		 mov bx,simplifyDenominator
		 div bx
		 
		 mov wholeNumber,ax
		 mov mixDenominator,bx
		 mov mixNumerator,dx
  
ret
MixNumber ENDP
END main