RUNNING = 1;
halt = 0;
data_bus_disable = 0;
tsc = 0;

// TODO: Make reset work without clock!
CLOCK_RUNNING = 1;
reset = 1; #10 reset = 0;
CLOCK_RUNNING = 0;

// TEST INSTRUCTION 0x01 (NOP)
CURRENT_TEST_NAME = "NOP";
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h01;
CLOCK_RUNNING = 1;
// Wait for the first instruction to be read.
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h0001);
CLOCK_RUNNING = 0;

// TEST INSTRUCTION 0x06 (TAP)
CURRENT_TEST_NAME = "TAP";
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h06;
my_awesome_6800_test.my_awesome_6800_inst.accumulator_a = 16'h33;
my_awesome_6800_test.my_awesome_6800_inst.condition_code_register = 16'hFF;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h0001);
assert (my_awesome_6800_test.my_awesome_6800_inst.condition_code_register == 8'h33);
CLOCK_RUNNING = 0;

// TEST INSTRUCTION 0x07 (TPA)
CURRENT_TEST_NAME = "TPA";
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h07;
my_awesome_6800_test.my_awesome_6800_inst.accumulator_a = 16'h33;
my_awesome_6800_test.my_awesome_6800_inst.condition_code_register = 16'hFF;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h0001);
assert (my_awesome_6800_test.my_awesome_6800_inst.accumulator_a == 8'hFF);
CLOCK_RUNNING = 0;

// TEST INSTRUCTION 0x08 (INX)
CURRENT_TEST_NAME = "INX";
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h08;
my_awesome_6800_test.my_awesome_6800_inst.index_register = 16'hA55A;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h0001);
assert (my_awesome_6800_test.my_awesome_6800_inst.index_register == 16'hA55B);
CLOCK_RUNNING = 0;
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h08;
my_awesome_6800_test.my_awesome_6800_inst.index_register = 16'hFFFF;
my_awesome_6800_test.my_awesome_6800_inst.condition_code_register = 16'h11;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h0001);
assert (my_awesome_6800_test.my_awesome_6800_inst.index_register == 16'h0000);
assert (my_awesome_6800_test.my_awesome_6800_inst.condition_code_register == 16'h15);
CLOCK_RUNNING = 0;

// TEST INSTRUCTION 0x09 (DEX)
CURRENT_TEST_NAME = "DEX";
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h09;
my_awesome_6800_test.my_awesome_6800_inst.index_register = 16'hA55A;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h0001);
assert (my_awesome_6800_test.my_awesome_6800_inst.index_register == 16'hA559);
CLOCK_RUNNING = 0;
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h09;
my_awesome_6800_test.my_awesome_6800_inst.index_register = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.condition_code_register = 16'h15;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h0001);
assert (my_awesome_6800_test.my_awesome_6800_inst.index_register == 16'hFFFF);
assert (my_awesome_6800_test.my_awesome_6800_inst.condition_code_register == 16'h11);
CLOCK_RUNNING = 0;

// TEST INSTRUCTION 0x0A (CLV)
CURRENT_TEST_NAME = "CLV";
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h0A;
my_awesome_6800_test.my_awesome_6800_inst.condition_code_register = 16'h66;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h0001);
assert (my_awesome_6800_test.my_awesome_6800_inst.condition_code_register == 8'h64);
CLOCK_RUNNING = 0;

// TEST INSTRUCTION 0x6E (JMP data8,X)
CURRENT_TEST_NAME = "JMP data8,X";
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h6E;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_1 = 8'h81;
my_awesome_6800_test.my_awesome_6800_inst.index_register = 16'h1313;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h1394);
CLOCK_RUNNING = 0;

// TEST INSTRUCTION 0x7E (JMP addr16)
CURRENT_TEST_NAME = "JMP addr16";
my_awesome_6800_test.my_awesome_6800_inst.program_counter = 16'h0000;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_0 = 8'h7E;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_1 = 8'h5A;
my_awesome_6800_test.my_awesome_6800_inst.instruction_byte_2 = 8'hA5;
my_awesome_6800_test.my_awesome_6800_inst.instruction_stage = 9;
CLOCK_RUNNING = 1;
wait (my_awesome_6800_test.my_awesome_6800_inst.instruction_stage == 10);
assert (my_awesome_6800_test.my_awesome_6800_inst.program_counter == 16'h5AA5);
CLOCK_RUNNING = 0;

// INTEGRATION TEST 1 - Test that we can make an infinite loop w/ JMP addr16
CURRENT_TEST_NAME = "infinite_loop_1 - JMP addr16";
CLOCK_RUNNING = 1;
// Pulse the reset line
reset = 1; #10 reset = 0;
// Wait for the first instruction to be read.
wait (CURRENT_CYCLE == 2);
assert (address_bus == 8'h00);
assert (data_bus_register == 8'h01);
// Wait for the second instruction to be read.
wait (CURRENT_CYCLE == 2 + 14);
assert (address_bus == 8'h01);
assert (data_bus_register == 8'h7E);
// Test that it loops back around
wait (CURRENT_CYCLE == 2 + 14 * 2);
assert (address_bus == 8'h00);
assert (data_bus_register == 8'h01);
wait (CURRENT_CYCLE == 2 + 14 * 3);
assert (address_bus == 8'h01);
assert (data_bus_register == 8'h7E);
CLOCK_RUNNING = 0;

// INTEGRATION TEST 2 - Test that we can make an infinite loop w/ INX and JMP data8,X
CURRENT_TEST_NAME = "infinite_loop_2 - JMP data8,X";
CLOCK_RUNNING = 1;
// Pulse the reset line
reset = 1; #10 reset = 0;

wait (CURRENT_CYCLE == 2);
assert (address_bus == 8'h00);
assert (data_bus_register == 8'h08);

wait (CURRENT_CYCLE == 2 + 14);
assert (address_bus == 8'h01);
assert (data_bus_register == 8'h01);

wait (CURRENT_CYCLE == 2 + 14 * 2);
assert (address_bus == 8'h02);
assert (data_bus_register == 8'h01);

wait (CURRENT_CYCLE == 2 + 14 * 3);
assert (address_bus == 8'h03);
assert (data_bus_register == 8'h01);

wait (CURRENT_CYCLE == 2 + 14 * 4);
assert (address_bus == 8'h04);
assert (data_bus_register == 8'h6E);

wait (CURRENT_CYCLE == 2 + 14 * 5);
assert (address_bus == 8'h02);
assert (data_bus_register == 8'h01);

CLOCK_RUNNING = 0;

// Done with all tests.
RUNNING = 0;
