; boot.asm
;
; bootloader which loads a kernel from
; the 2nd sector of a floppy into RAM
; (bootloader is in 1st sector) and
; jumps to the address where the kernel
; was loaded into RAM.
;
; first working bootloader that
; correctly reads the kernel and loads
; it into RAM :)
;
; 18.09.2024 eu
; by hoetzenofer
; -------------------------------------

[bits 16]
[org 0x7C00]

%define ENDL 0x0D, 0x0A

entry:
	jmp main

main:
	mov si, msg_boot
	call prints

	jmp load_kernel

prints:
    lodsb
    cmp al, 0
    je return
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp prints

load_kernel:
	mov si, dbug_load_kernel
	call prints

	cli                     ; deactivate interrupts

	xor ax, ax		        ; set ax to 0
	mov ds, ax		        ; set data segment to 0 (required for int 0x13)
	mov es, ax		        ; set extra segment to 0 (required to load into RAM)

	mov ah, 0x02		    ; set ah to 2 for reading sectors from floppy
	mov al, 0x01		    ; set al to 1 to read 1 sector
	mov ch, 0x00		    ; cylinder 0
	mov cl, 0x02		    ; sector 2
	mov dh, 0x00		    ; head 0
	mov dl, 0x00		    ; disk 0 (floppy)
	mov bx, 0x1000		    ; load sector(s) to 0x1000 (es:bx)

	int 0x13		        ; BIOS interrupt (0x13 for read from disk and load into RAM)
	jc disk_error		    ; jump to disk_error if int 0x13 set carry flag (=error)

	mov si, dbug_jmp_kernel
	call prints
	jmp 0x1000		        ; jump to RAM address where kernel was loaded

disk_error:
	mov si, dbug_disk_error
	call prints

	jmp done

return:
	ret

done:
	mov si, dbug_halt
	call prints

	hlt			        ; halting CPU
	jmp $			    ; jumping to current address in case hlt does not work

msg_boot db ENDL, ENDL, "Booting...", ENDL, 0
dbug_disk_error db "BIOS Interrupt 0x13 (read Sectors and load to RAM) returned int 1", ENDL, 0
dbug_halt db "Halting CPU", ENDL, 0
dbug_load_kernel db "Loading Kernel from Disk into RAM", ENDL, 0
dbug_jmp_kernel db "Jumping to Kernel (0x1000) now...", ENDL, ENDL, 0

times 510-($-$$) db 0
dw 0xAA55

