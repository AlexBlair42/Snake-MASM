TITLE MASM Template						(main.asm)
INCLUDE Irvine32.inc
.data
msg BYTE "Hello there CS278", 0
.code
CopyString PROC pArray:PTR BYTE, count:DWORD
	LOCAL var1:WORD, var2:DWORD, temp[20]:BYTE
	lea edi, temp
	mov ecx, count
	mov esi, pArray
L1:
	mov al, BYTE PTR [esi]
	mov BYTE PTR [edi], al
	inc edi
	inc esi
	loop L1
	lea edx, temp
	call WriteString
	call Crlf
	ret
CopyString ENDP
main PROC
	;push LENGTHOF msg
	INVOKE CopyString, ADDR msg, LENGHTOF msg
	;push OFFSET msg
	;call CopyString
	exit
main ENDP
END main
