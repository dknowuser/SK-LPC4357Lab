STACK_SIZE EQU 0x400
Sign_Value EQU 0x5A5A5A5A

GPIOSET              EQU 0x400F6218
GPIOCLR              EQU 0x400F6298
LED                  EQU 0xFFFF1000
DELAY                EQU 0xFFFF0000


	EXPORT __initial_sp_M0                [WEAK]
	EXPORT Reset_Handler_M0               [WEAK]
	EXPORT NMI_Handler_M0                 [WEAK]
	EXPORT HardFault_Handler_M0           [WEAK]
	EXPORT MemManage_Handler_M0           [WEAK]
	EXPORT BusFault_Handler_M0            [WEAK]
	EXPORT UsageFault_Handler_M0          [WEAK]
	EXPORT SVC_Handler_M0                 [WEAK]
	EXPORT DebugMon_Handler_M0            [WEAK]
	EXPORT PendSV_Handler_M0              [WEAK]
	EXPORT SysTick_Handler_M0             [WEAK]
	EXPORT DAC_IRQHandler_M0              [WEAK]
    EXPORT IPC_Master2Slave_IRQHandler_M0 [WEAK]
	
	AREA STACK, NOINIT, READWRITE
Stack_Mem_M0       SPACE   STACK_SIZE
__initial_sp_M0

	AREA M0, CODE, READONLY
Reset_Handler_M0 PROC
	
	THUMB
	nop	
	ldr r0,=GPIOSET
	ldr r1,=GPIOCLR
	ldr r2,=LED
	
;Main loop
lpb

;Turn the LED on
	;str r2, [r0]
	
;Delay
delay
;Make delay
	ldr r3,=DELAY;

continue2
	;ldr r0,=DELAY;
continue1
	;subs r0, r0, #0x1;
	;bne continue1;
	
	;subs r3, r3, #0x1
	;bne continue1
	;beq ledoff
	;b continue2;

;Turn the LED off
ledoff
	;str r2, [r1]
	
	b lpb	
	ENDP
	
NMI_Handler_M0 PROC
	b NMI_Handler_M0
	ENDP

HardFault_Handler_M0 PROC
	b HardFault_Handler_M0
	ENDP

MemManage_Handler_M0 PROC
	b MemManage_Handler_M0
	ENDP

BusFault_Handler_M0 PROC
	b BusFault_Handler_M0
	ENDP

UsageFault_Handler_M0 PROC
	b UsageFault_Handler_M0
	ENDP

SVC_Handler_M0 PROC
	b SVC_Handler_M0
	ENDP

DebugMon_Handler_M0 PROC
	b DebugMon_Handler_M0
	ENDP

PendSV_Handler_M0 PROC
	b PendSV_Handler_M0
	ENDP

SysTick_Handler_M0 PROC
	b SysTick_Handler_M0
	ENDP
	
DAC_IRQHandler_M0 PROC
	b DAC_IRQHandler_M0
	ENDP
	
IPC_Master2Slave_IRQHandler_M0 PROC
	b IPC_Master2Slave_IRQHandler_M0
	ENDP
	END 