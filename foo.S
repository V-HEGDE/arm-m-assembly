.section .vectors
vector_table:
    .word 0XABC0
    .word reset_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    mov r1, #0x7
    mov r2, #0x3
    add r3,r2,r1
    bl .