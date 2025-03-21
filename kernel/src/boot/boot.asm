.global _start




_start:
    ldr x30, =stack_beginning
    mov sp, x30 
    bl kernel_entry
    b .