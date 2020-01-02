#!/bin/bash
################################################################################
# Arguments:
#   - 0: VUnit version. Example: 4.2.0
#   - 1: CoCotb version. Example: 1.2.0
################################################################################
VUNIT_VERSION=$1
COCOTB_VERSION=$2
################################################################################
sudo apt install -y python3-pip python-pip sudo
sudo pip3 install pytest vunit_hdl==${VUNIT_VERSION} numpy matplotlib cocotb==${COCOTB_VERSION} cocotb-test edalize
