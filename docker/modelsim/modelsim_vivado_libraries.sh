#!/bin/bash
################################################################################
# Arguments:
#   - 0: Vivado installation path.
#   - 1: ModelSim installation path.
#   - 2: Output libraries.
################################################################################
VIVADO_PATH=$1
MODELSIM_PATH=$2
VIVADO_MODELSIM_LIBRARIES_PATH=$3
VIVADO_BIN=$VIVADO_PATH/bin/vivado
MODELSIM_PATH_BIN=$MODELSIM_PATH/modelsim_ase/linuxaloem
################################################################################
echo "*************************************************************************"
echo " MODELSIM VIVADO LIBRARIES"
echo "*************************************************************************"
################################################################################
source /etc/bash.bashrc
sudo mkdir -p $VIVADO_MODELSIM_LIBRARIES_PATH
sudo chmod -R 777 $VIVADO_MODELSIM_LIBRARIES_PATH
SIMULATOR=modelsim
LANGUAGE=all
LIBRARY=all
FAMILY=all
TCL_FILE=vivado.tcl

CURRENT_PATH=/tmp
cd $CURRENT_PATH
echo "compile_simlib -force -simulator_exec_path $MODELSIM_PATH_BIN -library $LIBRARY -family $FAMILY -language $LANGUAGE -simulator $SIMULATOR -directory $VIVADO_MODELSIM_LIBRARIES_PATH -32bit -verbose -quiet" > $TCL_FILE
if [ $? -ne 0 ]; then
  echo 1>&2 -e "${COLORED_ERROR} Cannot create temporary tcl script.${ANSI_NOCOLOR}"
  exit -1;
fi
echo "exit" >> $TCL_FILE

# compile common libraries
$VIVADO_BIN -mode tcl -source $TCL_FILE
if [ $? -ne 0 ]; then
  echo 1>&2 -e "${COLORED_ERROR} Error while compiling Xilinx Vivado libraries.${ANSI_NOCOLOR}"
  exit -1;
fi
sudo chmod +r+w -R $VIVADO_MODELSIM_LIBRARIES_PATH
echo 'export MODELSIM_VIVADO_LIBRARIES_PATH='$VIVADO_MODELSIM_LIBRARIES_PATH | sudo tee -a /etc/bash.bashrc
