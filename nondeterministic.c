/*
 * This program is supposed to count up to a random (small) number.
 * However, it is buggy - sometimes the loop to print out the numbers seems
 * to keep going forever.  Can you figure out where it goes wrong?
 *
 * While this program is nondeterministic, the bug occurs fairly frequently.
 * This usually isn't the case for nondeterministic bugs - usually the best
 * way to troubleshoot them is to insert printf's or logging code and try
 * to reproduce the bugs from the logs of the runs which crashed.
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

/* An absolute value function */
int abs(int x)
{
    if (x >= 0)
        return x;
    else
        return -x;
}

/**
 * Function to return the microseconds of the current clock value.
 * This is not buggy.
 */
int microtime()
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_usec;
}

int main(int argv, char** argc)
{
    int a, b, i;

    /* seed the random number generator with the microseconds of the
       current time. */
    srand(microtime());
    
    /* choose the number to count up to */
    a = rand() << 28;
    b = abs(a) >> 28; /* this should be a number between 0 and 7 */

    /* count! */
    for (i = 0; i != b; i++)
    {
        printf("%d\n", i);
    }

    return 0;
}
