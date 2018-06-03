module my_awesome_6800_test;
	bit RUNNING;
	bit CLOCK_RUNNING;
	string CURRENT_TEST_NAME;
	reg [31:0] CURRENT_CYCLE;
	reg clock;
	wire [7:0] data_bus;
	reg [15:0] address_bus;
	reg data_bus_disable;
	reg reset;
	reg irq;
	reg nmi;
	reg tsc;
	reg halt;
	wire bus_available;
	wire read;
	wire write;
	reg [7:0] data_bus_register = 8'hZ;
	my_awesome_6800 my_awesome_6800_inst(
		.clock(clock),
		.data_bus(data_bus),
		.address_bus(address_bus),
		.data_bus_disable(data_bus_disable),
		.bus_available(bus_available),
		.read(read),
		.write(write),
		.reset(reset),
		.irq(irq),
		.nmi(nmi),
		.tsc(tsc),
		.halt(halt)
		);

	assign data_bus = read ? data_bus_register : 8'hZ;

	// Run tests
	initial begin
		`include "tests.sv"
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars(1);
	end

	// Run the clock
	initial begin
		while (RUNNING && CLOCK_RUNNING) begin
			#1 clock = 1;
			#1 clock = 0;
		end
	end

	// Virtual ROM for testing
	always @(clock) begin
		if (RUNNING && CLOCK_RUNNING && read) begin
			`include "virtual_rom_for_tests.sv"
		end
	end

	// Keep a running count of the number of clock cycles since reset.
	always @(negedge reset) begin
		CURRENT_CYCLE <= 0;
	end
	always @(posedge clock) begin
		if (!reset) begin
			CURRENT_CYCLE <= CURRENT_CYCLE + 1;
			$display("accumulator_a=%x", my_awesome_6800_test.my_awesome_6800_inst.accumulator_a);
		end
		else
		begin
			CURRENT_CYCLE <= 0;
		end
	end

endmodule
