if (CURRENT_TEST_NAME == "JMP addr16") begin
	if (address_bus == 8'h00) begin
		data_bus_register = 8'h01; // NOP
	end
	else if (address_bus == 8'h01) begin
		data_bus_register = 8'h7E; // JMP addr16
	end
	else if (address_bus == 8'h02 || address_bus == 8'h03) begin
		data_bus_register = 8'h00; // 0x00, 0x00
	end
	else
	begin
		data_bus_register = 8'hZ;
	end
end
else if (CURRENT_TEST_NAME == "JMP data8,X") begin
	if (address_bus == 8'h00) begin
		data_bus_register = 8'h08; // INX
	end
	if (address_bus == 8'h01) begin
		data_bus_register = 8'h01; // NOP
	end
	if (address_bus == 8'h02) begin
		data_bus_register = 8'h01; // NOP
	end
	else if (address_bus == 8'h03) begin
		data_bus_register = 8'h01; // NOP
	end
	else if (address_bus == 8'h04) begin
		data_bus_register = 8'h6E; // JMP data8,X
	end
	else if (address_bus == 8'h05) begin
		data_bus_register = 8'h01; // 0x01
	end
end
