Delay                EQU 8192;4096
GPIOSET              EQU 0x400F6218
GPIOCLR              EQU 0x400F6298
GPIO6DIR             EQU 0x400F6018
GPIO6MASK            EQU 0x400F6098
SCU_PC_12            EQU 0x40086630
SCU_PC_13            EQU 0x40086634
CLR_EN               EQU 0x40044FD8
CLR_STAT             EQU 0x40044FE8
RESET_CTRL0          EQU 0x40053100
RESET_CTRL1          EQU 0x40053104
RESET_STATUS0        EQU 0x40053110
RESET_STATUS3        EQU 0x4005311C
RESET_ACTIVE_STATUS1 EQU 0x40053154
M0SUBMEMMAP          EQU 0x40043308
M0APPMEMMAP          EQU 0x40043404
LED                  EQU 0x00000800
PLL1                 EQU 0x40050044

Sign_Value EQU 0x5A5A5A5A
STACK_SIZE EQU 0x400

	EXPORT __initial_sp                [WEAK]
	EXPORT Reset_Handler               [WEAK]
	EXPORT NMI_Handler                 [WEAK]
	EXPORT HardFault_Handler           [WEAK]
	EXPORT MemManage_Handler           [WEAK]
	EXPORT BusFault_Handler            [WEAK]
	EXPORT UsageFault_Handler          [WEAK]
	EXPORT Sign_Value                  [WEAK]
	EXPORT SVC_Handler                 [WEAK]
	EXPORT DebugMon_Handler            [WEAK]
	EXPORT PendSV_Handler              [WEAK]
	EXPORT SysTick_Handler             [WEAK]
	EXPORT DAC_IRQHandler              [WEAK]
    EXPORT IPC_Slave2Master_IRQHandler [WEAK]
	
	IMPORT Reset_Handler_M0
	
	AREA STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   STACK_SIZE
__initial_sp

	AREA M4, CODE, READONLY		
	ENTRY
Reset_Handler PROC	

	ldr r0,=CLR_EN;
	ldr r1,=0xFFFFFFFF;
	str r1, [r0];
	
	ldr r0,=CLR_STAT;
	ldr r1,=0xFFFFFFFF;
	str r1, [r0];

;Initialise GPIOs
	ldr r0,=SCU_PC_12;
	mov r1, 0x24;
	str r1, [r0];	
	
	ldr r0,=SCU_PC_13;
	mov r1, 0x24;
	str r1, [r0];

;Set output direction for GPIO6
	ldr r0,=GPIO6DIR;
	ldr r1,=0x1800;
	str r1, [r0];
	
;Set mask for GPIO
	ldr r0,=GPIO6MASK;
	mov r1, #0;
	str r1, [r0];
	
	ldr r0,=M0APPMEMMAP
	ldr r1,=0x1b000000
	str r1, [r0]
	
	;Reset M0	
	ldr r0,=RESET_CTRL0
	mov r1, 0x1000
	str r1, [r0]
	
	ldr r0,=RESET_CTRL1
	mov r1, 0x01000000
	str r1, [r0]
	
	;==================================
	ldr r0,=RESET_CTRL0
	mov r1, 0x0
	str r1, [r0]
	
	ldr r0,=RESET_CTRL1
	mov r1, 0x0
	str r1, [r0]
	
	ldr r0,=GPIOSET;
	ldr r1,=GPIOCLR;
	ldr r2,=LED
		
;Main loop
lp
	;Turn the LED on
	str r2, [r0]

;Turn the LED off
	str r2, [r1]

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
	
DAC_IRQHandler PROC
	b DAC_IRQHandler
	ENDP
	
IPC_Slave2Master_IRQHandler PROC
	b IPC_Slave2Master_IRQHandler
	ENDP
	END 