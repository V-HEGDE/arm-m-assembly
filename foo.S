#systick config
.equ SYST_CSR, 0xE000E010
.equ SYST_RVR, 0xE000E014
.equ SYST_CVR, 0xE000E018
.equ Tim     , 0x00FFFFFF


.section .vectors
vector_table:
    .word 0x20001000
    .word reset_handler


#.org will jump to location 3C and start writing there
    .org 0x3C
    .word systick_handler
    .zero 400
st1:  .word 0x20000000
st2:  .word 0x200000b0
st3:  .word 0x20000160


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

    .section .text
    .align 1
    .type systick_handler, %function
systick_handler:

#Push resisters that are not automatically pushed
    push {r4-r7}

#load r8-r11 to r4-r7 as r0-r7 registers only could be pushed to stack
    mov r0,r8
    mov r1,r9
    mov r2,r10
    mov r3,r11
    push {r0-r3}

#implement write stack pointer
    ldr r0, = st1
    ldr r1,[r0]
    ldr r2,[r0,#4]
    ldr r3,[r0,#8]
    ldr r5,[r0,r4]
    mov sp,r5

Brake:

    pop {r4-r7}
    mov r8,r4
    mov r9,r5
    mov r10,r6
    mov r11,r7

    pop {r4-r7}

    bx lr

#Tasks
.section .text
    .p2align    4
    .globl main1
    .type main1, %function
main1:
    add r1,r1,#1
    b main1

.section .text
    .p2align    4
    .globl main2
    .type main2, %function
main2:
    add r2,r2,#2
    b main2

.section .text
    .p2align    4
    .globl main3
    .type main3, %function
main3:
    add r3,r3,#3
    push {r0}
    mov r0,#0xff
    cmp r0,r3
    beq stand
    pop {r0}
    b skip
stand : bl .
skip:    b main3



    .data
    .align 4
#Stacks
Stack1:
    .word 0x18
    .word 0x19
    .word 0x1a
    .word 0x1b
    .word 0x04
    .word 0x15
    .word 0x16
    .word 0x17
    .word 0x10
    .word 0x11
    .word 0x12
    .word 0x13
    .word 0x1c
    .word 0x309
    .word main1
    .word 0x01000000
    .zero 100
    .align 4

Stack2:
    .word 0x28
    .word 0x29
    .word 0x2a
    .word 0x2b
    .word 0x08
    .word 0x25
    .word 0x26
    .word 0x27
    .word 0x20
    .word 0x21
    .word 0x22
    .word 0x23
    .word 0x2c
    .word 0x309
    .word main2
    .word 0x01000000
    .zero 100
    .align 4

Stack3:
    .word 0x38
    .word 0x39
    .word 0x3a
    .word 0x3b
    .word 0x00
    .word 0x35
    .word 0x36
    .word 0x37
    .word 0x30
    .word 0x31
    .word 0x32
    .word 0x33
    .word 0x3c
    .word 0x309
    .word main3
    .word 0x01000000

