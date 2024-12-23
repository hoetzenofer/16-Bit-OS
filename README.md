# 16 Bit OS

---

## About this Project

Tiny operating system, in fact so tiny you can't even call it a real operating system. It first displays a few debug messages, then loads a kernel into RAM and jumps to the kernel address to execute it. The kernel, just like the bootloader, does absolutely nothing besides saying hello.

---

## Dependencies

- Linux (commands below won't work on Windows)

- QEMU (as a VM)

- NASM (for compiling assembly code)

- GNU Make (for easier building)

---

## Run the Code

| Make command | What happens                                                     |
| ------------ | ---------------------------------------------------------------- |
| make         | Bootloader and kernel are compiled and put onto a virtual floppy |
| make run     | QEMU starts executing the code inside the virtual floppy         |
| make clean   | Binary files and the virtual floppy are removed                  |
