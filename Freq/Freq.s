SFSCLK1 EQU 0x40086C04

Sign_Value EQU 0x5A5A5A5A
STACK_SIZE EQU 0x400

	EXPORT STACK_SIZE [WEAK]
	EXPORT Reset_Handler [WEAK]
	EXPORT NMI_Handler [WEAK]
	EXPORT HardFault_Handler [WEAK]
	EXPORT MemManage_Handler [WEAK]
	EXPORT BusFault_Handler [WEAK]
	EXPORT UsageFault_Handler [WEAK]
	EXPORT Sign_Value [WEAK]
	EXPORT SVC_Handler [WEAK]
	EXPORT DebugMon_Handler [WEAK]
	EXPORT PendSV_Handler [WEAK]
	EXPORT SysTick_Handler [WEAK]
	
	AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   STACK_SIZE
__initial_sp

	AREA beg, CODE, READONLY
	ENTRY	
	
Reset_Handler PROC
;Set up	SCU register
	ldr r0,=SFSCLK1
	mov r1, 0x01
	str r1, [r0]
lp	b lp
	
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