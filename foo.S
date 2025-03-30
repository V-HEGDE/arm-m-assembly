#systick config
.equ SYST_CSR, 0xE000E010
.equ SYST_RVR, 0xE000E014
.equ SYST_CVR, 0xE000E018
.equ Tim     , 0x00FFFFFF


.section .vectors
vector_table:
    .word 0X20001000
    .word reset_handler

    .org 0x3C
    .word systick_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    ldr r0, =SYST_CSR
    ldr r1, =SYST_RVR
    ldr r2, =SYST_CVR

    ldr r5, =Tim
    STR	r5, [r1]
    mov r5, #0x00
    STR r5, [r2]
    mov r5, #0x07
    STR	r5, [r0]

    mov r5, #0x0
    bl .

    .type systick_handler, %function
systick_handler:
    add r5,r5,#1
Brake:
    bx lr

