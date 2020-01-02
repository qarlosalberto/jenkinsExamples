#!/bin/bash
################################################################################
VERSION=1.0.0
################################################################################
BASE=base:1.0.0
GHDL_VERSION=0.36
GCC_VERSION=7.4.0
################################################################################
UVVM_VERSION=2019.09.02
UVVM_MODELSIM_LIBRARIES_PATH=/opt/libraries/uvvm-ghdl
################################################################################
docker build --build-arg BASE=$BASE \
             --build-arg GHDL_VERSION=$GHDL_VERSION \
             --build-arg GCC_VERSION=$GCC_VERSION \
             --build-arg UVVM_VERSION=$UVVM_VERSION \
             --build-arg UVVM_MODELSIM_LIBRARIES_PATH=$UVVM_MODELSIM_LIBRARIES_PATH \
              -t ghdl-gcc:$VERSION .
