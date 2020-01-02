#!/bin/bash
################################################################################
# Arguments:
#   - 0: GHDL version. Example: 0.36
#   - 1: gcc version. Example: 7.4.0
################################################################################
GHDL_VERSION=$1
GCC_VERSION=$2
################################################################################
sudo apt install -y gnat gcc g++ make zlib1g-dev git wget libgmp3-dev libmpfr-dev
################################################################################
cd /tmp
# Download
wget https://github.com/ghdl/ghdl/archive/v$GHDL_VERSION.tar.gz
wget https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz
tar xzf gcc-$GCC_VERSION.tar.gz; rm gcc-$GCC_VERSION.tar.gz; mv gcc-$GCC_VERSION/ gcc
tar xzf v$GHDL_VERSION.tar.gz; rm v$GHDL_VERSION.tar.gz; mv ghdl-$GHDL_VERSION/ ghdl
################################################################################
cd /tmp/ghdl
./configure --with-gcc=../gcc --prefix=/usr/local --enable-python
make copy-sources
################################################################################
cd /tmp/gcc
./contrib/download_prerequisites
mkdir gcc-objs; cd gcc-objs
../configure --prefix=/usr/local --enable-languages=c,vhdl,c++ --disable-bootstrap --disable-lto --disable-multilib --disable-libssp --disable-libgomp --disable-libquadmath
make -j8
sudo make install MAKEINFO=true
################################################################################
cd /tmp/ghdl
make ghdllib
sudo make install
make -C src/vhdl
make
sudo python setup.py install
################################################################################
