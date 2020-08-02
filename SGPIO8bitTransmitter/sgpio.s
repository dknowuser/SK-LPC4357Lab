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

;CONSTANT               EQU 0xFFFFFFFF
;CONSTANT               EQU 0x00000040
;CONSTANT               EQU 0x0
CONSTANT               EQU 0xFFAA5500

	EXPORT STACK_SIZE         [WEAK]
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
	
;Set up SCUs
	ldr r0,=SCU_PF_1
	ldr r1,=0x6
	str r1, [r0]
	
	ldr r0,=SCU_PF_2
	str r1, [r0]
	
	ldr r0,=SCU_PF_3
	str r1, [r0]
	
	ldr r0,=SCU_PF_9
	str r1, [r0]
	
	ldr r0,=SCU_P6_3
	ldr r1,=0x2
	str r1, [r0]
	
	ldr r0,=SCU_P6_6
	str r1, [r0]
	
	ldr r0,=SCU_P7_7
	ldr r1,=0x7
	str r1, [r0]
	
	ldr r0,=SCU_PD_2
	str r1, [r0]
	
	ldr r0,=SCU_P7_2
	str r1, [r0]
	
	ldr r0,=SCU_P8_0
	ldr r1,=0x4
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
	ldr r1,=0x800
	str r1, [r0]
	
;Set up SLICE_MUX_CFG0
	ldr r0,=SLICE_MUX_CFG0
	ldr r1,=0xC0
	str r1, [r0]
	
;Set up REGA
	ldr r0,=REGA
	ldr r1,=CONSTANT
	str r1, [r0]
	
;Set up REGA_SS	
	ldr r0,=REGA_SS
	ldr r1,=CONSTANT
	str r1, [r0]
	
;Set up PRESET0
	ldr r0,=PRESET0
	ldr r1,=0x00
	str r1, [r0]
	
;Set up COUNT0
	;ldr r0,=COUNT0
	;ldr r1,=0x01
	;str r1, [r0]
	
;Set up POS0
	ldr r0,=POS0
	ldr r1,=0xFF00
	str r1, [r0]
	
;Enable pins
	ldr r0,=GPIO_OENREG
	ldr r1,=0x1FF
	str r1, [r0]
	
;Enable counter
	ldr r0,=CTRL_ENABLED
	ldr r1,=0x1
	str r1, [r0]

lp
	b lp
	ENDP
	
NMI_Handler PROC
	b Reset_Handler
	ENDP

HardFault_Handler PROC
	b Reset_Handler
	ENDP

MemManage_Handler PROC
	b Reset_Handler
	ENDP

BusFault_Handler PROC
	b Reset_Handler
	ENDP

UsageFault_Handler PROC
	b Reset_Handler
	ENDP

SVC_Handler PROC
	b Reset_Handler
	ENDP

DebugMon_Handler PROC
	b Reset_Handler
	ENDP

PendSV_Handler PROC
	b Reset_Handler
	ENDP

SysTick_Handler PROC
	b Reset_Handler
	ENDP	
	END 