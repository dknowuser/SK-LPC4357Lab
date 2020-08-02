Delay      EQU 4064
GPIOSET    EQU 0x400F6218
GPIOCLR    EQU 0x400F6298
GPIO6DIR   EQU 0x400F6018
GPIO6MASK  EQU 0x400F6098
SCU_PC_12  EQU 0x40086630
CLR_EN     EQU 0x40044FD8
CLR_STAT   EQU 0x40044FE8
LED        EQU 0x00000800
BEGIN      EQU 0x0
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

;Set output direction for GPIO6
	ldr r0,=GPIO6DIR;
	mov r1, 0x800;
	str r1, [r0];
	
;Set mask for GPIO
	ldr r0,=GPIO6MASK;
	mov r1, #0;
	str r1, [r0];
	
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