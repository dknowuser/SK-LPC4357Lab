#include "board.h"
#include "gpio_18xx_43xx.h"

#define ON 	1
#define OFF 0

#define sk4357 
//#define mini4357 
//#define mak4337
//#define dev4337

void LEDS_Init(void)
{
	#ifdef mini4357
	Chip_SCU_PinMuxSet(0xD, 4, (SCU_PINIO_FAST | SCU_MODE_FUNC4));						// mini4357 PD_4 connected to 	manual GPIO6.18
	Chip_SCU_PinMuxSet(0xD, 2, (SCU_PINIO_FAST | SCU_MODE_FUNC4));						// mini4357 PD_2 connected to 	manual GPIO6.16
	Chip_SCU_PinMuxSet(0xD, 0, (SCU_PINIO_FAST | SCU_MODE_FUNC4));						// mini4357 PD_0 connected to 	manual GPIO6.14
	
	LPC_GPIO_PORT->DIR[6] |= (1<<18);
	LPC_GPIO_PORT->DIR[6] |= (1<<16);
	LPC_GPIO_PORT->DIR[6] |= (1<<14);
	#endif

	#ifdef sk4357
	Chip_SCU_PinMuxSet(0xD, 4, (SCU_PINIO_FAST | SCU_MODE_FUNC4));						// sk4357 PD_4 connected to 	manual GPIO6.18
	Chip_SCU_PinMuxSet(0xD, 2, (SCU_PINIO_FAST | SCU_MODE_FUNC4));						// sk4357 PD_2 connected to 	manual GPIO6.16
	Chip_SCU_PinMuxSet(0xD, 0, (SCU_PINIO_FAST | SCU_MODE_FUNC4));						// sk4357 PD_0 connected to 	manual GPIO6.14
	Chip_SCU_PinMuxSet(0xC, 12, (SCU_PINIO_FAST | SCU_MODE_FUNC4));						// sk4357 PC_12 connected to 	manual GPIO6.11
		
	LPC_GPIO_PORT->DIR[6] |= (1<<18);
	LPC_GPIO_PORT->DIR[6] |= (1<<16);
	LPC_GPIO_PORT->DIR[6] |= (1<<14);
	LPC_GPIO_PORT->DIR[6] |= (1<<11);
	#endif	
	
	#ifdef mak4337
	Chip_SCU_PinMuxSet(0x2, 11, (SCU_PINIO_FAST | SCU_MODE_FUNC0));						// mak4357 P2_11 connected to 	manual GPIO1.11
	Chip_SCU_PinMuxSet(0x2, 12, (SCU_PINIO_FAST | SCU_MODE_FUNC0));						// mak4357 P2_12 connected to 	manual GPIO1.12
	Chip_SCU_PinMuxSet(0x2, 13, (SCU_PINIO_FAST | SCU_MODE_FUNC0));						// mak4357 P2_13 connected to 	manual GPIO1.13
	
	LPC_GPIO_PORT->DIR[1] |= (1<<13);
	LPC_GPIO_PORT->DIR[1] |= (1<<12);
	LPC_GPIO_PORT->DIR[1] |= (1<<11);
	
	#endif

	#ifdef dev4337
	Chip_SCU_PinMuxSet(0x2, 11, (SCU_PINIO_FAST | SCU_MODE_FUNC0));						// mak4357 P2_11 connected to 	manual GPIO1.11
	Chip_SCU_PinMuxSet(0x2, 12, (SCU_PINIO_FAST | SCU_MODE_FUNC0));						// mak4357 P2_12 connected to 	manual GPIO1.12
	Chip_SCU_PinMuxSet(0x2, 13, (SCU_PINIO_FAST | SCU_MODE_FUNC0));						// mak4357 P2_13 connected to 	manual GPIO1.13
	
	LPC_GPIO_PORT->DIR[1] |= (1<<13);
	LPC_GPIO_PORT->DIR[1] |= (1<<12);
	LPC_GPIO_PORT->DIR[1] |= (1<<11);
	#endif
}

void Delay(void)
{
	int i;
	for (i=0;i<7000000;)
	{
		i++;
	}
}

void LEDS_Switch(int val)
{
		#ifdef mini4357
		LPC_GPIO_PORT->B[6][14] = val;
		Delay();
		LPC_GPIO_PORT->B[6][16] = val;
		Delay();
		LPC_GPIO_PORT->B[6][18] = val;
		#endif
		
		#ifdef sk4357
		LPC_GPIO_PORT->B[6][11] = val;
		Delay();
		LPC_GPIO_PORT->B[6][14] = val;
		Delay();
		LPC_GPIO_PORT->B[6][16] = val;
		Delay();
		LPC_GPIO_PORT->B[6][18] = val;
		#endif
		
		#ifdef mak4337
		LPC_GPIO_PORT->B[1][11] = val;
		Delay();
		LPC_GPIO_PORT->B[1][12] = val;
		Delay();
		LPC_GPIO_PORT->B[1][13] = val;
		#endif
		
		#ifdef dev4337
		LPC_GPIO_PORT->B[1][11] = val;
		Delay();
		LPC_GPIO_PORT->B[1][12] = val;
		Delay();
		LPC_GPIO_PORT->B[1][13] = val;
		#endif
}

int main(void)
{
	LEDS_Init();
	while (1) 
	{	
		LEDS_Switch(ON);
		Delay();
		LEDS_Switch(OFF);
	}
}
