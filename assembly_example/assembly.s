.global dostuff

dostuff:
    pushl %ebp
    movl %esp, %ebp
    call noarg_function
    ret
