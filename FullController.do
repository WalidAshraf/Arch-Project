vsim -gui work.controller(mycontroller)
add wave -position insertpoint  \
sim:/controller/ALSU_S0 \
sim:/controller/ALSU_S1 \
sim:/controller/ALSU_S2 \
sim:/controller/ALSU_S3 \
sim:/controller/src_enA \
sim:/controller/src_enB \
sim:/controller/dst_en \
sim:/controller/IR_enC \
sim:/controller/IR_A_Out \
sim:/controller/cin \
sim:/controller/busA \
sim:/controller/busB \
sim:/controller/busC \
sim:/controller/clk \
sim:/controller/GenReg/regQs \
sim:/controller/src \
sim:/controller/dst \
sim:/controller/IR_Q \
sim:/controller/Cout \
sim:/controller/Offset
force -freeze sim:/controller/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/controller/mem_clk 0 0, 1 {50 ns} -r 100
force -freeze sim:/controller/ALSU_S0 0 0
force -freeze sim:/controller/ALSU_S1 0 0
force -freeze sim:/controller/ALSU_S2 0 0
force -freeze sim:/controller/ALSU_S3 0 0
force -freeze sim:/controller/cin 0 0
force -freeze sim:/controller/busA 16'h1111 0
force -freeze sim:/controller/busB 16'h2222 0
run

run

force -freeze sim:/controller/cin 1 0
run
force -freeze sim:/controller/ALSU_S3 1 0
run
force -freeze sim:/controller/ALSU_S3 0 0
force -freeze sim:/controller/ALSU_S0 1 0
run
force -freeze sim:/controller/cin 0 0
run
force -freeze sim:/controller/ALSU_S0 0 0
force -freeze sim:/controller/ALSU_S1 1 0
force -freeze sim:/controller/ALSU_S2 1 0
force -freeze sim:/controller/ALSU_S3 1 0
run
force -freeze sim:/controller/ALSU_S1 0 0
force -freeze sim:/controller/ALSU_S0 1 0
run
force -freeze sim:/controller/ALSU_S0 0 0
force -freeze sim:/controller/ALSU_S3 0 0
run

force -freeze sim:/controller/busC 16'h0008 0
force -freeze sim:/controller/dst_en 1 0
force -freeze sim:/controller/dst 3'h7 0
force -freeze sim:/controller/src_enB 0 0
run

force -freeze sim:/controller/IR_enC 1 0
force -freeze sim:/controller/busC 16'h7208 0
run 50

force -freeze sim:/controller/dst_en 0 0
run 100

noforce sim:/controller/busA
noforce sim:/controller/busB
noforce sim:/controller/busC
force -freeze sim:/controller/src 3'h7 0
force -freeze sim:/controller/src_enB 1 0
force -freeze sim:/controller/IR_A_Out 1 0
force -freeze sim:/controller/dst_en 1 0
force -freeze sim:/controller/ALSU_S0 1 0
force -freeze sim:/controller/ALSU_S1 0 0
force -freeze sim:/controller/ALSU_S2 0 0
force -freeze sim:/controller/ALSU_S3 0 0
force -freeze sim:/controller/dst 3'h7 0
run 50

#force -freeze sim:/controller/src_enB 0 0
#force -freeze sim:/controller/src_enA 0 0
#run 10

#noforce sim:/controller/busA
#noforce sim:/controller/busB
noforce sim:/controller/busC
#force -freeze sim:/controller/src_enB 0 0
force -freeze sim:/controller/cin 0 0
force -freeze sim:/controller/IR_enC 0 0
#force -freeze sim:/controller/src 3'h7 0
#force -freeze sim:/controller/dst 3'h7 0
#force -freeze sim:/controller/src_enB 1 0
#force -freeze sim:/controller/dst_en 1 0
run 100