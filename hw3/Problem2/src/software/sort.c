
#include <stdio.h>
#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"

#define SW_DEVICE_ID   XPAR_AXI_GPIO_0_BASEADDR
#define SWITCH_CHANNEL    1

#define SIZE 10

XGpio SW_Gpio;

// Merge sort's merge function
void merge(int arr[], int left, int mid, int right, int ascending) {
    int n1 = mid - left + 1;
    int n2 = right - mid;

    int L[SIZE], R[SIZE];

    for (int i = 0; i < n1; i++) L[i] = arr[left + i];
    for (int j = 0; j < n2; j++) R[j] = arr[mid + 1 + j];

    int i = 0, j = 0, k = left;

    while (i < n1 && j < n2) {
        if ((ascending && L[i] <= R[j]) || (!ascending && L[i] >= R[j])) {
            arr[k++] = L[i++];
        } else {
            arr[k++] = R[j++];
        }
    }

    while (i < n1) arr[k++] = L[i++];
    while (j < n2) arr[k++] = R[j++];
}

// Merge sort's main function
void merge_sort(int arr[], int left, int right, int ascending) {
    if (left < right) {
        int mid = (left + right) / 2;
        merge_sort(arr, left, mid, ascending);
        merge_sort(arr, mid + 1, right, ascending);
        merge(arr, left, mid, right, ascending);
    }
}

int main() {
	int SW_Status;
    int ascending;
	u32 sw_data;
    int sort_data[SIZE];

	/* Initialize the GPIO driver */
	SW_Status = XGpio_Initialize(&SW_Gpio, SW_DEVICE_ID);
	if (SW_Status) {
		xil_printf("Gpio Initialization Failed\r\n");
		return XST_FAILURE;
	}

	/* Set the direction for all signals as inputs except the LED output */
	XGpio_SetDataDirection(&SW_Gpio, SWITCH_CHANNEL, 0x03);
    xil_printf("Sorting Program Start!\r\n");
    
    while(1) {
        xil_printf("Select mode (sw = 0, increasing; sw = 1, decreasing):\r\n");
        xil_printf("Once select done, Press 'y' and hit Enter to continue...\r\n");
        while (getchar() != 'y');
        
        sw_data = XGpio_DiscreteRead(&SW_Gpio, 1);
        ascending = (sw_data == 0);
        xil_printf("switches data = %d\r\n", sw_data);
        xil_printf("Please input 10 non-negative integers.\r\n");

        while (getchar() != EOF) {
            
            // 0: sorting increasingly, 1: sorting decreasingly
            if (sw_data == 0) {
                xil_printf("Sorting increasingly...\r\n");
            } else if (sw_data == 1) {
                xil_printf("Sorting decreasingly...\r\n");
            } else {
                xil_printf("Unknown Control!\r\n");
            }

            for (int i = 0; i< SIZE; i++) {
                printf("Input num %d:", i + 1);
                scanf("%d", &sort_data[i]);
                printf("%d\r\n", sort_data[i]);
            }

            // Sorting
            merge_sort(sort_data, 0, SIZE - 1, ascending);

            printf("Sorting Result:\r\n");
            for (int i = 0; i < SIZE; i++) {
                printf("%d ", sort_data[i]);
            }
            printf("\r\n");            
            break;
        }
    }

    xil_printf("Successfully ran Gpio Example\r\n");
    return XST_SUCCESS;
}