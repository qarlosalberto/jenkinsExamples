#!/bin/bash
################################################################################
# Arguments:
#   - 0: UVVM version. Example: 2019.09.02
#   - 1: Libraries output. Example: /opt/libraries/uvvm-ghdl
################################################################################
UVVM_VERSION=$1
UVVM_GHDL_LIBRARIES_PATH=$2
################################################################################
echo "*************************************************************************"
echo " GHDL UVVM LIBRARIES"
echo "*************************************************************************"
cd /tmp
wget https://github.com/UVVM/UVVM/archive/v$UVVM_VERSION.tar.gz
tar xzf v$UVVM_VERSION.tar.gz; rm v$UVVM_VERSION.tar.gz; mv UVVM-$UVVM_VERSION/ UVVM
################################################################################
sudo mkdir -p $UVVM_GHDL_LIBRARIES_PATH
bash /usr/local/lib/ghdl/vendors/compile-uvvm.sh --all \
     --src /tmp/UVVM --out $UVVM_GHDL_LIBRARIES_PATH
################################################################################
sudo chmod +r+w -R $UVVM_GHDL_LIBRARIES_PATH
echo 'export GHDL_UVVM_LIBRARIES_PATH='$UVVM_GHDL_LIBRARIES_PATH >> sudo /etc/bash.bashrc
sudo rm -rf /tmp/UVVM
