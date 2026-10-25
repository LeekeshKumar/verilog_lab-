vlog file_hand.v
vsim tb
#add wave -r sim:/tb/*
#add wave -position insertpoint sim:/tb/*
run -all
