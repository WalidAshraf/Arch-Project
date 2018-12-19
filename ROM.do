vsim work.rom
add wave -position insertpoint sim:/rom/*
#sim:/rom/addressBits \
#sim:/rom/wordSize 
#sim:/rom/address \
#sim:/rom/dataout \
#sim:/rom/rom
mem load -i {C:/Modeltech_pe_edu_10.4a/examples/Phase 2/ROM.mem} /rom/ROM
force -freeze sim:/rom/address 6'h00 0
force -freeze sim:/rom/dataout 32'h00000000 0
run 100

force -freeze sim:/rom/address 000001 0
run 100

force -freeze sim:/rom/address 6'h05 0
run 100