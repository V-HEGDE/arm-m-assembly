.section .vectors
vector_table:
    .word 0X20001000
    .word reset_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    mov r1, #0x7
    mov r2, #0x3
    add r3,r2,r1
    b lab2

lab1:
    mov r1, #5
    mov r2, #5
    b lab3

lab2:
    push {r1,r2}
    b lab1

lab3:
    pop {r2,r1}

    bl .