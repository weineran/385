/*---------------------------------------------------------------------------
  --      usb.c                                                    	   --
  --      Christine Chen                                                   --
  --      Ref. DE2-115 Demonstrations by Terasic Technologies Inc.         --
  --      Fall 2014                                                        --
  --                                                                       --
  --      For use with ECE 298 Experiment 7                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/

#include "usb.h"

#include "system.h"
#include "alt_types.h"
#include <unistd.h>  // usleep
#include <stdio.h>
#include <io.h>

#include "cy7c67200.h"
#include "lcp_cmd.h"
#include "lcp_data.h"

//#define CY7C67200_0_BASE CY7C67200_IF_0_BASE

//-------------USB operation sub function-----------
/*****************************************************************************/
/**
 *
 * This function writes data to the internal registers of the Cypress
 * CY7C67200 USB controller.
 *
 * @param    Address is the address of the register.
 * @param    Data is the data to be written to the register.
 *
 * @return   None
 *
 * @note     None
 *
 ******************************************************************************/
void UsbWrite(alt_u16 Address, alt_u16 Data)
{
	//XIo_Out16(USB_ADDRESS, Address);
	IOWR(CY7C67200_BASE,HPI_ADDR,Address);
	//usleep(10);

	//XIo_Out16(USB_DATA, Data);
	IOWR(CY7C67200_BASE,HPI_DATA,Data);
}

/*****************************************************************************/
/**
 *
 * This function reads data from the internal registers of the Cypress
 * CY7C67200 USB controller.
 *
 * @param    Address is the address of the register.
 *
 * @return   The data read from the specified address
 *
 * @note     None
 *
 ******************************************************************************/
alt_u16 UsbRead(alt_u16 Address)
{
	//XIo_Out16(HPI_ADDR, Address);
	IOWR(CY7C67200_BASE,HPI_ADDR,Address);
	//usleep(20);
	return IORD(CY7C67200_BASE,HPI_DATA);
}


/*****************************************************************************/
/**
 *
 * This function does a software reset of the Cypress CY7C67200 USB controller.
 *
 * @param    UsbBaseAddress is the starting location of the USB internal memory
 *           to which this bin file data is written.
 *
 * @return   None
 *
 * @note     None
 *
 ******************************************************************************/
void UsbSoftReset()
{
	//XIo_Out16(USB_MAILBOX, COMM_RESET);
	IOWR(CY7C67200_BASE,HPI_MAILBOX,COMM_RESET); //COMM_JUMP2CODE
	usleep(100000);
	printf("[USB INIT]:reset finished!\n");

	usleep(500000);
	printf("[USB INIT]:Clear up the interrupt\r\n");
	IORD(CY7C67200_BASE,HPI_MAILBOX);
	IORD(CY7C67200_BASE,HPI_STATUS);

	// Had to add the write due to a bug in BIOS where they overwrite
	// the mailbox after initialization with garbage.  The read clears
	// any pending interrupts.
	UsbRead (HPI_SIE1_MSG_ADR);
	UsbWrite (HPI_SIE1_MSG_ADR, 0);
	UsbRead (HPI_SIE2_MSG_ADR);
	UsbWrite (HPI_SIE2_MSG_ADR, 0);

	UsbWrite (HOST1_STAT_REG, 0xFFFF);
	UsbWrite (HOST2_STAT_REG, 0xFFFF);
}


void UsbSetAddress()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	// TD #1: 6 writes
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	// TASK: Complete with 4 more IOWR functions

	// TD #2: 4 writes
	// TASK: Complete with 4 IOWR functions
	
	// TD #3: 6 writes
	// TASK: Complete with 6 IOWR functions

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}


void UsbGetDeviceDesc1()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0514);

	//td content 4 bytes
	IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0100); //device 0x01
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);

	//data phase IN
	IOWR(CY7C67200_BASE,HPI_DATA,0x052C); //
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0520);

	//    //status phase
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}

void UsbGetDeviceDesc2()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0514);

	//td content 4 bytes
	IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0100);//e //device 0x01
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0012);//2

	//data phase IN-1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e

	//data phase IN-2
	IOWR(CY7C67200_BASE,HPI_DATA,0x054c); //520
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a

	//data phase IN-3
	IOWR(CY7C67200_BASE,HPI_DATA,0x0554); //c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0002);//e
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6

	//status phase
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //538
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//e
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//2

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}


void UsbGetConfigDesc1()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0514);

	//td content 4 bytes
	IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0200);//e //config 0x02
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0009);//2

	//data phase IN-1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e

	//data phase IN-2
	IOWR(CY7C67200_BASE,HPI_DATA,0x054c); //520
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a

	//status phase
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //52c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e
	IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//530
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}


void UsbGetConfigDesc2()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0514);

	//td content 4 bytes
	IOWR(CY7C67200_BASE,HPI_DATA,0x0680);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0200);//e //config 0x02
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
	IOWR(CY7C67200_BASE,HPI_DATA,0x00FF);//2

	//data phase IN-1
	IOWR(CY7C67200_BASE,HPI_DATA,0x055c); //514
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e

	//data phase IN-2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0564); //520
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a

	//data phase IN-3
	IOWR(CY7C67200_BASE,HPI_DATA,0x056c); //52c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6

	//data phase IN-4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0574); //538
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
	IOWR(CY7C67200_BASE,HPI_DATA,0x0544);//2

	//data phase IN-5
	IOWR(CY7C67200_BASE,HPI_DATA,0x057c); //544
	IOWR(CY7C67200_BASE,HPI_DATA,0x0002);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a //data1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0550);//e

	//status phase
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //550
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//a

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}

void UsbSetConfig()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //port address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0514);

	//td content 4 bytes
	IOWR(CY7C67200_BASE,HPI_DATA,0x0900);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
	//in packet
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041); //data 1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr

}

void UsbClassRequest()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //port address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0514);

	//td content 4 bytes
	IOWR(CY7C67200_BASE,HPI_DATA,0x0A21);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);
	//in packet
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //don't care
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//port number /data length
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041); //data 1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr
}


void UsbGetHidDesc()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //port address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0514);

	//td content 4 bytes
	IOWR(CY7C67200_BASE,HPI_DATA,0x0681);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x2100);//e //HID 0x21
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
	IOWR(CY7C67200_BASE,HPI_DATA,0x007B);//2

	//data phase IN-1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0544); //514
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e

	//status phase
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //52c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e
	IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//530
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr

}


void UsbGetReportDesc()
{
	//the starting address
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	IOWR(CY7C67200_BASE,HPI_DATA,0x050C);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008); //4 port number
	IOWR(CY7C67200_BASE,HPI_DATA,0x02D0); //device address
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);
	IOWR(CY7C67200_BASE,HPI_DATA,0x0514);

	//td content 4 bytes
	IOWR(CY7C67200_BASE,HPI_DATA,0x0681);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x2200);//e //report 0x22
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//0
	IOWR(CY7C67200_BASE,HPI_DATA,0x007B);//2

	//data phase IN-1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0580); //514
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0520);//e

	//data phase IN-2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0588); //520
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x052c);//a

	//data phase IN-3
	IOWR(CY7C67200_BASE,HPI_DATA,0x0590); //52c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//530
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0538);//6

	//data phase IN-4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0598); //538
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//540
	IOWR(CY7C67200_BASE,HPI_DATA,0x0544);//2

	//data phase IN-5
	IOWR(CY7C67200_BASE,HPI_DATA,0x05a0); //544
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a //data1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0550);//e

	//data phase IN-6
	IOWR(CY7C67200_BASE,HPI_DATA,0x05a8); //550
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//2
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//6 //data0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x055c);//a

	//data phase IN-7
	IOWR(CY7C67200_BASE,HPI_DATA,0x05b0); //c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0008);//e
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//560
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//2 //data1
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//4
	IOWR(CY7C67200_BASE,HPI_DATA,0x0568);//6

	//data phase IN-8
	IOWR(CY7C67200_BASE,HPI_DATA,0x05b8); //8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0003);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0290);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0001);//e //data0
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//570
	IOWR(CY7C67200_BASE,HPI_DATA,0x0574);//2

	//status phase
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000); //574
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//6
	IOWR(CY7C67200_BASE,HPI_DATA,0x0210);//8
	IOWR(CY7C67200_BASE,HPI_DATA,0x0041);//a
	IOWR(CY7C67200_BASE,HPI_DATA,0x0013);//c
	IOWR(CY7C67200_BASE,HPI_DATA,0x0000);//e

	UsbWrite(HUSB_SIE1_pCurrentTDPtr,0x0500); //HUSB_SIE1_pCurrentTDPtr

}


alt_u16 UsbWaitTDListDone()
{
	alt_u16 usb_ctl_val;

	usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR); // STEP 3 j
	UsbWrite(HPI_SIE1_MSG_ADR, 0);
	while (usb_ctl_val != HUSB_TDListDone)  // k, read sie1 msg register
	{
		if(usb_ctl_val == 0x0000)
		{
		}
		else
		{
			printf("[SIE1 MSG]:SIE1 msg reg is %x\n",usb_ctl_val);
		}
		usb_ctl_val = UsbRead(HPI_SIE1_MSG_ADR);
		UsbWrite(HPI_SIE1_MSG_ADR, 0);
	}

	return usb_ctl_val;
}


alt_u16 UsbGetRetryCnt()
{
	alt_u16 usb_ctl_val;

	IORD(CY7C67200_BASE,HPI_STATUS);
	if(UsbRead(HPI_SIE1_MSG_ADR) == HUSB_TDListDone)
	{
		UsbWrite(HPI_SIE1_MSG_ADR, 0);

		while (!(IORD(CY7C67200_BASE,HPI_STATUS) & HPI_STATUS_SIE1msg_FLAG) )  //read sie1 msg register
		{
		}
	}
	//usleep(1000);
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0508);
	usb_ctl_val = IORD(CY7C67200_BASE,HPI_DATA);

	return usb_ctl_val;
}


void UsbPrintMem()
{
	int i, code;
	IOWR(CY7C67200_BASE,HPI_ADDR,0x0500); //the start address
	for (i = 0; i <= 200; i += 2)
	{
		code = IORD(CY7C67200_BASE,HPI_DATA);
		printf("\naddr %x = %04x\n", 0x0500+i, code);
	}
}

