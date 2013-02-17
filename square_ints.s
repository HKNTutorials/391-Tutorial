	.text
.globl _init_array
_init_array:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	call	L3
"L00000000001$pb":
L3:
	popl	%ecx
	leal	L_my_array$non_lazy_ptr-"L00000000001$pb"(%ecx), %eax
	movl	(%eax), %eax
	leave
	ret
.globl _fillArray
_fillArray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %edx
	subl	$4, %edx
	movl	12(%ebp), %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	movl	%eax, 8(%ebp)
	movl	12(%ebp), %eax
	decl	%eax
	movl	%eax, -16(%ebp)
	jmp	L5
L6:
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	%eax, (%edx)
	subl	$4, 8(%ebp)
	decl	-16(%ebp)
L5:
	movl	8(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jae	L6
	leave
	ret
.globl _squareArray
_squareArray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, -12(%ebp)
	jmp	L10
L11:
	movl	-12(%ebp), %eax
	sall	$2, %eax
	movl	%eax, %edx
	addl	8(%ebp), %edx
	movl	8(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %ecx
	movl	-12(%ebp), %eax
	sall	$2, %eax
	addl	8(%ebp), %eax
	movl	(%eax), %eax
	imull	%ecx, %eax
	movl	%eax, (%edx)
	decl	-12(%ebp)
L10:
	cmpl	$0, -12(%ebp)
	jg	L11
	leave
	ret
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
	pushl	%ebx
	subl	$36, %esp
	call	L19
"L00000000002$pb":
L19:
	popl	%ebx
	leal	LC0-"L00000000002$pb"(%ebx), %eax
	movl	%eax, (%esp)
	call	_printf
	movl	$0, -12(%ebp)
	jmp	L15
L16:
	movl	-12(%ebp), %eax
	sall	$2, %eax
	addl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	leal	LC1-"L00000000002$pb"(%ebx), %eax
	movl	%eax, (%esp)
	call	_printf
	incl	-12(%ebp)
L15:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	L16
	movl	$10, (%esp)
	call	_putchar
	addl	$36, %esp
	popl	%ebx
	leave
	ret
.globl _main
_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$0, -12(%ebp)
	movl	$0, -16(%ebp)
	jmp	L21
L22:
	movl	-16(%ebp), %eax
	sall	$2, %eax
	addl	-12(%ebp), %eax
	movl	$0, (%eax)
	incl	-16(%ebp)
L21:
	cmpl	$49, -16(%ebp)
	jle	L22
	movl	$50, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_fillArray
	movl	$50, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_squareArray
	movl	$50, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_printArray
	movl	$0, %eax
	leave
	ret
.comm _my_array,200,5
	.section __IMPORT,__pointers,non_lazy_symbol_pointers
L_my_array$non_lazy_ptr:
	.indirect_symbol _my_array
	.long	0
	.subsections_via_symbols
