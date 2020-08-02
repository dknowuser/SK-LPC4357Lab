	IMPORT __initial_sp
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
	IMPORT DAC_IRQHandler
    IMPORT IPC_Slave2Master_IRQHandler

	AREA RESET, CODE, READONLY
	THUMB
	dcd __initial_sp
	dcd Reset_Handler + 1
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
		
    dcd DAC_IRQHandler
    dcd IPC_Slave2Master_IRQHandler
	
	END
