vsim work.RomController
add wave -position insertpoint  \
sim:/romcontroller/Instruction \
sim:/romcontroller/MicroPC \
sim:/romcontroller/NextMicroPC \
sim:/romcontroller/ROMDecoder/RdstinC \
sim:/romcontroller/Clock 


mem load -i {C:/Modeltech_pe_edu_10.4a/examples/Phase 2/RomBits.mem} /romcontroller/ROM/ROM
#INC @5(R7)
force -freeze sim:/romcontroller/Carry 0 0
force -freeze sim:/romcontroller/Zero 1 0
force -freeze sim:/romcontroller/Instruction 16'hF43F 0
run 600