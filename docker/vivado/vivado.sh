#!/bin/bash
################################################################################
# Arguments:
#   - 0: Xilinx path. Example: /opt/Xilinx
#   - 1: Vivado version. Example: 2019.2
#   - 2: Vivado installation file. Example: Xilinx_Vivado_2019.2_1106_2127
################################################################################
XILINX_PATH=$1
VIVADO_VERSION=$2
VIVADO_TAR_FILE=$3
################################################################################
sudo apt install -y libglib2.0-0 libsm6 libxi6 libxrender1 libxrandr2 libfreetype6 libfontconfig git
################################################################################
cd /tmp
echo "Extracting Vivado tar file"
tar xzf ./${VIVADO_TAR_FILE}.tar.gz
sudo ./${VIVADO_TAR_FILE}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config ./install_config.txt
rm -rf /tmp/${VIVADO_TAR_FILE}*
sudo apt-get clean
# echo 'source '$XILINX_PATH'/Vivado/'$VIVADO_VERSION'/settings64.sh' >> /root/.bashrc
echo 'source '$XILINX_PATH'/Vivado/'$VIVADO_VERSION'/settings64.sh' >> sudo /etc/bash.bashrc
