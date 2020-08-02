DELAY_BEFORE_START     EQU 0x01000000
Sign_Value 			   EQU 0x5A5A5A5A
STACK_SIZE 			   EQU 0x00000400

SCU_PF_1               EQU 0x40086784
SCU_PF_2               EQU 0x40086788
SCU_PF_3               EQU 0x4008678C
SCU_PF_9               EQU 0x400867A4
SCU_P6_3               EQU 0x4008630C
SCU_P6_6               EQU 0x40086318
SCU_PD_2               EQU 0x40086688
SCU_P7_7               EQU 0x4008639C
SCU_P8_0               EQU 0x40086400
SCU_P7_2               EQU 0x40086388

OUT_MUX_CFG0           EQU 0x40101000
OUT_MUX_CFG1           EQU 0x40101004
OUT_MUX_CFG2           EQU 0x40101008
OUT_MUX_CFG3           EQU 0x4010100C
OUT_MUX_CFG4           EQU 0x40101010
OUT_MUX_CFG5           EQU 0x40101014
OUT_MUX_CFG6           EQU 0x40101018
OUT_MUX_CFG7           EQU 0x4010101C
OUT_MUX_CFG8           EQU 0x40101020

SGPIO_MUX_CFGA         EQU 0x40101040
SLICE_MUX_CFG0         EQU 0x40101080
REGA                   EQU 0x401010C0
REGA_SS                EQU 0x40101100
PRESET0                EQU 0x40101140
COUNT0                 EQU 0x40101180
POS0                   EQU 0x401011C0
CTRL_ENABLED           EQU 0x4010121C
GPIO_OENREG            EQU 0x40101218

MASK_A                 EQU 0x40101200
SET_EN_1               EQU 0X40101F24
SET_EN_2               EQU 0x40101F44

ISER0                  EQU 0xE000E100
IPR1                   EQU 0xE000E404

CONSTANT               EQU 0xFFFFFFFF
;CONSTANT               EQU 0x00000040
;CONSTANT               EQU 0x0
CONSTANTA              EQU 0xFDA85500

	EXPORT __initial_sp       [WEAK]
	EXPORT Reset_Handler      [WEAK]
	EXPORT NMI_Handler        [WEAK]
	EXPORT HardFault_Handler  [WEAK]
	EXPORT MemManage_Handler  [WEAK]
	EXPORT BusFault_Handler   [WEAK]
	EXPORT UsageFault_Handler [WEAK]
	EXPORT Sign_Value         [WEAK]
	EXPORT SVC_Handler        [WEAK]
	EXPORT DebugMon_Handler   [WEAK]
	EXPORT PendSV_Handler     [WEAK]
	EXPORT SysTick_Handler    [WEAK]
	
	EXPORT DAC [WEAK]
	EXPORT M0APP [WEAK]
	EXPORT DMA [WEAK]
	EXPORT FLASHEEPROM [WEAK]
	EXPORT ETHERNET [WEAK]
	EXPORT SDIO [WEAK]
	EXPORT LCD [WEAK]
	EXPORT USB0 [WEAK]
	EXPORT USB1 [WEAK]
	EXPORT SCTimer_PWM [WEAK]
	EXPORT RITIMER [WEAK]
	EXPORT TIMER0 [WEAK]
	EXPORT TIMER1 [WEAK]
	EXPORT TIMER2 [WEAK]
	EXPORT TIMER3 [WEAK]
	EXPORT MCPWM [WEAK]
	EXPORT ADC0 [WEAK]
	EXPORT I2C0 [WEAK]
	EXPORT I2C1 [WEAK]
	EXPORT SPI [WEAK]
	EXPORT ADC1 [WEAK]
	EXPORT SSP0 [WEAK]
	EXPORT SSP1 [WEAK]
	EXPORT USART0 [WEAK]
	EXPORT UART1 [WEAK]
	EXPORT USART2 [WEAK]
	EXPORT USART3 [WEAK]
	EXPORT I2S0 [WEAK]
	EXPORT I2S1 [WEAK]
	EXPORT SPIFI [WEAK]
	EXPORT SGPIO [WEAK]
	
	AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   STACK_SIZE
__initial_sp

	AREA beg, CODE, READONLY
	ENTRY	
	
Reset_Handler PROC	
;Make delay before actual start (for JTAG)
	ldr r0,=DELAY_BEFORE_START
delay
	subs r0,#0x01
	bne delay
	
;Disable all counters
	ldr r0,=CTRL_ENABLED
	ldr r1,=0x0
	str r1, [r0]
	
;Set up SCUs
	ldr r0,=SCU_PF_1
	ldr r1,=0x66
	str r1, [r0]
	
	ldr r0,=SCU_PF_2
	str r1, [r0]
	
	ldr r0,=SCU_PF_3
	str r1, [r0]
	
	ldr r0,=SCU_PF_9
	str r1, [r0]
	
	ldr r0,=SCU_P6_3
	ldr r1,=0x62
	str r1, [r0]
	
	ldr r0,=SCU_P6_6
	str r1, [r0]
	
	ldr r0,=SCU_P7_7
	ldr r1,=0x67
	str r1, [r0]
	
	ldr r0,=SCU_PD_2
	str r1, [r0]
	
	ldr r0,=SCU_P7_2
	str r1, [r0]
	
	ldr r0,=SCU_P8_0
	ldr r1,=0x64
	str r1, [r0]
	
;Set up 8-bit 8a mode
;Slice A
	ldr r0,=OUT_MUX_CFG0
	ldr r1,=0x9
	str r1, [r0]
	
	ldr r0,=OUT_MUX_CFG1
	str r1, [r0]
	
	ldr r0,=OUT_MUX_CFG2
	str r1, [r0]
	
	ldr r0,=OUT_MUX_CFG3
	str r1, [r0]
	
	ldr r0,=OUT_MUX_CFG4
	str r1, [r0]
	
	ldr r0,=OUT_MUX_CFG5
	str r1, [r0]
	
	ldr r0,=OUT_MUX_CFG6
	str r1, [r0]
	
	ldr r0,=OUT_MUX_CFG7
	str r1, [r0]

;SGPIO8 - Ack
	ldr r0,=OUT_MUX_CFG8
	ldr r1,=0x8
	str r1, [r0]
	
;Set up SGPIO_MUX_CFGA
	ldr r0,=SGPIO_MUX_CFGA
	ldr r1,=0x01
	str r1, [r0]
	
;Set up SLICE_MUX_CFG0
	ldr r0,=SLICE_MUX_CFG0
	ldr r1,=0xC4
	str r1, [r0]
	
;Set up REGA
	ldr r0,=REGA
	ldr r1,=CONSTANT
	str r1, [r0]
	
;Set up mask
	ldr r0,=REGA_SS
	ldr r1,=CONSTANTA
	str r1, [r0]
	
;Set up PRESET0
	ldr r0,=PRESET0
	ldr r1,=0x00
	str r1, [r0]
	
;Set up POS0
	ldr r0,=POS0
	ldr r1,=0xFF00
	str r1, [r0]
	
;Disable output pins
	ldr r0,=GPIO_OENREG
	ldr r1,=0x0
	str r1, [r0]
	
;Enable interrupts
	cpsie i

;Enable SGPIO interrupt
	ldr r0,=ISER0
	ldr r1,=0x80000000
	str r1, [r0]
	
;Enable exchange clock interrupt
	ldr r0,=SET_EN_1
	ldr r1,=0x1
	str r1, [r0]
	
;Enable counter
	ldr r0,=CTRL_ENABLED
	ldr r1,=0x1
	str r1, [r0]

lp
	b lp
	ENDP
	
NMI_Handler PROC
	b NMI_Handler
	ENDP

HardFault_Handler PROC
	b HardFault_Handler
	ENDP

MemManage_Handler PROC
	b MemManage_Handler
	ENDP

BusFault_Handler PROC
	b BusFault_Handler
	ENDP

UsageFault_Handler PROC
	b UsageFault_Handler
	ENDP

SVC_Handler PROC
	b SVC_Handler
	ENDP

DebugMon_Handler PROC
	b DebugMon_Handler
	ENDP

PendSV_Handler PROC
	b PendSV_Handler
	ENDP

SysTick_Handler PROC
	b SysTick_Handler
	ENDP

DAC PROC
	b DAC
	ENDP
	
M0APP PROC
	b M0APP
	ENDP
	
DMA PROC
	b DMA
	ENDP
	
FLASHEEPROM PROC
	b FLASHEEPROM
	ENDP
	
ETHERNET PROC
	b ETHERNET
	ENDP
	
SDIO PROC
	b SDIO
	ENDP
	
LCD PROC
	b LCD
	ENDP
	
USB0 PROC
	b USB0
	ENDP
	
USB1 PROC
	b USB1
	ENDP
	
SCTimer_PWM PROC
	b SCTimer_PWM
	ENDP
	
RITIMER PROC
	b RITIMER
	ENDP
	
TIMER0 PROC
	b TIMER0
	ENDP
	
TIMER1 PROC
	b TIMER1
	ENDP
	
TIMER2 PROC
	b TIMER2
	ENDP
	
TIMER3 PROC
	b TIMER3
	ENDP
	
MCPWM PROC
	b MCPWM
	ENDP
	
ADC0 PROC
	b ADC0
	ENDP
	
I2C0 PROC
	b I2C0
	ENDP
	
I2C1 PROC
	b I2C1
	ENDP
	
SPI PROC
	b SPI
	ENDP
	
ADC1 PROC
	b ADC1
	ENDP
	
SSP0 PROC
	b SSP0
	ENDP
	
SSP1 PROC
	b SSP1
	ENDP
	
USART0 PROC
	b USART0
	ENDP
	
UART1 PROC
	b UART1
	ENDP
	
USART2 PROC
	b USART2
	ENDP
	
USART3 PROC
	b USART3
	ENDP
	
I2S0 PROC
	b I2S0
	ENDP
	
I2S1 PROC
	b I2S1
	ENDP
	
SPIFI PROC
	b SPIFI
	ENDP
	
SGPIO PROC

;Disable counter
	ldr r0,=CTRL_ENABLED
	ldr r1,=0x0
	str r1, [r0]

stop
	b stop
	ENDP
	END 