.data
min:
    .quad 0
max:
    .quad 0
    
.text
.type max_diff, @function
.global max_diff	

max_diff:
    #rdi - a, rsi - b, rdx - c, rcx - d, r8, r9 -args
    #rax - ret
    mov %rdi,min
    cmp %rsi,min
    jg bToMin
cmpCMin:
    cmp %rdx,min
    jg cToMin
cmpDMin:
    cmp %rcx,min
    jg dToMin
    
    jmp findMax
    
bToMin:
    mov %rsi,min
    jmp cmpCMin

cToMin:
    mov %rdx,min
    jmp cmpDMin
    
dToMin:
    mov %rcx,min
    jmp findMax
    
    
findMax:
    mov %rdi,max
    cmp %rsi,max
    jl bToMax
cmpCMax:
    cmp %rdx,max
    jl cToMax
cmpDMax:
    cmp %rcx,max
    jl dToMax
    
    jmp end
    
bToMax:
    mov %rsi,max
    jmp cmpCMax

cToMax:
    mov %rdx,max
    jmp cmpDMax
    
dToMax:
    mov %rcx,max
    jmp end

end:
    mov max,%rax
    mov min,%r8
    sub %r8,%rax
    #mov %r8,%rax
    ret
