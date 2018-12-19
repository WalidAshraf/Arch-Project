vsim -gui work.flagregister(dataflow)
add wave -position insertpoint  \
sim:/flagregister/ALU_A \
sim:/flagregister/ALU_B \
sim:/flagregister/ALU_OUT \
sim:/flagregister/Sel_Bits \
sim:/flagregister/ALU_BIT \
sim:/flagregister/carry \
sim:/flagregister/clK \
sim:/flagregister/rst \
sim:/flagregister/C \
sim:/flagregister/Z \
sim:/flagregister/N \
sim:/flagregister/P \
sim:/flagregister/O
force -freeze sim:/flagregister/ALU_A 0000 0
force -freeze sim:/flagregister/ALU_B 0000 0
force -freeze sim:/flagregister/ALU_Out 0000 0
force -freeze sim:/flagregister/Sel_Bits 0 0
force -freeze sim:/flagregister/carry 1 0
force -freeze sim:/flagregister/ALU_BIT 1 0
run 100
force -freeze sim:/flagregister/ALU_A 8000 0
force -freeze sim:/flagregister/ALU_B 8000 0
force -freeze sim:/flagregister/ALU_Out 0000 0
force -freeze sim:/flagregister/Sel_Bits 2 0
force -freeze sim:/flagregister/carry 1 0
run 100
force -freeze sim:/flagregister/ALU_A 8000 0
force -freeze sim:/flagregister/ALU_B 8000 0
force -freeze sim:/flagregister/ALU_Out 0000 0
force -freeze sim:/flagregister/Sel_Bits 1 0
force -freeze sim:/flagregister/carry 1 0
run 100
force -freeze sim:/flagregister/ALU_BIT 0 0
run 100

force -freeze sim:/flagregister/ALU_A 80f0 0
force -freeze sim:/flagregister/ALU_B 80f0 0
force -freeze sim:/flagregister/ALU_Out 00f0 0
force -freeze sim:/flagregister/Sel_Bits 1 0
force -freeze sim:/flagregister/carry 1 0
run 100

force -freeze sim:/flagregister/ALU_BIT 1 0
run 100

noforce sim:/flagregister/ALU_A
noforce sim:/flagregister/ALU_B
noforce sim:/flagregister/ALU_Out
force -freeze sim:/flagregister/ALU_BIT 0 0
run 100
