	IMPORT __initial_sp
	IMPORT Reset_Handler
	IMPORT NMI_Handler
	IMPORT HardFault_Handler
	IMPORT MemManage_Handler
	IMPORT BusFault_Handler
	IMPORT UsageFault_Handler
	IMPORT Sign_Value
	IMPORT SVC_Handler
	IMPORT DebugMon_Handler
	IMPORT PendSV_Handler
	IMPORT SysTick_Handler
	
	IMPORT DAC
	IMPORT M0APP
	IMPORT DMA
	IMPORT FLASHEEPROM
	IMPORT ETHERNET
	IMPORT SDIO
	IMPORT LCD
	IMPORT USB0
	IMPORT USB1
	IMPORT SCTimer_PWM
	IMPORT RITIMER
	IMPORT TIMER0
	IMPORT TIMER1
	IMPORT TIMER2
	IMPORT TIMER3
	IMPORT MCPWM
	IMPORT ADC0
	IMPORT I2C0
	IMPORT I2C1
	IMPORT SPI
	IMPORT ADC1
	IMPORT SSP0
	IMPORT SSP1
	IMPORT USART0
	IMPORT UART1
	IMPORT USART2
	IMPORT USART3
	IMPORT I2S0
	IMPORT I2S1
	IMPORT SPIFI
	IMPORT SGPIO

	AREA RESET, CODE, READONLY
	THUMB
	dcd __initial_sp
	dcd Reset_Handler
	dcd NMI_Handler
	dcd HardFault_Handler
	dcd MemManage_Handler
	dcd BusFault_Handler
	dcd UsageFault_Handler
	dcd Sign_Value
	dcd 0
	dcd 0
	dcd 0
	dcd SVC_Handler
	dcd DebugMon_Handler
	dcd 0
	dcd PendSV_Handler
	dcd SysTick_Handler

;External interrupts
	dcd DAC
	dcd M0APP
	dcd DMA
	dcd 0
	dcd FLASHEEPROM
	dcd ETHERNET
	dcd SDIO
	dcd LCD
	dcd USB0
	dcd USB1
	dcd SCTimer_PWM
	dcd RITIMER
	dcd TIMER0
	dcd TIMER1
	dcd TIMER2
	dcd TIMER3
	dcd MCPWM
	dcd ADC0
	dcd I2C0
	dcd I2C1
	dcd SPI
	dcd ADC1
	dcd SSP0
	dcd SSP1
	dcd USART0
	dcd UART1
	dcd USART2
	dcd USART3
	dcd I2S0
	dcd I2S1
	dcd SPIFI
	dcd SGPIO
	
	END
