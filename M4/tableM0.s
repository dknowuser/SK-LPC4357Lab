	IMPORT __initial_sp_M0
	IMPORT Reset_Handler_M0
	IMPORT NMI_Handler_M0
	IMPORT HardFault_Handler_M0
	IMPORT MemManage_Handler_M0
	IMPORT BusFault_Handler_M0
	IMPORT UsageFault_Handler_M0
	IMPORT Sign_Value
	IMPORT SVC_Handler_M0
	IMPORT DebugMon_Handler_M0
	IMPORT PendSV_Handler_M0
	IMPORT SysTick_Handler_M0
	IMPORT DAC_IRQHandler_M0
    IMPORT IPC_Master2Slave_IRQHandler_M0

	AREA M0, CODE, READONLY
	ENTRY
	THUMB
	dcd __initial_sp_M0
	dcd Reset_Handler_M0
	dcd NMI_Handler_M0
	dcd HardFault_Handler_M0
	dcd MemManage_Handler_M0
	dcd BusFault_Handler_M0
	dcd UsageFault_Handler_M0
	dcd Sign_Value
	dcd 0
	dcd 0
	dcd 0
	dcd SVC_Handler_M0
	dcd DebugMon_Handler_M0
	dcd 0
	dcd PendSV_Handler_M0
	dcd SysTick_Handler_M0
	dcd DAC_IRQHandler_M0
    dcd IPC_Master2Slave_IRQHandler_M0
	
	END
