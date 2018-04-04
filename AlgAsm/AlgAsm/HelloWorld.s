//
//  HelloWorld.s
//  AlgAsm
//
//  Created by Razvan Grigoroiu on 13-04-13.
//  Copyright (c) 2013 . All rights reserved.
//

/*
.text

.private_extern	_main
.globl	_main
_main:                                  #   main entry point

pushq	%rbp                            #save frame pointer
movq	%rsp, %rbp


leaq	_helloMessage(%rip), %rdi
callq	_puts

xorl	%eax, %eax
popq	%rbp
ret

.section	__TEXT,__cstring,cstring_literals

_helloMessage:  
.asciz	 "Hello world!"
*/
