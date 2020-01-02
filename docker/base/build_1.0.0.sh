#!/bin/bash
################################################################################
VERSION=1.0.0
################################################################################
UBUNTU_VERSION=18.04
VUNIT_VERSION=4.2.0
COCOTB_VERSION=1.2.0
################################################################################
docker build --build-arg UBUNTU_VERSION=$UBUNTU_VERSION \
             --build-arg VUNIT_VERSION=$VUNIT_VERSION \
             --build-arg COCOTB_VERSION=$COCOTB_VERSION \
              -t base:$VERSION .
