#ifndef __LIB_KERNEL_PRINT_H
#define __LIB_KERNEL_PRINT_H
#include "stdint.h"                 // defint value type
void put_char(uint8_t char_asci);   // put single char
void put_str(char* messags);        // put string
void put_int(uint32_t num);         // put hex integer
#endif