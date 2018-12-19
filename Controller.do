vsim -gui work.controller

add wave -position insertpoint  \
sim:/Controller/my_bus \
sim:/Controller/clk \
sim:/Controller/mem_clk \
sim:/Controller/MAR_en \
sim:/Controller/MDR_en \
sim:/Controller/MDR_out \
sim:/Controller/MDR_Q \
sim:/Controller/MDR_D \
sim:/Controller/MAR_Q \
sim:/Controller/dataout \
sim:/Controller/src_en \
sim:/Controller/dst_en \
sim:/Controller/src \
sim:/Controller/dst \
sim:/Controller/we 
mem load -i C:/Modeltech_pe_edu_10.4a/examples/ram2.mem /controller/MEM/ram
force -freeze sim:/Controller/src_en 0 0
force -freeze sim:/Controller/dst_en 0 0
force -freeze sim:/Controller/rst 1 0
force -freeze sim:/Controller/clk 0 0, 1 {50 ns} -r 100
force -freeze sim:/Controller/mem_clk 1 0, 0 {50 ns} -r 100
noforce sim:/Controller/my_bus
force -freeze sim:/Controller/we 0 0
run

#Moving 7777h into R3
force -freeze sim:/Controller/my_bus 7777 0
force -freeze sim:/Controller/rst 0 0
force -freeze sim:/Controller/dst_en 1 0
force -freeze sim:/Controller/dst 2'h3 0
force -freeze sim:/Controller/src_en 0 0
run

#Moving 9889h into R0
force -freeze sim:/Controller/my_bus 9889 0
force -freeze sim:/Controller/rst 0 0
force -freeze sim:/Controller/dst_en 1 0
force -freeze sim:/Controller/dst 2'h0 0
force -freeze sim:/Controller/src_en 0 0
run

#Load address 0008 to the MAR
force -freeze sim:/Controller/dst_en 0 0
force -freeze sim:/Controller/my_bus 0008 0
force -freeze sim:/Controller/MAR_en 1 0
run
#In order for mem_clk to turn on and proper value loads into MDR 
force -freeze sim:/Controller/MAR_en 0 0
force -freeze sim:/Controller/MDR_en 1 0
run

run -next
#Prepare to move data into R1
noforce sim:/Controller/my_bus
force -freeze sim:/Controller/MDR_out 1 0
force -freeze sim:/Controller/dst_en 1 0
force -freeze sim:/Controller/src_en 0 0
force -freeze sim:/Controller/dst 2'h1 0
run -next
run -next

#Moving value from R3 to MDR and writing it to memory location 0008 (value inside MAR)
force -freeze sim:/Controller/we 1 0
force -freeze sim:/Controller/MDR_out 0 0
force -freeze sim:/Controller/MDR_en 1 0
force -freeze sim:/Controller/dst_en 0 0
force -freeze sim:/Controller/src 2'h3 0
force -freeze sim:/Controller/src_en 1 0
noforce sim:/Controller/my_bus
run
#run -next

#Loading 0001 into MAR
force -freeze sim:/Controller/we 0 0
force -freeze sim:/Controller/MDR_en 0 0
force -freeze sim:/Controller/src_en 0 0
force -freeze sim:/Controller/my_bus 0001 0
force -freeze sim:/Controller/MAR_en 1 0
run
force -freeze sim:/Controller/MAR_en 0 0
force -freeze sim:/Controller/MDR_en 1 0
run

#Load address 0008 to the MAR
force -freeze sim:/Controller/my_bus 0008 0
force -freeze sim:/Controller/MAR_en 1 0
run
#In order for mem_clk to turn on and proper value loads into MDR 
force -freeze sim:/Controller/MAR_en 0 0
force -freeze sim:/Controller/MDR_en 1 0
run 200