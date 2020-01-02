################################################################################
VIVADO_VERSION=2019.2
################################################################################
MODELSIM_PATH=/opt/modelsim/18.0
MODELSIM_INSTALL_FILE=ModelSimProSetup-18.0.0.219-linux.run
################################################################################
VIVADO_PATH=/opt/Xilinx/Vivado/2019.2
VIVADO_MODELSIM_LIBRARIES_PATH=/opt/libraries/vivado
################################################################################
UVVM_VERSION=2019.09.02
UVVM_MODELSIM_LIBRARIES_PATH=/opt/libraries/uvvm-modelsim
################################################################################
docker build --build-arg VIVADO_VERSION=$VIVADO_VERSION \
             --build-arg MODELSIM_PATH=$MODELSIM_PATH \
             --build-arg MODELSIM_INSTALL_FILE=$MODELSIM_INSTALL_FILE \
             --build-arg VIVADO_PATH=$VIVADO_PATH \
             --build-arg VIVADO_MODELSIM_LIBRARIES_PATH=$VIVADO_MODELSIM_LIBRARIES_PATH \
             --build-arg UVVM_VERSION=$UVVM_VERSION \
             --build-arg UVVM_MODELSIM_LIBRARIES_PATH=$UVVM_MODELSIM_LIBRARIES_PATH \
             -t modelsim:1.0.0 .
