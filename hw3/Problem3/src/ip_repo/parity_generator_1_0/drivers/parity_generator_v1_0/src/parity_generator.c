/***************************** Include Files *******************************/
#include <stdio.h>
#include <xil_printf.h>
#include "parity_generator.h"
/************************** Function Definitions ***************************/
void parity(UINTPTR baseAddr, u32 data){
    u32 result = 0;
    u8 done = 0;
	PARITY_GENERATOR_mWriteReg(baseAddr, 4, data);
    PARITY_GENERATOR_mWriteReg(baseAddr, 0, 0x1); //start -> 1
	
    do {
        result = PARITY_GENERATOR_mReadReg(baseAddr, 0);
        done = (result >> 1) & 0x1;
    } while (done == 0);

    PARITY_GENERATOR_mWriteReg(baseAddr, 0, 0x0); //start -> 0
    printf("%x -> %x\r\n",data, result & 0x1);

    return; 
}