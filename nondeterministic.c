#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

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
    srand(microtime());
    
    a = rand() << 28;
    b = abs(a) >> 28; /* this should be a number between 0 and 7 */

    for (i = 0; i != b; i++)
    {
        printf("%d\n", i);
    }

    return 0;
}
