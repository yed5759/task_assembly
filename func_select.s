.extern pstring
.extern printf
.extern scanf

.section .rodata
wrong:
    .string "invalid option!\n"
pstrlen_p:
    .string "first pstring length: %d, second pstring length: %d\n"
print_fmt:
    .string "length: %d, string: %s\n"
scanf_fmt:
    .string "%c %c"

.section    .text
.globl  run_func
.type   run_func, @function
run_func:
    pushq   %rbp
    movq    %rsp, %rbp

    cmpq    $31, %rdi
    je  .option31

    cmpq    $33, %rdi
    je  .option33

    cmpq    $34, %rdi
    je  .option34

    jmp .invalid
.option31:
    movq    %rsi, %rdi
    call    pstrlen

    movq    %rax, %rsi
    movq    %rdx, %rdi
    call    pstrlen

    movq    %rax, %rdx
    movq    $pstrlen_p, %rdi
    call    printf

    jmp     .end
.option33:
    movq    %rsi , %rdi
    call    swapCase

    movq    %rax, %r13
    call    pstrlen

    xorq    %rsi, %rsi
    movb    %al, %sil
    movq    $print_fmt, %rdi
    leaq    1(%r13), %rdx

    call    printf
    jmp     .end
.option34:

    movq    %rdx, %rcx
    movq    %rsi, %rdx
    movq    %r12, %rdi
    movq    %r13, %rsi

    call    pstrijcpy

    leaq    1(%rax), %r12
    leaq    1(%rsi), %r13

    xorq    %rsi, %rsi
    movb    -1(%r12), %sil
    movq    $print_fmt, %rdi
    movq    (%r12), %rdx
    call    printf
    jmp     .end
.invalid:
    movq    $wrong, %rdi
    call    printf
.end:
    xorq    %rax, %rax
    movq    %rbp, %rsp
    popq    %rbp
    ret