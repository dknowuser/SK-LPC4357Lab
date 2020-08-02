Delay     EQU 4064
GPIOSET   EQU 0x400F6218
GPIOCLR   EQU 0x400F6298
GPIO6DIR  EQU 0x400F6018
GPIO6MASK EQU 0x400F6098
SCU_PC_12 EQU 0x40086630
CLR_EN    EQU 0x40044FD8
CLR_STAT  EQU 0x40044FE8
RESET_CTRL0          EQU 0x40053100
RESET_CTRL1          EQU 0x40053104
RESET_STATUS0        EQU 0x40053110
RESET_STATUS3        EQU 0x4005311C
RESET_ACTIVE_STATUS1 EQU 0x40053154

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
	
	;Initialize M0 core
	ldr r0,=RESET_CTRL0
	mov r1, 0x0
	str r1, [r0]
	
	ldr r0,=RESET_CTRL1
	mov r1, 0x0
	str r1, [r0]
	
	ldr r0,=RESET_STATUS3
	ldr r2, [r0]
	ldr r1,=0xFFFCFFFF
	and r1, r1, r2
	str r1, [r0]
	
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
	
;Main loop
lp
	ldr r0,=GPIOSET;
	ldr r1, [r0];
	subs r1, 0x800;
	beq led_off;
;Turn the LED on
	mov r1, 0x800;
	str r1, [r0];
	
	b delay;
;Turn the LED off
led_off
	ldr r0,=GPIOCLR;
	mov r1, 0x800;
	str r1, [r0];

delay
;Make delay
	mov r3, #Delay;

continue2
	mov r0, #Delay;
continue1
	subs r0, r0, 0x1;
	bne continue1;
	
	subs r3, r3, 0x1;
	bne continue2;
	
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