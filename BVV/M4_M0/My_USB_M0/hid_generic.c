/*
 * @brief This file contains USB HID Generic example using USB ROM Drivers.
 *
 * @note
 * Copyright(C) NXP Semiconductors, 2013
 * All rights reserved.
 *
 * @par
 * Software that is described herein is for illustrative purposes only
 * which provides customers with programming information regarding the
 * LPC products.  This software is supplied "AS IS" without any warranties of
 * any kind, and NXP Semiconductors and its licensor disclaim any and
 * all warranties, express or implied, including all implied warranties of
 * merchantability, fitness for a particular purpose and non-infringement of
 * intellectual property rights.  NXP Semiconductors assumes no responsibility
 * or liability for the use of the software, conveys no license or rights under any
 * patent, copyright, mask work right, or any other intellectual property rights in
 * or to any products. NXP Semiconductors reserves the right to make changes
 * in the software without notification. NXP Semiconductors also makes no
 * representation or warranty that such application will be suitable for the
 * specified use without further testing or modification.
 *
 * @par
 * Permission to use, copy, modify, and distribute this software and its
 * documentation is hereby granted, under NXP Semiconductors' and its
 * licensor's relevant copyrights in the software, without fee, provided that it
 * is used in conjunction with NXP Semiconductors microcontrollers.  This
 * copyright, permission, and disclaimer notice must appear in all copies of
 * this code.
 */
#define HID_INPUT_REPORT_BYTES       64				/* size of report in Bytes */
#define HID_OUTPUT_REPORT_BYTES      64			/* size of report in Bytes */
#define HID_FEATURE_REPORT_BYTES     64				/* size of report in Bytes */

//#include "board.h"
//#include <stdint.h>
#include <string.h>
#include "usbd_rom_api.h"

/*****************************************************************************
 * Private types/enumerations/variables
 ****************************************************************************/



/* Buffer to hold report data */
static uint8_t *loopback_report;

/*****************************************************************************
 * Public types/enumerations/variables
 ****************************************************************************/

extern const uint8_t HID_ReportDescriptor[];
extern const uint16_t HID_ReportDescSize;

/*****************************************************************************
 * Private functions
 ****************************************************************************/

/*  HID get report callback function. */
static ErrorCode_t HID_GetReport(USBD_HANDLE_T hHid, USB_SETUP_PACKET *pSetup, uint8_t * *pBuffer, uint16_t *plength)
{
// 	switch (pSetup->wValue.WB.H) {
// 	case HID_REPORT_INPUT:
// 		*pBuffer[0] = *loopback_report;
// 		*plength = HID_OUTPUT_REPORT_BYTES; //1
// 		break;

// 	case HID_REPORT_OUTPUT:
// 		return ERR_USBD_STALL;			/* Not Supported */

// 	case HID_REPORT_FEATURE:
// 		*pBuffer[0] = *loopback_report;
// 		*plength = 64; //HID_OUTPUT_REPORT_BYTES; //1		
// 		break;
// //		return ERR_USBD_STALL;			/* Not Supported */
// 	}
// 	
	return LPC_OK;
}

/* HID set report callback function. */
static ErrorCode_t HID_SetReport(USBD_HANDLE_T hHid, USB_SETUP_PACKET *pSetup, uint8_t * *pBuffer, uint16_t length)
{
	
// 	if (length == 0) {
// 		return LPC_OK;
// 	}

// 	/* ReportID = SetupPacket.wValue.WB.L; */
// 	switch (pSetup->wValue.WB.H) {//HID_SetReport
// 	case HID_REPORT_INPUT:
// 		return ERR_USBD_STALL;			/* Not Supported */
// 	
// 	case HID_REPORT_FEATURE:
// 		*loopback_report = **pBuffer;
// 		break;

// 	case HID_REPORT_OUTPUT:
// 		*loopback_report = **pBuffer;
// 		break;

// 	
// //		return ERR_USBD_STALL;			/* Not Supported */
// 	}

	return LPC_OK;
}

/* HID Interrupt endpoint event handler. */
static ErrorCode_t HID_Ep_Hdlr(USBD_HANDLE_T hUsb, void *data, uint32_t event)
{
	USB_HID_CTRL_T *pHidCtrl = (USB_HID_CTRL_T *) data;//HID_Ep_Hdlr
	unsigned int report_pending = 0;

	switch (event) {
	case USB_EVT_IN:
		report_pending = 0;
		break;

	case USB_EVT_OUT_NAK:
		USBD_API->hw->ReadReqEP(hUsb, pHidCtrl->epout_adr, loopback_report, HID_OUTPUT_REPORT_BYTES);
		break;

	case USB_EVT_OUT:
		USBD_API->hw->ReadEP(hUsb, pHidCtrl->epout_adr, loopback_report);
		if (!report_pending) {
			report_pending = 1;
			USBD_API->hw->WriteEP(hUsb, pHidCtrl->epin_adr, loopback_report, HID_OUTPUT_REPORT_BYTES);
		}
		break;
	}	
	return LPC_OK;
}

/*****************************************************************************
 * Public functions
 ****************************************************************************/

////////////////////////////////////////////////////////////////////////////////////
typedef enum {
    REQ_NO_REQ,
    REQ_CTRL_READ,
    REQ_CTRL_WRITE,
    REQ_NO_DATA_CTRL,
} REQ_NUM_T;
static REQ_NUM_T req_num = REQ_NO_REQ;


ErrorCode_t CustHID_ep0_hdlr(USBD_HANDLE_T hUsb, void* data, uint32_t event)
{
	 USB_CORE_CTRL_T* pCtrl = (USB_CORE_CTRL_T*)hUsb;
  ErrorCode_t ret = ERR_USBD_UNHANDLED;

  if (pCtrl->SetupPacket.bmRequestType.BM.Type == REQUEST_CLASS) 
		{
			switch (event) 
			{
           case USB_EVT_SETUP:
						 
						 //Set Output Report
						 if 
								 ( (pCtrl->SetupPacket.bRequest == 0x09) &&
									 (pCtrl->SetupPacket.wValue.W == (0x02)<<8)
									)
							 {
								
								pCtrl->EP0Data.pData = &loopback_report[0];
								pCtrl->EP0Data.Count = HID_OUTPUT_REPORT_BYTES;	
								req_num = REQ_CTRL_WRITE;
                 return LPC_OK;
							 }
					 
						//Get Input Report
						 if 
								 ( (pCtrl->SetupPacket.bRequest == 0x01) &&
										(pCtrl->SetupPacket.wValue.W == (0x01)<<8)
								)
							 {
								 pCtrl->EP0Data.pData = &loopback_report[0];
								 pCtrl->EP0Data.Count = HID_INPUT_REPORT_BYTES;	
								 USBD_API->core->DataInStage(hUsb);
								 req_num = REQ_CTRL_READ;
                 return LPC_OK;
							 }
							 
						 //Get_Feature
               if 													 
							 ( (pCtrl->SetupPacket.bRequest == 0x01) &&
										(pCtrl->SetupPacket.wValue.W == (0x03)<<8)
								)
							 
							 {				
								 pCtrl->EP0Data.pData = &loopback_report[0];
								 pCtrl->EP0Data.Count = HID_FEATURE_REPORT_BYTES;	
								 USBD_API->core->DataInStage(hUsb);
								 req_num = REQ_CTRL_READ;
                 return LPC_OK;
               }
							 
							  //Set_Feature
							 if //CustHID_ep0_hdlr
							  ( (pCtrl->SetupPacket.bRequest == 0x09) &&
										(pCtrl->SetupPacket.wValue.W == (0x03)<<8)
								)
							 {
								 pCtrl->EP0Data.pData = &loopback_report[0];
								 pCtrl->EP0Data.Count = HID_FEATURE_REPORT_BYTES;	
								 req_num = REQ_CTRL_WRITE;
                 return LPC_OK;
               }
							 
					  case USB_EVT_OUT:
            if ( req_num == REQ_CTRL_WRITE ) 
						{
                if (pCtrl->EP0Data.Count) 
								{             // still data to receive ?
                }//CustHID_ep0_hdlr
                else
							{        // data complete ?
                  //
                  // process data on the buffer, here
                  //
                  USBD_API->core->StatusInStage( hUsb );
                  req_num = REQ_NO_REQ;
                }
							
                return LPC_OK;
            }
            break;
						
						case USB_EVT_IN:
            if ( req_num == REQ_CTRL_READ ) {
			
                if ( pCtrl->EP0Data.Count ) {
                    USBD_API->core->DataInStage( hUsb );
                } else {
                    req_num = REQ_NO_REQ;
                }
								 
                return LPC_OK;
            }
            break;

        default:
            break;
		 }
		} 
  return ret;

}
////////////////////////////////////////////////////////////////////////////////////


/* HID init routine */
ErrorCode_t usb_hid_init(USBD_HANDLE_T hUsb,
						 USB_INTERFACE_DESCRIPTOR *pIntfDesc,
						 uint32_t *mem_base,
						 uint32_t *mem_size)
{
	USBD_HID_INIT_PARAM_T hid_param;
	USB_HID_REPORT_T reports_data[1];
	ErrorCode_t ret = LPC_OK;

		 /* register ep0 handler */
  USBD_API->core->RegisterClassHandler(hUsb, CustHID_ep0_hdlr, NULL);
	memset((void *) &hid_param, 0, sizeof(USBD_HID_INIT_PARAM_T));
	/* HID paramas */
	hid_param.max_reports = 1;
	/* Init reports_data */
	reports_data[0].len = HID_ReportDescSize;
	reports_data[0].idle_time = 0;
	reports_data[0].desc = (uint8_t *) &HID_ReportDescriptor[0];

	if ((pIntfDesc == 0) || (pIntfDesc->bInterfaceClass != USB_DEVICE_CLASS_HUMAN_INTERFACE)) {
		return ERR_FAILED;
	}

	hid_param.mem_base = *mem_base;
	/**< Base memory location from where the stack can allocate
                      data and buffers. \note The memory address set in this field
                      should be accessible by USB DMA controller. Also this value
                      should be aligned on 2048 byte boundary.
                      */
	//#define USB_STACK_MEM_BASE      0x20000000 = 536870912 Bytes = 512 MB
	hid_param.mem_size = *mem_size;
	/**< The size of memory buffer which stack can use. 
                      \note The \em mem_size should be greater than the size 
                      returned by USBD_HW_API::GetMemSize() routine.*/
	//#define USB_STACK_MEM_SIZE      0x00002000 = 8192 Bytes = 8 KB
	hid_param.intf_desc = (uint8_t *) pIntfDesc;
	/* user defined functions */
	hid_param.HID_GetReport = HID_GetReport;
	hid_param.HID_SetReport = HID_SetReport;
	hid_param.HID_EpIn_Hdlr  = HID_Ep_Hdlr;
	hid_param.HID_EpOut_Hdlr = HID_Ep_Hdlr;
	hid_param.report_data  = reports_data;

	ret = USBD_API->hid->init(hUsb, &hid_param);
	
	/* allocate USB accessable memory space for report data */
	loopback_report =  (uint8_t *) hid_param.mem_base;
	
	hid_param.mem_base += 4;
	hid_param.mem_size += 4;
	
	/* update memory variables */
	*mem_base = hid_param.mem_base;
	*mem_size = hid_param.mem_size;
	return ret;
}
