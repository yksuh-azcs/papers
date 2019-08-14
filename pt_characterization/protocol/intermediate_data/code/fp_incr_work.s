	.file	"fp_incr_work.c"
	.comm	c,1,1
	.text
.globl incr_work
	.type	incr_work, @function
incr_work:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movss	%xmm0, -36(%rbp)
	movss	-36(%rbp), %xmm1
	movss	.LC0(%rip), %xmm0
	mulss	%xmm1, %xmm0
	unpcklps	%xmm0, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movq	$1, -32(%rbp)
	jmp	.L2
.L7:
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	jmp	.L3
.L4:
	addq	$1, -16(%rbp)
	addq	$1, -24(%rbp)
.L3:
	movl	$4294967294, %eax
	cmpq	%rax, -24(%rbp)
	jbe	.L4
	addq	$1, -32(%rbp)
.L2:
	movsd	-8(%rbp), %xmm0
	ucomisd	.LC1(%rip), %xmm0
	jae	.L5
	movsd	-8(%rbp), %xmm0
	cvttsd2siq	%xmm0, %rax
	jmp	.L6
.L5:
	movsd	-8(%rbp), %xmm0
	movsd	.LC1(%rip), %xmm1
	subsd	%xmm1, %xmm0
	cvttsd2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L6:
	cmpq	-32(%rbp), %rax
	jae	.L7
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	incr_work, .-incr_work
	.section	.rodata
.LC2:
	.string	"1"
.LC3:
	.string	"send() failed"
	.text
.globl reply
	.type	reply, @function
reply:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, %eax
	movl	%esi, -8(%rbp)
	movb	%al, -4(%rbp)
	movl	-8(%rbp), %eax
	movl	$0, %ecx
	movl	$1, %edx
	movl	$.LC2, %esi
	movl	%eax, %edi
	call	send
	cmpq	$-1, %rax
	jne	.L10
	movl	$.LC3, %edi
	call	perror
.L10:
	movl	-8(%rbp), %eax
	movl	%eax, %edi
	call	close
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	reply, .-reply
	.section	.rodata
.LC5:
	.string	"Socket"
.LC6:
	.string	"command socket : %d\n"
.LC7:
	.string	"Setsockopt"
.LC8:
	.string	"Unable to bind"
.LC9:
	.string	"Listen"
.LC10:
	.string	"Data Socket Error"
.LC11:
	.string	"data socket : %d\n"
.LC12:
	.string	"w"
.LC13:
	.string	"run.log"
.LC14:
	.string	"cannot bind"
.LC15:
	.string	"accepted failed"
.LC16:
	.string	"OK, I am ready to receive!"
	.align 8
.LC17:
	.string	"\nWaiting for incoming data connections..."
.LC18:
	.string	"data socket accept failed"
	.align 8
.LC19:
	.string	"ready to receive data ...  %d\n"
	.align 8
.LC20:
	.string	"\n done with receipt ... : %.2f\n"
.LC21:
	.string	"received running time: %.2f\n"
	.text
.globl main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$216, %rsp
	movl	%edi, -212(%rbp)
	movq	%rsi, -224(%rbp)
	movl	$0x00000000, %eax
	movl	%eax, -80(%rbp)
	movl	$4, -76(%rbp)
	movl	$1, -100(%rbp)
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	.cfi_offset 3, -24
	call	socket
	movl	%eax, -72(%rbp)
	cmpl	$-1, -72(%rbp)
	jne	.L13
	movl	$.LC5, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L13:
	movl	$.LC6, %eax
	movl	-72(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	leaq	-100(%rbp), %rdx
	movl	-72(%rbp), %eax
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%eax, %edi
	call	setsockopt
	cmpl	$-1, %eax
	jne	.L14
	movl	$.LC7, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L14:
	movw	$2, -128(%rbp)
	movl	$2400, %edi
	call	htons
	movw	%ax, -126(%rbp)
	movl	$0, -124(%rbp)
	leaq	-128(%rbp), %rax
	addq	$8, %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	bzero
	leaq	-128(%rbp), %rcx
	movl	-72(%rbp), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind
	cmpl	$-1, %eax
	jne	.L15
	movl	$.LC8, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L15:
	movl	-72(%rbp), %eax
	movl	$5, %esi
	movl	%eax, %edi
	call	listen
	cmpl	$-1, %eax
	jne	.L16
	movl	$.LC9, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L16:
	movl	$1, -52(%rbp)
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket
	movl	%eax, -60(%rbp)
	cmpl	$-1, -60(%rbp)
	jne	.L17
	movl	$.LC10, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L17:
	movl	$.LC11, %eax
	movl	-60(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movl	$.LC12, %edx
	movl	$.LC13, %eax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -48(%rbp)
	leaq	-100(%rbp), %rdx
	movl	-60(%rbp), %eax
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%eax, %edi
	call	setsockopt
	cmpl	$-1, %eax
	jne	.L18
	movl	$.LC7, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L18:
	movl	$2401, -36(%rbp)
	movw	$2, -176(%rbp)
	movl	-36(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	htons
	movw	%ax, -174(%rbp)
	movl	$0, -172(%rbp)
	leaq	-176(%rbp), %rax
	addq	$8, %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	bzero
	leaq	-176(%rbp), %rcx
	movl	-60(%rbp), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind
	cmpl	$-1, %eax
	jne	.L19
	movl	$.LC14, %edi
	call	puts
	movl	$.LC8, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L19:
	movl	-60(%rbp), %eax
	movl	$5, %esi
	movl	%eax, %edi
	call	listen
	cmpl	$-1, %eax
	jne	.L20
	movl	$.LC9, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L30:
	nop
	jmp	.L20
.L31:
	nop
.L20:
	movl	$16, -148(%rbp)
	leaq	-148(%rbp), %rdx
	leaq	-144(%rbp), %rcx
	movl	-72(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	accept
	movl	%eax, -68(%rbp)
	cmpl	$0, -68(%rbp)
	jns	.L21
	movl	$.LC15, %edi
	call	perror
.L21:
	leaq	-193(%rbp), %rcx
	movl	-68(%rbp), %eax
	movl	$1, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -64(%rbp)
	cmpl	$0, -64(%rbp)
	jle	.L30
	movzbl	-193(%rbp), %eax
	cmpb	$100, %al
	jne	.L23
	movzbl	-193(%rbp), %eax
	movsbl	%al, %eax
	movl	-68(%rbp), %edx
	movl	%edx, %esi
	movl	%eax, %edi
	call	reply
	movl	$.LC16, %edi
	call	puts
	movl	$.LC17, %edi
	call	puts
	movl	$16, -200(%rbp)
	leaq	-200(%rbp), %rdx
	leaq	-192(%rbp), %rcx
	movl	-60(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	accept
	movl	%eax, -56(%rbp)
	cmpl	$0, -56(%rbp)
	jns	.L24
	movl	$.LC18, %edi
	call	perror
.L24:
	movl	$.LC19, %eax
	movl	-76(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf
	movl	$0, -32(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
.L26:
	movq	%rsp, %rax
	movq	%rax, %rbx
	movl	$4, -20(%rbp)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -96(%rbp)
	cltq
	addq	$15, %rax
	addq	$15, %rax
	shrq	$4, %rax
	salq	$4, %rax
	subq	%rax, %rsp
	movq	%rsp, %rax
	addq	$15, %rax
	shrq	$4, %rax
	salq	$4, %rax
	movq	%rax, -88(%rbp)
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-88(%rbp), %rcx
	movl	-56(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -32(%rbp)
	cmpl	$0, -32(%rbp)
	jle	.L25
	movl	-32(%rbp), %eax
	addl	%eax, -28(%rbp)
	movq	-88(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -80(%rbp)
.L25:
	movq	%rbx, %rsp
	movl	-28(%rbp), %eax
	cmpl	-76(%rbp), %eax
	jl	.L26
	movss	-80(%rbp), %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$.LC20, %eax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf
	movl	-56(%rbp), %eax
	movl	%eax, %esi
	movl	$49, %edi
	call	reply
	nop
	jmp	.L20
.L23:
	movzbl	-193(%rbp), %eax
	cmpb	$115, %al
	jne	.L27
	movss	-80(%rbp), %xmm0
	call	incr_work
.L27:
	movzbl	-193(%rbp), %eax
	movsbl	%al, %eax
	movl	-68(%rbp), %edx
	movl	%edx, %esi
	movl	%eax, %edi
	call	reply
	movzbl	-193(%rbp), %eax
	cmpb	$107, %al
	jne	.L31
	nop
	movss	-80(%rbp), %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$.LC21, %edx
	movq	-48(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movl	$0, %eax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1320029098
	.align 8
.LC1:
	.long	0
	.long	1138753536
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-3)"
	.section	.note.GNU-stack,"",@progbits
