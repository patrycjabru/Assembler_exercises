 
.data
    
.text
.type max_ind, @function
.global max_ind	

max_ind:
    #rdi - a, rsi - b, rdx - c, rcx - d, r8, r9 -args
    #rax - ret
    mov %rdi, %r9   #przenieś a do r9 
    mov $1, %rax    #w rax index 1
    
    #porównaj z b
    cmp %r9, %rsi
    jg bIsGreater
    
cmpWithC:
    cmp %r9, %rdx
    jg cIsGreater
    
cmpWithD:
    cmp %r9, %rcx
    jg dIsGreater
    
checkIfNoReapeat:
    #r8 - reapeat counter
    mov $0, %r8
    cmp %rdi, %r9
    je incCounterAfterA
checkB:
    cmp %rsi, %r9
    je incCounterAfterB
checkC:
    cmp %rdx, %r9
    je incCounterAfterC
checkD:
    cmp %rcx, %r9
    je incCounterAfterD
    
checkCounter:
    cmp $1,%r8
    jne duplicates
end:
    ret
    
duplicates:
    mov $0,%rax
    ret

incCounterAfterA:
    inc %r8
    jmp checkB
    
incCounterAfterB:
    inc %r8
    jmp checkC
    
incCounterAfterC:
    inc %r8
    jmp checkD
    
incCounterAfterD:
    inc %r8
    jmp checkCounter
    
bIsGreater:
    mov %rsi, %r9
    mov $2, %rax
    jmp cmpWithC
    
cIsGreater:
    mov %rdx, %r9
    mov $3, %rax
    jmp cmpWithD
    
dIsGreater:
    mov %rcx, %r9
    mov $4, %rax
    jmp checkIfNoReapeat
