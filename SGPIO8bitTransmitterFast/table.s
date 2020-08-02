	IMPORT STACK_SIZE
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

	AREA RESET, CODE, READONLY
	THUMB
	dcd STACK_SIZE
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
	
	END
