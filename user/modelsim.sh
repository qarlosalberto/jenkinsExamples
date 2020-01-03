VIVADO_PATH=/fpga/Xilinx/Vivado
MODELSIM_PATH=/fpga/modelsim

CURRENT_PATH=$PWD

cd $CURRENT_PATH/../docker/modelsim
./modelsim_install.sh $MODELSIM_PATH ModelSimProSetup-18.0.0.219-linux.run user
./modelsim_uvvm_libraries.sh 2019.09.02 /fpga/libraries/uvvm-modelsim $MODELSIM_PATH
./modelsim_vivado_libraries.sh ${VIVADO_PATH}/2018.2 $MODELSIM_PATH /fpga/libraries/vivado-modelsim
