#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"

#define LED_DEVICE_ID  XPAR_AXI_GPIO_0_BASEADDR
#define LED_CHANNEL    1

#define PWM_PERIOD     255      // 8-bit PWM
#define PWM_DELAY      50       // PWM 週期延遲時間 (調整可控制亮度穩定度)
#define COLOR_HOLD_MS  1000     // 每個顏色停留時間 (ms)

// RGB LED pin bit 定義 (假設 BGR 分別對應 bit2/bit1/bit0)
#define R_MASK 0x1
#define G_MASK 0x2
#define B_MASK 0x4

XGpio LED_Gpio;

typedef struct {
    u8 B;
    u8 G;
    u8 R;
} RGBColor;

RGBColor rainbow[7] = {
    {0x3C, 0x14, 0xDC}, // 紅 #dc143c
    {0x00, 0x45, 0xFF}, // 橙 #ff4500
    {0x00, 0xD7, 0xFF}, // 黃 #ffd700
    {0x7F, 0xFF, 0x00}, // 綠 #00ff7f
    {0xFF, 0x90, 0x1E}, // 藍 #1e90ff
    {0xCD, 0x00, 0x00}, // 靛 #0000cd
    {0xD3, 0x00, 0x94}  // 紫 #9400d3
};


int main() {
    int status = XGpio_Initialize(&LED_Gpio, LED_DEVICE_ID);
    if (status != XST_SUCCESS) {
        xil_printf("GPIO Init Failed\r\n");
        return XST_FAILURE;
    }

    XGpio_SetDataDirection(&LED_Gpio, LED_CHANNEL, 0x00); // Set as output

    xil_printf("Start Rainbow LED PWM\r\n");

    int idx = 0;
    RGBColor color;
    while (1) {
        xil_printf("idx: %d\r\n", idx);
        color = rainbow[idx];
        for (int t = 0; t < COLOR_HOLD_MS * (1000 / PWM_DELAY); t++) {
            for (int duty = 0; duty < PWM_PERIOD; duty++) {
                u8 out = 0;

                if (duty < color.R) out |= R_MASK;
                if (duty < color.G) out |= G_MASK;
                if (duty < color.B) out |= B_MASK;

                XGpio_DiscreteWrite(&LED_Gpio, LED_CHANNEL, out);
            }
        }
        idx = (idx + 1) % 7;
    }

    return XST_SUCCESS;
}
