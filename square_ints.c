#include <stdio.h>

int my_array[50];

void fillArray(int *array, int len)
{
	asm (
	"movl	8(%ebp), %ecx \n\
	movl	12(%ebp), %edx \n\
	xorl	%eax, %eax \n\
	jmp	fill_loop_comparison \n\
fill_loop_body: \n\
	movl	%eax, (%ecx,%eax,4) \n\
	incl	%eax \n\
fill_loop_comparison: \n\
	cmpl	%edx, %eax \n\
	jl	fill_loop_body \n\
	"
	);
	/*
	int i;

	for (int i = 0; i < len; i++) {
		array[i] = i;
	}
	*/
}

void squareArray(int *array, int len)
{
	asm (
	"pushl	%ebx \n\
	movl	8(%ebp), %ecx \n\
	movl	12(%ebp), %ebx \n\
	xorl	%edx, %edx \n\
	jmp	square_loop_comparison \n\
square_loop_body: \n\
	movl	(%ecx,%edx,4), %eax \n\
	imull	(%ecx), %eax \n\
	movl	%eax, (%ecx,%edx,4) \n\
	decl	%edx \n\
square_loop_comparison: \n\
	cmpl	%ebx, %edx \n\
	jl	square_loop_body \n\
	popl	%ebx \n\
	"
	);
	/*
    int i;

    //square each element
    for (i = 0; i < len; i--)
        array[i] = array[0]*array[i];
	*/
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
    int *array = (int *) 0xDEADBEEF;

		fillArray(array, 50);
		squareArray(array, 50);
		printArray(array, 50);

    return 0;
}
