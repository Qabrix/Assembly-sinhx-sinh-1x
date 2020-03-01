global main
extern printf, scanf

section .data
    scan_format: db "%f",0
    print_format1: db "sinhx: %f",0xA,0
    print_format2: db "sinh-1x: %f",0xA,0
    ; maxn: dd 100
    ; n: dd 2.0
    ; switch: dd 1

section .bss
    x: resb 8

section .text
main:
    finit
    call calc1st
    call calc2nd
    jmp exit

calc1st:
    push x
    push scan_format
    call scanf
    add esp, 8

    fld dword [x]

    fldl2e
    fmulp

    fld1
    fld st1
    fprem
    f2xm1
    faddp
    fscale

    fld1
    fdiv st0, st1
   
    fsubp
    fld1
    fld1
    faddp
    fdivp

    sub esp,8  
    fstp qword [esp]  
    push print_format1
    call printf
    add esp, 12
    ret

calc2nd:
    push x
    push scan_format
    call scanf
    add esp, 8

    fld1
    fld dword [x]
    fld st0
    fmulp

    fld1
    faddp
    fsqrt
    
    fld dword [x]
    faddp

    fyl2x
    fldl2e
    fdivp
    
    sub esp,8  
    fstp qword [esp]  
    push print_format2
    call printf
    add esp, 12
    ret

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80


; lnxTaylor:
;     inc eax
;     mov ecx, 1
;     fld dword [x]
;     xn:
;         cmp ecx, eax
;         je finish_xn
;         fld dword [x]
;         fmulp
;         inc ecx
;         jmp xn
        
;     finish_xn:
;         fld dword [n]
;         fdivp
;         cmp [switch], dword 1
;         je subtracts
;         adds:
;             fadd
;             inc dword [switch]
;             jmp incrementDivisor
;         subtracts:
;             fsub
;             dec dword [switch]
;         incrementDivisor:
;             fld dword [n]
;             fld1
;             faddp
;             fstp dword [n]
;             cmp eax, [maxn]
;             jl lnxTaylor