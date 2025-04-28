/***************************** Include Files *******************************/
#include "arithmetic.h"
#include <stdio.h>
/************************** Function Definitions ***************************/

void calculation(UINTPTR baseAddr, s8 a, s8 b, u8 opcode) {
	u32 result;
    s16 ans;
    u8 cal_done = 0;
	u32 input_data = ((u32)opcode << 16) | ((u32)(u8)b << 8) |  ((u32)(u8)a) ;
    
	ARITHMETIC_mWriteReg(baseAddr, 4, input_data); //a b opcode
    ARITHMETIC_mWriteReg(baseAddr, 0, 0x1); //start
	
    do {
        result = ARITHMETIC_mReadReg(baseAddr, 0);
        cal_done = (result >> 17) & 0x1;
    } while (cal_done == 0);

    ARITHMETIC_mWriteReg(baseAddr, 0, 0x0); //done

    ans = (s16)(result & 0xFFFF);
    
    printf("%d %c %d = %d ", a, opcode, b, ans);
    if(result >> 16 & 0x1) printf("-> overflow\r\n");
    else printf("-> non-overflow\r\n");

    return; 
}