VIVADO_PATH=/fpga/Xilinx/Vivado
MODELSIM_PATH=/fpga/modelsim

CURRENT_PATH=$PWD

cd $CURRENT_PATH/../docker/ghdl-gcc
./install_ghdl_gcc.sh 0.36 7.4.0
./ghdl_uvvm_libraries.sh 2019.09.02 /fpga/libraries/uvvm-ghdl
