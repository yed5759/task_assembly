.extern printf

.section .rodata
pstrijcpy_p:
    .string "pstrijcpy\n"
swapCase_p:
    .string "swapCasw\n"

.section .text
.globl  pstrlen
.type   pstrlen, @function
pstrlen:
    pushq   %rbp
    movq    %rsp, %rbp

    xorq    %rax, %rax
    movq    (%rdi), %rcx
    movb    %cl, %al

    movq    %rbp, %rsp
    popq    %rbp
    ret

.globl  pstrijcpy
.type   pstrijcpy, @function
pstrijcpy:
    pushq   %rbp
    movq    %rsp, %rbp
    xorq    %rax, %rax

    leaq    1(%rdi), %r8
    leaq    1(%rsi), %r9
    leaq    (%r8, %rdx), %r10
    leaq    (%r8, %rdx), %r11

.cLoop:
    cmpq    %rdx, %rcx
    je      .cEnd_loop

    movb    (%r11), %al
    movb    %al, (%r10)

    incq    %r10
    incq    %r11
    incq    %rdx
    jmp     .cLoop
.cEnd_loop:
    movq    %rdi, %rax
    movq    %rbp, %rsp
    popq    %rbp
    ret

.globl  swapCase
.type   swapCase, @function
swapCase:
    pushq   %rbp
    movq    %rsp, %rbp

    xorq    %rax, %rax
    call    pstrlen
    leaq    1(%rdi), %r12
.sLoop:
    cmpb    $0, %al
    je      .sEnd_loop
    movb    (%r12), %cl

    cmpb    $0x41, %cl
    jl      .go_back

    cmpb    $0x5A, %cl
    jle     .capital

    cmpb    $0x61, %cl
    jl      .go_back

    cmpb    $0x7A, %cl
    jle     .small
    jmp     .go_back

.capital:
    addb    $0x20, %cl
    movb    %cl, (%r12)
    jmp     .go_back

.small:
    subb    $0x20, %cl
    movb    %cl, (%r12)

.go_back:
    incq    %r12
    decb    %al
    jmp     .sLoop

.sEnd_loop:
    movq    %rdi, %rax
    movq    %rbp, %rsp
    popq    %rbp
    ret