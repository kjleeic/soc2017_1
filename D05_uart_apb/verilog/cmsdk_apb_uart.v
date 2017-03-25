//------------------------------------------------------------------------------
// Abstract : Simple APB UART
//------------------------------------------------------------------------------
// Programmer's model
// 0x00 R     RXD[7:0]    Received Data
//      W     TXD[7:0]    Transmit data
// 0x04 RW    STAT[3:0]
//              [3] RX buffer overrun (write 1 to clear)
//              [2] TX buffer overrun (write 1 to clear)
//              [1] RX buffer full (Read only)
//              [0] TX buffer full (Read only)
// 0x08 RW    CTRL[3:0]   TxIntEn, RxIntEn, TxEn, RxEn
//              [6] High speed test mode Enable
//              [5] RX overrun interrupt enable
//              [4] TX overrun interrupt enable
//              [3] RX Interrupt Enable
//              [2] TX Interrupt Enable
//              [1] RX Enable
//              [0] TX Enable
// 0x0C R/Wc  intr_status/INTCLEAR
//              [3] RX overrun interrupt
//              [2] TX overrun interrupt
//              [1] RX interrupt
//              [0] TX interrupt
// 0x10 RW    BAUDDIV[19:0] Baud divider
//            (minimum value is 16)
//-------------------------------------
`timescale 1ns/1ps

module cmsdk_apb_uart (
// --------------------------------------------------------------------------
// Port Definitions
// --------------------------------------------------------------------------
  input  wire        PCLK,     // Clock
  input  wire        PRESETn,  // Reset

  input  wire        PSEL,     // Device select
  input  wire [11:2] PADDR,    // Address
  input  wire        PENABLE,  // Transfer control
  input  wire        PWRITE,   // Write control
  input  wire [31:0] PWDATA,   // Write data
  output wire [31:0] PRDATA,   // Read data
  output wire        PREADY,   // Device ready

  input  wire        RXD,      // Serial input
  output wire        TXD,      // Transmit data output
  output wire        TXEN      // Transmit enabled
);


	// By KJLEE
	localparam ADDR_BAUD		= 10'd4;
	localparam ADDR_CTRL		= 10'd2;
	localparam ADDR_DATA		= 10'd0;
	
	localparam DO_WRITE		= 1'b1;
	localparam DO_READ		= 1'b0;
	
	localparam REG_ENABLE	= 1'b1;
	localparam REG_DISABLE	= 1'b0;
	
	reg	[7:0]		REG_DATA_R;
	reg	[7:0]		REG_DATA_T;
	
	reg	[6:0]		REG_CTRL;
	
	reg	[19:0]	REG_BAUDDIV;
	
	wire	output_;
	
	assign output_ = {PRDATA, PREADY, TXD, TXEN};
	
	always@ (posedge PCLK)
	begin
		casex ({PADDR, PWRITE, PSEL, PENABLE})
		//	[PADDR]			[PWRITE]		[PSEL]	[PENABLE]	:					[PRDATA]			[PREADY]	[TXD]			
			{ADDR_BAUD,		DO_WRITE,	1'bx,		REG_ENABLE}	: output_ <=	{31'b0,			1'b1,		};
			{ADDR_BAUD,		DO_WRITE,	1'bx,		REG_DISABLE}: output_ <=	{31'b0,			1'b0,		};
			{ADDR_BAUD,		DO_READ,		1'bx,		REG_ENABLE}	: output_ <=	{REG_BAUDDIV,	1'b1,		};
			{ADDR_BAUD,		DO_READ,		1'bx,		REG_DISABLE}: output_ <=	{31b'x,			1'b0};
	
		endcase
	end




endmodule
