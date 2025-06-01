/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "xil_printf.h"
#include "xil_io.h"
#include "xil_types.h"
#include "xparameters.h"

int main(){
	/*
	bram0_raddr = inst[4:0];
    bram1_addr = inst[9:5];
    dsp_inmode = inst[19:15];
    dsp_opmode = inst[26:20];
    dsp_alumode = inst[30:27];
    execute = inst[31];
	*/

	u32 inst, bram1_read, bram0_read;
    #define XPAR_AXI_GPIO_0_BASEADDR            0x41200000
    #define XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR 0x40000000
    #define XPAR_AXI_BRAM_CTRL_1_S_AXI_BASEADDR 0x42000000
	// u32 test_p;

	/* ------------------DSP computing stage 1------------------------*/
	printf("-------------------------------\r\n");
	printf("BRAM1[3] <= BRAM0[0] * BRAM1[2]\r\n"); // 38432 -> check
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R 
	// inst = 0_0000_0000101_10001_00000_00010_00000
	inst = 0b00000000010110001000000001000000;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	// test_p = Xil_In32(XPAR_AXI_GPIO_1_BASEADDR + 0);
	// printf("Data = %x\r\n", test_p);

	/*---------------------Write to BRAM1[3]---------------------------*/
    //        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
    // inst = 1_0000_0000010_00000_00011_00000_00000
	inst = 0b10000000001000000000110000000000;
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);




	printf("---------------------------------\r\n");
	printf("BRAM1[7] <= BRAM0[11] * BRAM1[3]\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0000_0000101_10001_00000_00011_01011
	inst = 0b00000000010110001000000001101011;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[7]---------------------------*/
    //        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
    // inst = 1_0000_0000010_00000_00111_00000_00000
	inst = 0b10000000001000000001110000000000;
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	printf("---------------------------------\r\n");
	printf("BRAM1[10] <= BRAM0[31] * BRAM1[7] + C\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0000_0110101_10001_00000_00111_11111
	inst = 0b00000011010110001000000011111111;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[10]---------------------------*/
    //        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
    // inst = 1_0000_0000010_00000_01010_00000_00000
	inst = 0b10000000001000000010100000000000;
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	printf("---------------------------------\r\n");
	printf("BRAM1[13] <= C - BRAM0[1] * BRAM1[6]\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0011_0110101_10001_00000_00110_00001
	inst = 0b00011011010110001000000011000001;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[13]---------------------------*/
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
    // inst = 1_0000_0000010_00000_01101_00000_00000
	inst = 0b10000000001000000011010000000000;
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	printf("---------------------------------\r\n");
	printf("BRAM1[15] <= BRAM0[0] * BRAM1[31] - C - 1\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0001_0110101_10001_00000_11111_00000
	inst = 0b00001011010110001000001111100000;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[15]---------------------------*/
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
    // inst = 1_0000_0000010_00000_00011_00000_00000
	inst = 0b10000000001000000011110000000000;
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);
    
    // Print BRAM1
    printf("First Print BRAM1:\r\n");
    for (int i = 0; i < 32; i++) {
        bram1_read = Xil_In32(XPAR_AXI_BRAM_CTRL_1_S_AXI_BASEADDR + 4*i);
        printf("BRAM1[%d] = 0x%x\r\n", i, bram1_read);        
    }
    printf("====================\r\n");

    for (int i = 0; i < 32; i++) {
        Xil_Out32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4*i, (i+1)*(i+1));
    }

	printf("====================\r\n");

	// ------------------DSP computing stage 2------------------------//
	printf("--------------------------------\r\n");
	printf("BRAM1[16] <= BRAM0[0] * BRAM1[2]\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0000_0000101_10001_00000_00010_00000
    inst = 0b00000000010110001000000001000000;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[16]---------------------------*/
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 1_0000_0000010_00000_10000_00000_00000
	inst = 0b10000000001000000100000000000000;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	printf("--------------------------------\r\n");
	printf("BRAM1[17] <= BRAM0[11] * BRAM1[3]\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0000_0000101_10001_00001_00011_01011
	inst = 0b00000000010110001000010001101011;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[17]---------------------------*/
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 1_0000_0000010_00000_10001_00000_00000
	inst = 0b10000000001000000100010000000000;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	printf("--------------------------------\r\n");
	printf("BRAM1[18] <= BRAM0[31] * BRAM1[7] + C\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0000_0110101_10001_00010_00111_11111
	inst = 0b00000011010110001000100011111111;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[18]---------------------------*/
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 1_0000_0000010_00000_10010_00000_00000
	inst = 0b10000000001000000100100000000000;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);
	
	printf("--------------------------------\r\n");
	printf("BRAM1[19] <= C - BRAM0[1] * BRAM1[6]\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0011_0110101_10001_00011_00110_00001
	inst = 0b00011011010110001000110011000001;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[19]---------------------------*/
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 1_0000_0000010_00000_10011_00000_00000
	inst = 0b10000000001000000100110000000000;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);


    printf("---------------------------------\r\n");
	printf("BRAM1[20] <= BRAM0[0] * BRAM1[31] - C - 1\r\n");
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
	// inst = 0_0001_0110101_10001_00000_11111_00000
	inst = 0b00001011010110001000001111100000;
	Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);

	/*---------------------Write to BRAM1[15]---------------------------*/
	//        E/ ALU/    OP /   IN/ B1WR/ B1R /  B0R
    // inst = 1_0000_0000010_00000_00011_00000_00000
	inst = 0b10000000001000000101000000000000;
    Xil_Out32(XPAR_AXI_GPIO_0_BASEADDR, inst);
    

	printf("Second Print BRAM1:\r\n");
	for (int i = 0; i < 32; i++) {
		bram1_read = Xil_In32(XPAR_AXI_BRAM_CTRL_1_S_AXI_BASEADDR + 4*i);
		printf("BRAM1[%d] = 0x%x\r\n", i, bram1_read);        
	}
	printf("====================\r\n");

}

