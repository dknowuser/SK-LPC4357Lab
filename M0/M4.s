Delay                EQU 4064
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
	
	AREA STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   STACK_SIZE
__initial_sp

	AREA M4, CODE, READONLY		
	ENTRY
	THUMB
Reset_Handler PROC		
lp	
;Main loop
	ldr r0,=GPIOSET;
	ldr r1, [r0];
	subs r1, r1, #0x1000;
	beq led_off;
;Turn the LED on
	ldr r1,=0x1000;
	str r1, [r0];
	
	b delay;
;Turn the LED off
led_off
	ldr r0,=GPIOCLR;
	ldr r1,=0x1000;
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