	.text
.globl _init_array
_init_array:
	pushl	%ebp
	movl	%esp, %ebp
	xorl	%eax, %eax
	leave
	ret
.globl _fillArray
_fillArray:
	pushl	%ebp
	movl	%ebp, %esp
	pushl	%ebx
	movl	8(%ebp), %ecx
	movl	12(%ebp), %eax
	leal	-4(%ecx,%eax,4), %edx
	jmp	L8
L5:
	movl	%eax, (%edx)
	subl	$4, %edx
L8:
	decl	%eax
	cmpl	%ecx, %edx
	jae	L5
	popl	%ebx
	leave
	ret
.globl _squareArray
_squareArray:
	pushl	%ebp
	pushl	%ebx
	movl	8(%ebp), %ebx
	movl	12(%ebp), %eax
	leal	(%ebx,%eax,4), %edx
	movl	%eax, %ecx
	jmp	L11
L12:
	movl	4(%edx), %eax
	imull	4(%ebx), %eax
	movl	%eax, 4(%edx)
	decl	%ecx
	leave
	ret
L11:
	subl	$4, %edx
	testl	%ecx, %ecx
	jg	L12
	popl	%ebx
	.cstring
LC0:
	.ascii "Array is: \0"
LC1:
	.ascii "%d \0"
	.text
.globl _printArray
_printArray:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	call	L20
"L00000000001$pb":
L20:
	popl	%ebx
	movl	8(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	12(%ebp), %edi
	leal	LC0-"L00000000001$pb"(%ebx), %eax
	movl	%eax, (%esp)
	call	_printf
	xorl	%esi, %esi
	leal	LC1-"L00000000001$pb"(%ebx), %edx
	movl	%edx, -32(%ebp)
	jmp	L16
L17:
	movl	-28(%ebp), %edx
	movl	(%edx,%esi,4), %eax
	movl	%eax, 4(%esp)
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	_printf
	incl	%esi
L16:
	cmpl	%edi, %esi
	jl	L17
	movl	$10, 8(%ebp)
	addl	$44, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	jmp	_putchar
.globl _main
_main:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$49, %eax
L22:
	movl	%eax, 0(,%eax,4)
	decl	%eax
	jmp	L22
.comm _my_array,200,5
	.subsections_via_symbols
