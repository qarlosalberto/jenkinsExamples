################################################################################
BASE_VERSION=1.0.0
################################################################################
XILINX_PATH=/opt/Xilinx
VIVADO_VERSION=2019.2
VIVADO_TAR_FILE=Xilinx_Vivado_2019.2_1106_2127
################################################################################
docker build --build-arg BASE_VERSION=$BASE_VERSION \
             --build-arg XILINX_PATH=$XILINX_PATH \
             --build-arg VIVADO_VERSION=$VIVADO_VERSION \
             --build-arg VIVADO_TAR_FILE=$VIVADO_TAR_FILE \
              -t vivado:$VIVADO_VERSION .
