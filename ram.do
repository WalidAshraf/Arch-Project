vsim work.ram
add wave -position insertpoint sim:/ram/*
#sim:/ram/addressBits \
#sim:/ram/wordSize 
#sim:/ram/clk \
#sim:/ram/we \
#sim:/ram/address \
#sim:/ram/datain \
#sim:/ram/dataout \
#sim:/ram/ram
mem load -i C:/Modeltech_pe_edu_10.4a/examples/ram.mem /ram/ram
force -freeze sim:/ram/we 0 0
force -freeze sim:/ram/datain 32'h0000000A 0
force -freeze sim:/ram/address 5'b00001 0
force -freeze sim:/ram/dataout 32'h00000000 0
force -freeze sim:/ram/clk 1 0, 0 {50 ns} -r 100
run

force -freeze sim:/ram/datain 32'h0000000B 0
force -freeze sim:/ram/address 5'b00010 0
run