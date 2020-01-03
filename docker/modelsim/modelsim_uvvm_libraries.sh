#!/bin/bash
################################################################################
# Arguments:
#   - 0: UVVM version. Example: 2019.09.02
#   - 1: Libraries output. Example: /opt/libraries/uvvm-modelsim
#   - 2: ModelSim installation path. Example:
################################################################################
UVVM_VERSION=$1
UVVM_MODELSIM_LIBRARIES_PATH=$2
MODELSIM_PATH=$3
MODELSIM=$MODELSIM_PATH/modelsim_ase/linuxaloem/vsim
################################################################################
echo "*************************************************************************"
echo " MODELSIM UVVM LIBRARIES"
echo "*************************************************************************"
################################################################################
CURRENT_PATH=/tmp
cd $CURRENT_PATH
wget https://github.com/UVVM/UVVM/archive/v$UVVM_VERSION.tar.gz
tar xzf v$UVVM_VERSION.tar.gz; rm v$UVVM_VERSION.tar.gz; mv UVVM-$UVVM_VERSION/ UVVM
################################################################################
sudo mkdir -p $UVVM_MODELSIM_LIBRARIES_PATH
sudo chmod -R 777 $UVVM_MODELSIM_LIBRARIES_PATH
declare -a modules=("uvvm_util" "uvvm_vvc_framework" "bitvis_vip_scoreboard" \
                    "bitvis_vip_avalon_mm" "bitvis_vip_axilite" "bitvis_vip_axistream" \
                    "bitvis_vip_clock_generator" "bitvis_vip_gpio" "bitvis_vip_i2c" \
                    "bitvis_vip_sbi" "bitvis_vip_spi" "bitvis_vip_uart" \
                    "bitvis_vip_error_injection" \
                    )

for i in "${modules[@]}"
do
  printf "\n***************************************************************\n"
  printf "\++++++++++++++ $i\n"
  printf "***************************************************************\n"
  cd $CURRENT_PATH/UVVM/$i/script
  printf "\nexit\n" >> compile_src.do
  $MODELSIM -do compile_src.do -batch
  sudo cp -R $CURRENT_PATH/UVVM/$i/sim/$i $UVVM_MODELSIM_LIBRARIES_PATH
done
sudo chmod +r+w -R $UVVM_MODELSIM_LIBRARIES_PATH
echo 'export MODELSIM_UVVM_LIBRARIES_PATH='$UVVM_MODELSIM_LIBRARIES_PATH | sudo tee -a /etc/bash.bashrc
sudo rm -rf $CURRENT_PATH/UVVM
