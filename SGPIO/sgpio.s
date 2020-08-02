DELAY_BEFORE_START     EQU 0x00010000
Sign_Value 			   EQU 0x5A5A5A5A
STACK_SIZE 			   EQU 0x00000400

SCU_P1_3               EQU 0x4008608C
SCU_P1_4               EQU 0x40086090
SCU_P1_5               EQU 0x40086094
SCU_P6_3               EQU 0x4008630C
SCU_P6_6               EQU 0x40086318
SCU_P7_7               EQU 0x4008639C
SCU_PF_1               EQU 0x40086784
SCU_PF_2               EQU 0x40086788

OUT_MUX_CFG0           EQU 0x40101000
OUT_MUX_CFG1           EQU 0x40101004
OUT_MUX_CFG4           EQU 0x40101010
OUT_MUX_CFG5           EQU 0x40101014
OUT_MUX_CFG7           EQU 0x4010101C
OUT_MUX_CFG10          EQU 0x40101028
OUT_MUX_CFG11          EQU 0x4010102C
OUT_MUX_CFG15          EQU 0x4010103C

SLICE_MUX_CFG0         EQU 0x40101080
SLICE_MUX_CFG1         EQU 0x40101084
SLICE_MUX_CFG4         EQU 0x40101090
SLICE_MUX_CFG5         EQU 0x40101094
SLICE_MUX_CFG7         EQU 0x4010109C
SLICE_MUX_CFG10        EQU 0x401010A8
SLICE_MUX_CFG11        EQU 0x401010AC
SLICE_MUX_CFG15        EQU 0x401010BC

SGPIO_MUX_CFGA         EQU 0x40101040
SGPIO_MUX_CFGC         EQU 0x40101048
SGPIO_MUX_CFGG         EQU 0x40101058
SGPIO_MUX_CFGI         EQU 0x40101060
SGPIO_MUX_CFGK         EQU 0x40101068
SGPIO_MUX_CFGL         EQU 0x4010106C
SGPIO_MUX_CFGN         EQU 0x40101074
SGPIO_MUX_CFGP         EQU 0x4010107C

REGA                   EQU 0x401010C0;SGPIO0
REGC                   EQU 0x401010C8;SGPIO4
REGG                   EQU 0x401010D8;SGPIO10
REGI                   EQU 0x401010E0;SGPIO1
REGK                   EQU 0x401010E8;SGPIO5
REGL                   EQU 0x401010EC;SGPIO7
REGN                   EQU 0x401010F4;SGPIO11
REGP                   EQU 0x401010FC;SGPIO15

REGA_SS                EQU 0x40101100
REGC_SS                EQU 0x40101108
REGG_SS                EQU 0x40101118
REGI_SS                EQU 0x40101120
REGK_SS                EQU 0x40101128
REGL_SS                EQU 0x4010112C
REGN_SS                EQU 0x40101134
REGP_SS                EQU 0x4010113C

PRESET0                EQU 0x40101140
PRESET1                EQU 0x40101148
PRESET4                EQU 0x40101158
PRESET5                EQU 0x40101160
PRESET7                EQU 0x40101168
PRESET10               EQU 0x4010116C
PRESET11               EQU 0x40101174
PRESET15               EQU 0x4010117C

POS0                   EQU 0x401011C0
POS1                   EQU 0x401011C8
POS4                   EQU 0x401011D8
POS5                   EQU 0x401011E0
POS7                   EQU 0x401011E8
POS10                  EQU 0x401011EC
POS11                  EQU 0x401011F4
POS15                  EQU 0x401011FC

CTRL_ENABLED           EQU 0x4010121C
GPIO_OENREG            EQU 0x40101218

CONSTANT0              EQU 0x00000000
CONSTANT1              EQU 0xFFFFFFFF
CONSTANT2              EQU 0x55555555
CONSTANT3              EQU 0xAAAAAAAA
CONSTANT4              EQU 0x50505050
CONSTANT5              EQU 0x60606060
CONSTANT6              EQU 0x70707070
CONSTANT7              EQU 0x80808080

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
	
;Disable all counters	
	ldr r0,=CTRL_ENABLED
	ldr r1,=0x00
	str r1, [r0]
	
;Enable SGPIO pin outputs
	ldr r0,=GPIO_OENREG
	ldr r1,=0x8CB3
	str r1, [r0]

;Set up SCUs
	ldr r0,=SCU_P1_3
	ldr r1,=0x02
	str r1, [r0]
	
	ldr r0,=SCU_P1_4
	str r1, [r0]
	
	ldr r0,=SCU_P6_3
	str r1, [r0]
	
	ldr r0,=SCU_P6_6
	str r1, [r0]
	
	ldr r0,=SCU_P1_5
	ldr r1,=0x06
	str r1, [r0]
	
	ldr r0,=SCU_PF_1
	str r1, [r0]
	
	ldr r0,=SCU_PF_2
	str r1, [r0]
	
	ldr r0,=SCU_P7_7
	ldr r1,=0x07
	str r1, [r0]
	
;Set up 1-bit mode
;Slice A
	ldr r0,=OUT_MUX_CFG0
	;ldr r1,=0x05
	ldr r1,=0x00
	str r1, [r0]

;Slice C
	ldr r0,=OUT_MUX_CFG4
	str r1, [r0]

;Slice G
	ldr r0,=OUT_MUX_CFG10
	str r1, [r0]
	
;Slice I
	ldr r0,=OUT_MUX_CFG1
	;ldr r1,=0x06
	str r1, [r0]
	
;Slice K
	ldr r0,=OUT_MUX_CFG5
	str r1, [r0]
	
;Slice L	
	ldr r0,=OUT_MUX_CFG7
	;ldr r1,=0x07
	str r1, [r0]
	
;Slice N
	ldr r0,=OUT_MUX_CFG11
	str r1, [r0]
	
;Slice P
	ldr r0,=OUT_MUX_CFG15
	str r1, [r0]
	
;Set up SGPIO_MUX_CFGs
	ldr r0,=SGPIO_MUX_CFGA
	ldr r1,=0x800
	str r1, [r0]
	
	ldr r0,=SGPIO_MUX_CFGC
	str r1, [r0]
	
	ldr r0,=SGPIO_MUX_CFGG
	str r1, [r0]
	
	ldr r0,=SGPIO_MUX_CFGI
	str r1, [r0]
	
	ldr r0,=SGPIO_MUX_CFGK
	str r1, [r0]
	
	ldr r0,=SGPIO_MUX_CFGL
	str r1, [r0]
	
	ldr r0,=SGPIO_MUX_CFGN
	str r1, [r0]
	
	ldr r0,=SGPIO_MUX_CFGP
	str r1, [r0]
	
;Set up SLICE_MUX_CFGs
;Shift 1 bit per clock
	ldr r0,=SLICE_MUX_CFG0
	ldr r1,=0x0
	str r1, [r0]
	
	ldr r0,=SLICE_MUX_CFG1
	str r1, [r0]
	
	ldr r0,=SLICE_MUX_CFG4
	str r1, [r0]
	
	ldr r0,=SLICE_MUX_CFG5
	str r1, [r0]
	
	ldr r0,=SLICE_MUX_CFG7
	str r1, [r0]
	
	ldr r0,=SLICE_MUX_CFG10
	str r1, [r0]
	
	ldr r0,=SLICE_MUX_CFG11
	str r1, [r0]
	
	ldr r0,=SLICE_MUX_CFG15
	str r1, [r0]
	
;Set up REGs
	ldr r0,=REGA
	ldr r1,=CONSTANT0
	str r1, [r0]
	
	ldr r0,=REGC
	ldr r1,=CONSTANT1
	str r1, [r0]
	
	ldr r0,=REGG
	ldr r1,=CONSTANT2
	str r1, [r0]
	
	ldr r0,=REGI
	ldr r1,=CONSTANT3
	str r1, [r0]
	
	ldr r0,=REGK
	ldr r1,=CONSTANT4
	str r1, [r0]
	
	ldr r0,=REGL
	ldr r1,=CONSTANT5
	str r1, [r0]
	
	ldr r0,=REGN
	ldr r1,=CONSTANT6
	str r1, [r0]
	
	ldr r0,=REGP
	ldr r1,=CONSTANT7
	str r1, [r0]
	
;Set up REG_SSs
	ldr r0,=REGA_SS
	ldr r1,=CONSTANT0
	str r1, [r0]
	
	ldr r0,=REGC_SS
	ldr r1,=CONSTANT1
	str r1, [r0]
	
	ldr r0,=REGG_SS
	ldr r1,=CONSTANT2
	str r1, [r0]
	
	ldr r0,=REGI_SS
	ldr r1,=CONSTANT3
	str r1, [r0]
	
	ldr r0,=REGK_SS
	ldr r1,=CONSTANT4
	str r1, [r0]
	
	ldr r0,=REGL_SS
	ldr r1,=CONSTANT5
	str r1, [r0]
	
	ldr r0,=REGN_SS
	ldr r1,=CONSTANT6
	str r1, [r0]
	
	ldr r0,=REGP_SS
	ldr r1,=CONSTANT7
	str r1, [r0]
	
;Set up PRESETs
	ldr r0,=PRESET0
	ldr r1,=0xA1
	str r1, [r0]
	
	ldr r0,=PRESET1
	str r1, [r0]
	
	ldr r0,=PRESET4
	str r1, [r0]
	
	ldr r0,=PRESET5
	str r1, [r0]
	
	ldr r0,=PRESET7
	str r1, [r0]
	
	ldr r0,=PRESET10
	str r1, [r0]
	
	ldr r0,=PRESET11
	str r1, [r0]
	
	ldr r0,=PRESET15
	str r1, [r0]
	
;Set up POSs
	ldr r0,=POS0
	ldr r1,=0x1F00
	str r1, [r0]
	
	ldr r0,=POS1
	str r1, [r0]
	
	ldr r0,=POS4
	str r1, [r0]
	
	ldr r0,=POS5
	str r1, [r0]
	
	ldr r0,=POS7
	str r1, [r0]
	
	ldr r0,=POS10
	str r1, [r0]
	
	ldr r0,=POS11
	str r1, [r0]
	
	ldr r0,=POS15
	str r1, [r0]
	
	ldr r0,=CTRL_ENABLED
	ldr r1,=0xAD45
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