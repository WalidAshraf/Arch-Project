vsim -gui work.decodingcircuit
add wave -position insertpoint sim:/decodingcircuit/*

# BR Label1
force -freeze sim:/decodingcircuit/Instruction 0111001000000111 0
run 100

# BEQ Label1
force -freeze sim:/decodingcircuit/Instruction 0111101000000110 0
run 100

# BNE Label1
force -freeze sim:/decodingcircuit/Instruction 0111100000000101 0
run 100

# BLO Label1
force -freeze sim:/decodingcircuit/Instruction 0111010000000100 0
run 100

# BLS Label1
force -freeze sim:/decodingcircuit/Instruction 0111110000000011 0
run 100

# BHI Label1
force -freeze sim:/decodingcircuit/Instruction 0111011000000010 0
run 100

# BHS Label1
force -freeze sim:/decodingcircuit/Instruction 0111111000000001 0
run 100

# MOV R1,R2
force -freeze sim:/decodingcircuit/Instruction 0000000001000010 0
run 100

# Label1: ADD R1,@(R2)+
force -freeze sim:/decodingcircuit/Instruction 0001000001101010 0
run 100

# ADC R1,R2
force -freeze sim:/decodingcircuit/Instruction 1001000001000010 0
run 100

# SUB R1,R2
force -freeze sim:/decodingcircuit/Instruction 1010000001000010 0
run 100

# SBC R1,R2
force -freeze sim:/decodingcircuit/Instruction 0010000001000010 0
run 100

# AND R1,R2
force -freeze sim:/decodingcircuit/Instruction 0100000001000010 0
run 100

# OR R1,R2
force -freeze sim:/decodingcircuit/Instruction 0101000001000010 0
run 100

# XNOR R1,R2
force -freeze sim:/decodingcircuit/Instruction 0110000001000010 0
run 100

# CMP R1,R2
force -freeze sim:/decodingcircuit/Instruction 1110000001000010 0
run 100

# INC R1
force -freeze sim:/decodingcircuit/Instruction 1111010000000001 0
run 100

# DEC R1
force -freeze sim:/decodingcircuit/Instruction 1111000011000001 0
run 100

# INV R1
force -freeze sim:/decodingcircuit/Instruction 1111000111000001 0
run 100

# LSR R1
force -freeze sim:/decodingcircuit/Instruction 1111001000000001 0
run 100

# ROR R1
force -freeze sim:/decodingcircuit/Instruction 1111001001000001 0
run 100

# RRC R1
force -freeze sim:/decodingcircuit/Instruction 1111101010000001 0
run 100

# ASR R1
force -freeze sim:/decodingcircuit/Instruction 1111001011000001 0
run 100

# LSL R1
force -freeze sim:/decodingcircuit/Instruction 1111001100000001 0
run 100

# ROL R1
force -freeze sim:/decodingcircuit/Instruction 1111001101000001 0
run 100

# RLC R1
force -freeze sim:/decodingcircuit/Instruction 1111101110000001 0
run 100

# CLR R1
force -freeze sim:/decodingcircuit/Instruction 1111001111000001 0
run 100

# HLT
force -freeze sim:/decodingcircuit/Instruction 0111000000000000 0
run 100

# NOP
force -freeze sim:/decodingcircuit/Instruction 0111000100000000 0
run 100

