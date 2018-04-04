//
//  main.c
//  AlgAsm
//
//  Created by Razvan Grigoroiu on 13-04-13.
//  Copyright (c) 2013. All rights reserved.
//
//  Entrypoint to a variaty of algorithms written in assembly language AT&T syntax


#include <stdio.h>
#include <string.h>
#define SIZE 100

//8bytes,4bytes
int* sort(int[], int);
int calculateCRC(char*);
__int64_t encodeBase64(char*, char*);
int getStringLength(char*);
int main(int argc, const char * argv[])
{
    
    printf("test\n");
    char* szMsg = "the brown fox jumps over the lazy dog";//dGhlIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZw==
    //543516788 = 0x20656874 = ' eht'
    //8606223178704185460 = 0x776F726220656874
    
    //116 = 0x74 ='t'
    
    char szBase64[1024];
    memset(szBase64,0, sizeof(szBase64));
    
    //int crc32 = calculateCRC(szMsg);
    //printf("CRC=%d",crc32);
//int len = getStringLength(szMsg);
    //printf("len=%d",len);
    
    long long int len = encodeBase64(szMsg, szBase64);
    
    printf("len=%llu, buff='%s'",len,szBase64);
    
    fflush(stdout);
    return 0;
}

int slow(int *a, int *b)
{
    *a = 5;
    *b = 7;
    return *a + *b; // LHS stall: the compiler doesn't
    // know whether a == b, so it has to
    //  reload both before the add
}
int fast(int * __restrict a, int * __restrict b)
{
    *a = 5;
    *b = 7; // RESTRICT promises that a != b
    return *a + *b; // no stall; the compiler hangs onto
    // 5 and 7 in the registers.
}

