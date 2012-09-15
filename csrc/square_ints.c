#include <stdio.h>

int my_array[50]; 

int* init_array()
{
    return my_array;
}

void fillArray(int *array, int len)
{
    int* begin = array;
		int i;
    array += len-1;
    for (i = len-1; array >= begin; i--)
    {
        *array = i;
        array--;
    }
}

void squareArray(int *array, int len)
{
    int i;

    /* square each element */
    for (i = len; i > 0; i--)
        array[i] = array[1]*array[i];
}

void printArray(int *array, int len)
{
    int i;

    printf ("Array is: ");

    for (i = 0; i < len; i++)
        printf("%d ", array[i]);

    printf("\n");
}

int main()
{
    int *array = NULL;
    int i;
    for (i = 0; i < 50; i++) {
        array[i] = 0;
    }

    fillArray(array, 50);
    squareArray(array, 50);
    printArray(array, 50);

    return 0;
}
