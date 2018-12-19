vsim -gui work.newromaddress
add wave -position insertpoint  \
sim:/newromaddress/branchType  \
sim:/newromaddress/modeSRC \
sim:/newromaddress/modeDST \
sim:/newromaddress/instructionType \
sim:/newromaddress/srcIndirect \
sim:/newromaddress/dstIndirect \
sim:/newromaddress/twoOp \
sim:/newromaddress/oneOp \
sim:/newromaddress/branch \
sim:/newromaddress/noOp \
sim:/newromaddress/cmp \
sim:/newromaddress/mov \
sim:/newromaddress/result \
sim:/newromaddress/b8 \
sim:/newromaddress/newAddress \
sim:/newromaddress/address \
sim:/newromaddress/all_mode \
sim:/newromaddress/all_indirect


force -freeze sim:/newromaddress/b8 1 0
force -freeze sim:/newromaddress/result 1 0
force -freeze sim:/newromaddress/instructionType 2'h0 0
force -freeze sim:/newromaddress/modeSRC 2'h1 0
force -freeze sim:/newromaddress/modeDST 2'h1 0
force -freeze sim:/newromaddress/address 6'h8 0
force -freeze sim:/newromaddress/branchType 3'h2 0
force -freeze sim:/newromaddress/mov 1 0
force -freeze sim:/newromaddress/cmp 0 0
force -freeze sim:/newromaddress/twoOp 1 0
force -freeze sim:/newromaddress/oneOp 0 0
force -freeze sim:/newromaddress/branch 0 0
force -freeze sim:/newromaddress/noOp 0 0
force -freeze sim:/newromaddress/dstIndirect 1 0
force -freeze sim:/newromaddress/srcIndirect 0 0
force -freeze sim:/newromaddress/modeDST 2'h1 0
run 100