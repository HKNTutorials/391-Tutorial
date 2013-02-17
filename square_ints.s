# This program is supposed to initialize an array to the first few integers,
# square each value and then print out the resulting array. However it looks
# like whoever wrote it wasn't too great at assembly. Can you fix it up for
# them?

# You should be comfortable with everything in this file with the exception of
# the pseudo-ops (those that start with a ., such as .text, .section and .size)
# and the single instruction sal, which is an arithmetic left shift. So now you
# should be familiar with all of the assembly code.

	.file	"square_ints.c"
	.comm	my_array,200,32
	.text
.globl init_array
	.type	init_array, @function
init_array:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$my_array, %eax
	popl	%ebp
	ret
	.size	init_array, .-init_array
.globl fillArray
	.type	fillArray, @function
fillArray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	12(%ebp), %eax
	subl	$1, %eax
	sall	$2, %eax
	addl	%eax, 8(%ebp)
	movl	12(%ebp), %eax
	subl	$1, %eax
	movl	%eax, -4(%ebp)
	jmp	.L4
.L5:
	movl	8(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	%edx, (%eax)
	subl	$4, 8(%ebp)
	subl	$1, -4(%ebp)
.L4:
	movl	8(%ebp), %eax
	cmpl	-8(%ebp), %eax
	jae	.L5
	leave
	ret
	.size	fillArray, .-fillArray
.globl squareArray
	.type	squareArray, @function
squareArray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, -4(%ebp)
	jmp	.L8
.L9:
	movl	-4(%ebp), %eax
	sall	$2, %eax
	addl	8(%ebp), %eax
	movl	8(%ebp), %edx
	addl	$4, %edx
	movl	(%edx), %ecx
	movl	-4(%ebp), %edx
	sall	$2, %edx
	addl	8(%ebp), %edx
	movl	(%edx), %edx
	imull	%ecx, %edx
	movl	%edx, (%eax)
	subl	$1, -4(%ebp)
.L8:
	cmpl	$0, -4(%ebp)
	jg	.L9
	leave
	ret
	.size	squareArray, .-squareArray
	.section	.rodata
.LC0:
	.string	"Array is: "
.LC1:
	.string	"%d "
	.text
.globl printArray
	.type	printArray, @function
printArray:
	pushl	%ebp
	movl	%ebp, %esp
	subl	$40, %esp
	movl	$.LC0, %eax
	movl	%eax, (%esp)
	call	printf
	movl	$0, -12(%ebp)
	jmp	.L12
.L13:
	movl	-12(%ebp), %eax
	sall	$2, %eax
	addl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	$.LC1, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	addl	$1, -12(%ebp)
.L12:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L13
	movl	$10, (%esp)
	call	putchar
  mov %esp, %ebp
  pop %ebp
	leave
	ret
	.size	printArray, .-printArray
.globl main
	.type	main, @function
# This is the main function. It has the general structure:
# prepare the array (you'll have to figure out what this entails)
# call fillArray
# call squareArray
# call printArray
# and does nothing else
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$0, 24(%esp)
	movl	$0, 28(%esp)
	jmp	.L16
.L17:
	movl	28(%esp), %eax
	sall	$2, %eax
	addl	24(%esp), %eax
	movl	$0, (%eax)
	addl	$1, 28(%esp)
.L16:
	cmpl	$49, 28(%esp)
	jle	.L17
	movl	$50, 4(%esp)
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	fillArray
	movl	$50, 4(%esp)
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	squareArray
	movl	$50, 4(%esp)
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	printArray
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 4.4.6 20120305 (Red Hat 4.4.6-4)"
	.section	.note.GNU-stack,"",@progbits
