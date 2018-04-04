//
//  MergeSort.s
//  AlgAsm
//
//  Created by Razvan Grigoroiu on 13-04-13.
//  Copyright (c) 2013 .
//  *** incomplete ****
//


//A procedure activation record is the stack frame created when a procedure is entered

//C 64bit ABI (__fastcall)
//The first six integer arguments (from the left) are passed in RDI, RSI, RDX, RCX, R8, and R9, in that order.
//Additional integer arguments are passed on the stack. 



.text
//int* sort(int[] input, int size);
.private_extern	_sort
.globl _sort
_sort:
pushq	%rbp                            #save frame pointer
movq	%rsp, %rbp                      #moves stack pointer into base pointer, 
                                        #now rbp point to the start of the stack frame


#leaq	_helloMessage(%rip), %rdi
#callq	_puts

                      #return value
movq	%rdi, -8(%rbp)
movl	%esi, -12(%rbp)
 
movq -8(%rbp), %rax  
popq	%rbp                            #restore base pointer
ret


.section	__TEXT,__cstring,cstring_literals

_helloMessage:  
.asciz	 "Staring merge sort!"
 
 
 /*
 
 sort2:                                 ## @sort2
 Ltmp2:
 .cfi_startproc
 Lfunc_begin0:
 .loc	1 13 0                  ## /Users/razvan/Documents/Dev/Asm/AlgAsm/AlgAsm/main.c:13:0
 ## BB#0:
 pushq	%rbp
 Ltmp3:
 .cfi_def_cfa_offset 16
 Ltmp4:
 .cfi_offset %rbp, -16
 movq	%rsp, %rbp
 Ltmp5:
 .cfi_def_cfa_register %rbp
 movq	%rdi, -8(%rbp)
 movl	%esi, -12(%rbp)
 .loc	1 14 5 prologue_end     ## /Users/razvan/Documents/Dev/Asm/AlgAsm/AlgAsm/main.c:14:5
 Ltmp6:
 movq	-8(%rbp), %rax
 popq	%rbp
 ret
 */
