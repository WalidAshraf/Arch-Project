vsim -gui work.regfile
add wave -position insertpoint  \
sim:/regfile/my_busA \
sim:/regfile/my_busB \
sim:/regfile/my_busC \
sim:/regfile/dst_en \
sim:/regfile/src_enA \
sim:/regfile/src_enB \
sim:/regfile/src_en \
sim:/regfile/rst \
sim:/regfile/clk \
sim:/regfile/src \
sim:/regfile/dst \
sim:/regfile/regDs \
sim:/regfile/regQs \
sim:/regfile/dec_src \
sim:/regfile/dec_dst \
sim:/regfile/dst_en \
sim:/regfile/tempA \
sim:/regfile/tempB
force -freeze sim:/regfile/clk 0 0, 1 {50 ns} -r 100
force -freeze sim:/regfile/rst 1 0
force -freeze sim:/regfile/dst_en 0 0
force -freeze sim:/regfile/src_enA 0 0
force -freeze sim:/regfile/src_enB 0 0
run 50

#Moving 44H into R3
force -freeze sim:/regfile/rst 0 0
force -freeze sim:/regfile/my_busC 0000044 0
force -freeze sim:/regfile/dst_en 1 0
force -freeze sim:/regfile/dst 2'h3 0
run 150

#Moving 33H into R2
force -freeze sim:/regfile/my_busC 0000033 0
force -freeze sim:/regfile/dst_en 1 0
force -freeze sim:/regfile/dst 2'h2 0
run 100

#Moving 22H into R2
force -freeze sim:/regfile/my_busC 0000022 0
force -freeze sim:/regfile/dst_en 1 0
force -freeze sim:/regfile/dst 2'h1 0
run 100

#Moving 11H into R2
force -freeze sim:/regfile/my_busC 0000011 0
force -freeze sim:/regfile/dst_en 1 0
force -freeze sim:/regfile/dst 2'h0 0
run 100

#Outputting the value in R1 to bus A
force -freeze sim:/regfile/dst_en 0 0
force -freeze sim:/regfile/src_enA 1 0
force -freeze sim:/regfile/src 2'h1 0
run 100

#Outputting on both busses
force -freeze sim:/regfile/src_enB 1 0
run 100

#Outputting the value in R3 to bus B only
force -freeze sim:/regfile/src 2'h3 0
force -freeze sim:/regfile/src_enB 1 0
force -freeze sim:/regfile/src_enA 0 0
run 100