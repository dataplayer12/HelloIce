yosys -p "read_verilog $1.v" $1 $@
#read_verilog $1
yosys -p "hierarchy -check";
yosys -p "proc";
yosys -p "opt";
yosys -p "show $1";