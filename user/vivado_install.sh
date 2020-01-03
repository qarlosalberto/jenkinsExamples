VIVADO_PATH=/fpga/Xilinx/Vivado
MODELSIM_PATH=/fpga/modelsim

CURRENT_PATH=$PWD

cd $CURRENT_PATH/../docker/vivado
./config_vivado_2018.2.sh $VIVADO_PATH
./vivado.sh $VIVADO_PATH 2018.2 Xilinx_Vivado_SDK_2018.2_0614_1954 user
