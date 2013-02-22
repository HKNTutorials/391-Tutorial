#include <stdio.h>

extern int dostuff();

int main()
{
    dostuff();

    return 0;
}

int noarg_function()
{
    int i = 0;
    int sum = 0;

    printf("Computing 0 + 1 + 2 + ... + 9\n");

    // inline assembly for this computation.
    asm volatile (
        "loop:\n\
        addl %0, %1     # sum += i\n\
        incl %0        # i++\n\
        cmpl $10, %0    \n\
        jl loop         # loop if i < 10\n\
        "
        : "=r" (i), "=r" (sum) // output list
        : "0" (i) // input list
            /* the 0 means that this input should be allocated in the
               same space as the 0th item, i.e. the output (i). This way
               the assembly can read and write i.*/
        : // clobber list
    );

    printf("sum is %d\n", sum);

    return 0;
}
