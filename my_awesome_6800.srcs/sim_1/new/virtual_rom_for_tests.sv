if (CURRENT_TEST_NAME == "JMP addr16") begin
	if (address_bus == 8'h00) begin
		data_bus_register <= 8'h01;
	end
	else if (address_bus == 8'h01) begin
		data_bus_register <= 8'h7E;
	end
	else if (address_bus == 8'h02 || address_bus == 8'h03) begin
		data_bus_register <= 8'h00;
	end
	else
	begin
		data_bus_register <= 8'hZ;
	end
end
