RUNNING = 1;
halt = 0;
data_bus_disable = 0;
tsc = 0;

// TEST 1 - JMP addr16 - Test that we can make an infinite loop
CURRENT_TEST_NAME = "JMP addr16";
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

// TEST 2 - INX and JMP data8, X - Test that we can increment Index Register (X), and jump to data8+X
CURRENT_TEST_NAME = "JMP data8,X";
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
