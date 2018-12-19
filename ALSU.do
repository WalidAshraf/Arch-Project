vsim work.ALSU
add wave -position insertpoint  \
sim:/ALSU/A \
sim:/ALSU/B \
sim:/ALSU/S0 \
sim:/ALSU/S1 \
sim:/ALSU/S2 \
sim:/ALSU/S3 \
sim:/ALSU/cin \
sim:/ALSU/F \
sim:/ALSU/cout
# Part A
force -freeze sim:/ALSU/S2 0 0
force -freeze sim:/ALSU/S3 0 0
force -freeze sim:/ALSU/A 0F0F 0
force -freeze sim:/ALSU/B 0000 0
force -freeze sim:/ALSU/cin 0 0
force -freeze sim:/ALSU/S0 0 0
force -freeze sim:/ALSU/S1 0 0
run

force -freeze sim:/ALSU/B 0001 0
force -freeze sim:/ALSU/S0 1 0
run

force -freeze sim:/ALSU/A FFFF 0
run

force -freeze sim:/ALSU/S0 0 0
force -freeze sim:/ALSU/S1 1 0
run

force -freeze sim:/ALSU/B 0000 0
run

force -freeze sim:/ALSU/A 0F0E 0
force -freeze sim:/ALSU/S0 1 0
force -freeze sim:/ALSU/S1 0 0
force -freeze sim:/ALSU/cin 1 0
run

force -freeze sim:/ALSU/A FFFF 0
force -freeze sim:/ALSU/B 0001 0
force -freeze sim:/ALSU/cin 1 0
run

force -freeze sim:/ALSU/A 0F0F 0
force -freeze sim:/ALSU/S0 0 0
force -freeze sim:/ALSU/S1 1 0
run

force -freeze sim:/ALSU/A 0000 0
force -freeze sim:/ALSU/B 0000 0
force -freeze sim:/ALSU/S0 1 0
run

# Part B
force -freeze sim:/ALSU/S2 1 0
force -freeze sim:/ALSU/S3 0 0
force -freeze sim:/ALSU/A 0F0F 0
force -freeze sim:/ALSU/B 000A 0
force -freeze sim:/ALSU/S0 0 0
force -freeze sim:/ALSU/S1 0 0
run
force -freeze sim:/ALSU/S0 1 0
force -freeze sim:/ALSU/S1 0 0
run
force -freeze sim:/ALSU/S0 0 0
force -freeze sim:/ALSU/S1 1 0
run
force -freeze sim:/ALSU/S0 1 0
force -freeze sim:/ALSU/S1 1 0
run

# Part C
force -freeze sim:/ALSU/S2 0 0
force -freeze sim:/ALSU/S3 1 0
force -freeze sim:/ALSU/A 0F0F 0
force -freeze sim:/ALSU/Cin 0 0
force -freeze sim:/ALSU/S0 0 0
force -freeze sim:/ALSU/S1 0 0
run
force -freeze sim:/ALSU/S0 1 0
run

force -freeze sim:/ALSU/S2 1 0
force -freeze sim:/ALSU/S3 1 0
force -freeze sim:/ALSU/S1 1 0
force -freeze sim:/ALSU/S0 1 0
run

force -freeze sim:/ALSU/S2 0 0
force -freeze sim:/ALSU/S3 1 0
force -freeze sim:/ALSU/S1 1 0
force -freeze sim:/ALSU/S0 0 0
run
force -freeze sim:/ALSU/Cin 1 0
run


# Part D
force -freeze sim:/ALSU/S2 1 0
force -freeze sim:/ALSU/S3 1 0
force -freeze sim:/ALSU/A 0F0F 0
force -freeze sim:/ALSU/Cin 0 0
force -freeze sim:/ALSU/S0 0 0
force -freeze sim:/ALSU/S1 0 0
run
force -freeze sim:/ALSU/A F0F0 0
force -freeze sim:/ALSU/S0 1 0
run
force -freeze sim:/ALSU/S0 0 0
force -freeze sim:/ALSU/S1 1 0
run
force -freeze sim:/ALSU/Cin 1 0
run
force -freeze sim:/ALSU/S2 0 0
force -freeze sim:/ALSU/S3 1 0
force -freeze sim:/ALSU/A F0F0 0
force -freeze sim:/ALSU/S1 1 0
force -freeze sim:/ALSU/S0 1 0
force -freeze sim:/ALSU/Cin 1 0
run