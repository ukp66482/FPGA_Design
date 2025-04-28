#include <stdio.h>
#include "xil_printf.h"
#include "xil_io.h"
#include "xparameters.h"
#include "Bitonic_sorter.h"
#include "parity_generator.h"
#include "arithmetic.h"
#include "platform.h"

typedef enum {
    DESCENDING = 0,
    ASCENDING  = 1
} SortDirection;

int main(){
    init_platform();
    calculation(XPAR_ARITHMETIC_0_BASEADDR, -128, -1, '+');
    calculation(XPAR_ARITHMETIC_0_BASEADDR, -128, -1, '-');
    calculation(XPAR_ARITHMETIC_0_BASEADDR, -128, -1, '*');
    calculation(XPAR_ARITHMETIC_0_BASEADDR, 127, -1, '+');
    calculation(XPAR_ARITHMETIC_0_BASEADDR, 127, -1, '-');
    calculation(XPAR_ARITHMETIC_0_BASEADDR, 127, -1, '*');
    printf("Ascending:\r\n");
    bitonic_sort(XPAR_BITONIC_SORTER_0_BASEADDR, 0x77743217, ASCENDING);
    bitonic_sort(XPAR_BITONIC_SORTER_0_BASEADDR, 0x1fb4a219, ASCENDING);
    bitonic_sort(XPAR_BITONIC_SORTER_0_BASEADDR, 0x123489af, ASCENDING);
    printf("Descending:\r\n");
    bitonic_sort(XPAR_BITONIC_SORTER_0_BASEADDR, 0x77743217, DESCENDING);
    bitonic_sort(XPAR_BITONIC_SORTER_0_BASEADDR, 0x1fb4a219, DESCENDING);
    bitonic_sort(XPAR_BITONIC_SORTER_0_BASEADDR, 0x123489af, DESCENDING);
    parity(XPAR_PARITY_GENERATOR_0_BASEADDR, 0x1);
    parity(XPAR_PARITY_GENERATOR_0_BASEADDR, 0x6);
    parity(XPAR_PARITY_GENERATOR_0_BASEADDR, 0xffffffff);
    parity(XPAR_PARITY_GENERATOR_0_BASEADDR, 0x13579ade);
    cleanup_platform();
    return 0;
}