RUNNING = 1;
halt = 0;

// TEST 1 - JMP addr16 - Test that we can make an infinite loop
CURRENT_TEST_NAME = "JMP addr16";
CLOCK_RUNNING = 1;
// Pulse the reset line
reset = 1; #30 reset = 0;
// Wait for the first instruction to be read.
wait (CURRENT_CYCLE == 8'h02);
assert (address_bus == 8'h00);
assert (data_bus_register == 8'h01);
// Wait for the second instruction to be read.
wait (CURRENT_CYCLE == 8'h10);
assert (address_bus == 8'h01);
assert (data_bus_register == 8'h7E);
// Test that it loops back around
wait (CURRENT_CYCLE == 8'h1E);
assert (address_bus == 8'h00);
assert (data_bus_register == 8'h01);
CLOCK_RUNNING = 0;

// Done with all tests.
RUNNING = 0;
