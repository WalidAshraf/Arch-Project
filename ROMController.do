vsim work.RomController
add wave -position insertpoint sim:/RomController/*

mem load -i {C:/Modeltech_pe_edu_10.4a/examples/Phase 2/room.mem} /romcontroller/R/ROM
#force -freeze sim:/RomController/MicroPC 5'b00001 0
run 100

#force -freeze sim:/RomController/MicroPC 5'b00010 0
run 100