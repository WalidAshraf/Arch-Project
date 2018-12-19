vsim work.RomController
add wave -position insertpoint  \
sim:/romcontroller/Instruction \
sim:/romcontroller/CarryFlag \
sim:/romcontroller/ZeroFlag \
sim:/romcontroller/MicroPC \
sim:/romcontroller/NextMicroPC \
sim:/romcontroller/ROMDecoder/RdstinC \
sim:/romcontroller/BranchCond/Result \
sim:/romcontroller/Clock 

mem load -i {C:/Users/Owner/GitHubRepos/ArchProject/Arch-Project/RomBits.mem} /romcontroller/ROM/ROM
#Label1: ADD R1,@(R2)+
force -freeze sim:/romcontroller/CarryFlag 0 0
force -freeze sim:/romcontroller/ZeroFlag 1 0
force -freeze sim:/romcontroller/Instruction 16'h106A 0
run 600

#MOV @X(R1),-(R6)
force -freeze sim:/romcontroller/Instruction 16'hE56 0
run 700

#CMP (R1)+,R2
force -freeze sim:/romcontroller/Instruction 16'hE242 0
run 700

#NoOp
force -freeze sim:/romcontroller/Instruction 16'h7100 0
run 200

#BR Label2
force -freeze sim:/romcontroller/Instruction 16'h73FB 0
run 300

#BEQ Label2
force -freeze sim:/romcontroller/Instruction 16'h7BFA 0
run 200

#BNE Label2 
force -freeze sim:/romcontroller/Instruction 16'h79F9 0
run 300

#BHS Label2
force -freeze sim:/romcontroller/CarryFlag 1 0
force -freeze sim:/romcontroller/ZeroFlag 0 0
force -freeze sim:/romcontroller/Instruction 16'h7FF8 0
run 400

#BLS Label2 
force -freeze sim:/romcontroller/Instruction 16'h7DF7 0
run 400