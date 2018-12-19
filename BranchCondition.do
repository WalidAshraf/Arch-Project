vsim -gui work.branchcondition(dataflow)
add wave -position insertpoint sim:/BranchCondition/*

force -freeze sim:/BranchCondition/Zero 1 0
force -freeze sim:/BranchCondition/Carry 0 0
#br
force -freeze sim:/BranchCondition/Instruction 0111001000000000 0
run 100

#blo
force -freeze sim:/BranchCondition/Carry 0 0
force -freeze sim:/BranchCondition/Instruction 0111010000000000 0
run 100

force -freeze sim:/BranchCondition/Carry 1 0
run 100

#bhi
force -freeze sim:/BranchCondition/Carry 0 0
force -freeze sim:/BranchCondition/Instruction 0111011000000000 0
run 100

force -freeze sim:/BranchCondition/Carry 1 0
run 100

#bne
force -freeze sim:/BranchCondition/Zero 0 0
force -freeze sim:/BranchCondition/Instruction 0111100000000000 0
run 100

force -freeze sim:/BranchCondition/Zero 1 0
run 100

#beq
force -freeze sim:/BranchCondition/Zero 0 0
force -freeze sim:/BranchCondition/Instruction 0111101000000000 0
run 100

force -freeze sim:/BranchCondition/Zero 1 0
run 100

force -freeze sim:/BranchCondition/Carry 0 0, 1 {50 ns} -r 100
force -freeze sim:/BranchCondition/Zero 0 0, 1 {100 ns} -r 200

#bls
force -freeze sim:/BranchCondition/Instruction 0111110000000000 0
run 200

#bhs
force -freeze sim:/BranchCondition/Instruction 0111111000000000 0
run 200
