.global _start




_start:
    ldr x30, =stack_beginning
    mov sp, x30 
    bl start_interrupts
    bl kernel_entry
    b .