//
//  EncodeBase64.s
//  AlgAsm
//
//  Created by Razvan on 13-06-24.
//  Copyright (c) 2013. All rights reserved.
//
/*
 notes on encoding base64
 1) create array of 64 chars ar= { A-Z, a-z, 0-9, +,/ }
 2)loop through the input characters 3 at a time (i+=3)
 3) define a1, a2, a3 = 0 and b1, b2,b3, b4 = 0
 
 let a1 = input[i]
 if(input.length > i+1
 let a2 = input[i+1]
 
 if(input.length > i+2
 let a3 = input[i+2]
 
 b1 = a1 >> 2
 b2 = (a1 & 3) << 4 |  a2 >> 4
 b3 = a2 & 0x0F  << 2 | a3 >>6
 b4 =  a3 &0x3F
 
 output+= ar[b1] +ar[b2] +   input.lenght > i+1?ar[b3]:'=' + input.lenght > i+2?ar[b4]:'='

*/


//C 64bit ABI (__fastcall)
//The first six integer arguments (from the left) are passed in RDI, RSI, RDX, RCX, R8, and R9, in that order.
//Additional integer arguments are passed on the stack.

.text

//int encodeBase64(char*, char*);
.private_extern	_encodeBase64
.globl _encodeBase64
_encodeBase64:

#prolog
pushq	%rbp                            #save frame pointer
movq	%rsp, %rbp                      #moves stack pointer into base pointer,
#now rbp point to the start of the stack frame
movq %rdi, %rcx # %rcx = parameter 1
movq %rsi, %r9 #parameter 2 (out)


leaq _baseChars(%rip), %r8

loop:
 #clear rax register by xoring with itself
 xorq %rax, %rax
 #copy quadword (64bits) from where currently rcx points into rdi
 movq (%rcx), %rbx


 #byte 1
 movb %bl, %al
 cmpb $0, %al
 jz exit
 shrb $2, %al
 addq %r8, %rax

 movb (%rax), %al
 movb %al, (%rsi)
 incq %rsi

 #byte 2
 xorq %rax, %rax
 movb %bl, %al
 andb $0x03, %al
 shlb $4, %al
 movb %bh, %ah
 andb $0xF0, %ah
 shrb $4, %ah
 addb %ah, %al
 xorb %ah, %ah
 addq %r8, %rax
 movb (%rax), %al
 movb %al, (%rsi)
 incq %rsi

#byte 3
 xorq %rax, %rax
 movb %bh, %al
 cmpb $0, %al
 jz exit2
 andb $0x0F, %al
 shlb $2, %al
 shrq $16, %rbx
 movb %bl, %ah
 shrb $6, %ah
 addb %ah, %al

 xorb %ah, %ah
 addq %r8, %rax
 movb (%rax), %al
 movb %al, (%rsi)
 incq %rsi
#byte 4
 xorq %rax, %rax
 movb %bl, %al
 cmpb $0, %al
 jz exit1

 andb $0x3F, %al
 addq %r8, %rax
 movb (%rax), %al
 movb %al, (%rsi)
 incq %rsi
 xorq %rax, %rax
 movb $3, %al
 addq %rcx, %rax
 movq %rax, %rcx
 jmp loop


# jmp loop
exit2:
movb $'=', %al
movb %al, (%rsi)
incq %rsi
exit1:
movb $'=', %al
movb %al, (%rsi)
incq %rsi

exit:
xorq %rax, %rax
movb %al, (%rsi)
movq %rsi, %rax
subq %r9,%rax

#epilog
popq	%rbp                            #restore base pointer
ret

.section	__TEXT,__cstring,cstring_literals

_baseChars:
.asciz	 "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz01234567890+/"
