//
//  StringLength.s
//  AlgAsm
//
//  Created by Razvan on 13-06-25.
//  Copyright (c) 2013. All rights reserved.
//



//C 64bit ABI (__fastcall)
//The first six integer arguments (from the left) are passed in RDI, RSI, RDX, RCX, R8, and R9, in that order.
//Additional integer arguments are passed on the stack.

.text

//int getStringLength(char*);
.private_extern	_getStringLength
.globl _getStringLength
_getStringLength:

#prolog
pushq	%rbp                            #save frame pointer
movq	%rsp, %rbp                      #moves stack pointer into base pointer,
#now rbp point to the start of the stack frame
movq %rdi, %rax # %rcx = parameter 1
//xorl %eax, %eax

loop:
  cmpb $0, (%rax)
  jz exit

  incq %rax
  jmp loop
exit:
  subq %rdi, %rax
#epilog
  
  popq	%rbp                            #restore base pointer
  ret
