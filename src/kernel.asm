; kernel.asm

[bits 16]
[org 0x1000]			; memory where kernel is loaded into RAM

%define ENDL 0x0D, 0x0A

main:
	mov si, welcome_message
	call prints

	jmp done

prints:
	lodsb
	cmp al, 0
	je return
	mov ah, 0x0E
	int 0x10
	jmp prints

return:
	ret

done:
	hlt
	jmp $			; in case htl does not work

welcome_message db "Hello from Kernel!", ENDL, 0

