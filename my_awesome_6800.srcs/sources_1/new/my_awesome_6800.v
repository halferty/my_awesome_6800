`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 			Edward Halferty
//
// Create Date:    	06:25:17 05/24/2018
// Design Name:
// Module Name:    	my_awesome_6800
// Project Name:
// Target Devices:
// Tool versions:
// Description:		MyAwesome6800 - A CPU in Verilog which can run Motorola
//					MC6800 instructions. This is not meant to be an accurate
//					re-implementation of a MC6800, but instead is meant to be a
//					simple 6800 that 6800 ISA fans can use intheir designs. Some
//					differences from the MC6800: Active-low inputs are now
//					active-high. R//W has been split into two outputs (read and
//					write). Timing is not followed, all instructions takes 14(!)
//					clock cycles.
//
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module my_awesome_6800(
	input	clock,					// Clock input
	inout	[7:0] data_bus,			// Data bus I/O
	output	[15:0] address_bus,		// Address bus output
	input	data_bus_disable,		// Data bus disable input - will pause CPU
									// if trying to write.
	output	bus_available,			// Bus available output
	output	read,					// Read output
	output	write,					// Write output
	input	reset,					// Reset input
	input	irq,					// Interrupt request input
	input	nmi,					// Non-maskable interrups request input
	input	tsc,					// Tri-state input
	input	halt					// Halt input
	);

	reg [7:0]	accumulator_a;
	reg [7:0]	accumulator_b;
	reg [15:0]	index_register;
	reg [15:0]	program_counter;
	reg [7:0]	stack_pointer;
	reg [7:0]	condition_code_register;

	reg read_register;
	reg write_register;
	reg bus_available_register;
	reg [15:0] address_bus_register;
	reg [7:0] data_bus_register;

	assign read = read_register;
	assign write = write_register;
	assign bus_available = bus_available_register;
	assign address_bus = address_bus_register;
	assign data_bus = data_bus_register;

	// CPU stages:
	//  0: Setup bus to read addr=program_counter
	//  1: Do nothing.
	//  2: Latch in result.
	//  3: Setup bus to read addr=program_counter+1
	//  4: Do nothing.
	//  5: Latch in result.
	//  6: Setup bus to read addr=program_counter+2
	//  7: Do nothing.
	//  8: Latch in result.
	//  9: Deassert output lines. Execute.
	// 10: Optionally setup bus to read/write data
	// 11: Do nothing
	// 12: Latch in result.
	// 13: Execute, Increment program counter, cleanup.

	reg [3:0]	instruction_stage = 0;
	reg			will_write;
	reg			will_read;
	reg [8:0]	data_to_write;
	reg [15:0]	address_to_read_or_write;
	reg [8:0]	read_result;

	reg [8:0]	instruction_byte_0;
	reg [8:0]	instruction_byte_1;
	reg [8:0]	instruction_byte_2;

	always @(posedge clock) begin
		if (reset) begin
			accumulator_a <= 0;
			accumulator_b <= 0;
			index_register <= 0;
			program_counter <= 0;
			stack_pointer <= 0;
			condition_code_register <= 0;
			bus_available_register <= 0;
			instruction_stage <= 0;
		end
		if (!halt && !reset) begin
			case (instruction_stage)
				0: begin
					// Setup bus to read addr=program_counter
					read_register <= 1;
					address_bus_register <= program_counter;
					instruction_stage <= instruction_stage + 1;
				end
				1: begin
					// Do nothing.
					instruction_stage <= instruction_stage + 1;
				end
				2: begin
					// Latch in result
					instruction_byte_0 <= data_bus;
					instruction_stage <= instruction_stage + 1;
				end
				3: begin
					// Setup bus to read addr=program_counter+1
					address_bus_register <= program_counter + 1;
					instruction_stage <= instruction_stage + 1;
				end
				4: begin
					// Do nothing.
					instruction_stage <= instruction_stage + 1;
				end
				5: begin
					// Latch in result
					instruction_byte_1 <= data_bus;
					instruction_stage <= instruction_stage + 1;
				end
				6: begin
					// Setup bus to read addr=program_counter+1
					address_bus_register <= program_counter + 2;
					instruction_stage <= instruction_stage + 1;
				end
				7: begin
					// Do nothing.
					instruction_stage <= instruction_stage + 1;
				end
				8: begin
					// Latch in result.
					instruction_byte_2 <= data_bus;
					instruction_stage <= instruction_stage + 1;
				end
				9: begin
					$display("instruction bytes: %H %H %H", instruction_byte_0, instruction_byte_1, instruction_byte_2);
					// Deassert output lines. Execute.
					address_bus_register <= 16'hBEEF;
					read_register <= 0;
					// TODO: Now run this...
					// For testing, just assume that everything is a NOP and
					// we just want to continue on to the next byte.
					case (instruction_byte_0)
						8'h7E: begin
							// JMP addr16
							program_counter <= (instruction_byte_1 << 8) & instruction_byte_2;
							$display("JMP addr16");
						end
						8'h01: begin
							program_counter <= program_counter + 1;
							$display("NOP");
						end
						default: begin
							program_counter <= program_counter + 1;
						end
					endcase
					instruction_stage <= instruction_stage + 1;
				end
				10: begin
					// Optionally setup bus to read/write data
					if (will_write) begin
						if (data_bus_disable) begin
							// Stall CPU since we're waiting for bus
							instruction_stage <= instruction_stage;
						end
						else begin
							write_register <= 1;
							address_bus_register <= address_to_read_or_write;
							data_bus_register <= data_to_write;
							instruction_stage <= instruction_stage + 1;
						end
					end
					else if (will_read) begin
						read_register <= 1;
						address_bus_register <= address_to_read_or_write;
						instruction_stage <= instruction_stage + 1;
					end
					else begin
						instruction_stage <= instruction_stage + 1;
					end
				end
				11: begin
					// Do nothing
					instruction_stage <= instruction_stage + 1;
				end
				12: begin
					// Latch in result.
					read_result <= data_bus;
					instruction_stage <= instruction_stage + 1;
				end
				13: begin
					// Execute, Increment program counter, cleanup.
					// TODO: Finish executing after read.
					read_register <= 0;
					write_register <= 0;
					data_bus_register <= 8'bZ;
					address_bus_register <= 16'hBEEF;
					bus_available_register <= 0;
					instruction_stage <= 0;
				end
				default: $display("Error");
			endcase
		end
	end

endmodule
