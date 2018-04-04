//
//  CalculateCRC.s
//  AlgAsm
//
//  Created by Razvan Grigoroiu on 13-04-14.
//  Copyright (c) 2013. All rights reserved.
//  *** incomplete ***
//
.text

//int calculateCRC(char*);
.private_extern	_calculateCRC
.globl _calculateCRC
_calculateCRC:

#prolog
pushq	%rbp                            #save frame pointer
movq	%rsp, %rbp                      #moves stack pointer into base pointer, 
                                        #now rbp point to the start of the stack frame


#return value
movl    $10, %eax  
#epilog
popq	%rbp                            #restore base pointer
ret




