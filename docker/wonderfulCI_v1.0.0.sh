#!/bin/bash
################################################################################
BASE_VERSION=1.0.0
VIVADO_VERSION=2018.2
MODELSIM_VERSION=1.0.0
GHDL_VERSION=1.0.0
################################################################################
BASE_DIR=$PWD/base
VIVADO_DIR=$PWD/vivado
MODELSIM_DIR=$PWD/modelsim
GHDL_DIR=$PWD/ghdl-gcc
################################################################################
cd $BASE_DIR; ./build_${BASE_VERSION}.sh
cd $VIVADO_DIR; ./build_${VIVADO_VERSION}.sh
cd $MODELSIM_DIR; ./build_${MODELSIM_VERSION}.sh
cd $GHDL_DIR; ./build_${GHDL_VERSION}.sh
