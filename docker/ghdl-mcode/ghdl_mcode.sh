################################################################################
export GHDL_VERSION=0.36
export GCC_VERSION=7.4.0
################################################################################
sudo apt install -y gnat gcc g++ make zlib1g-dev git wget libgmp3-dev libmpfr-dev
################################################################################
cd /tmp
wget https://github.com/ghdl/ghdl/archive/v$GHDL_VERSION.tar.gz
tar xzf v$GHDL_VERSION.tar.gz; rm v$GHDL_VERSION.tar.gz; mv ghdl-$GHDL_VERSION/ ghdl
################################################################################
cd /tmp/ghdl
mkdir build; cd build
../configure
make -j8
sudo make install
rm -rf /tmp/ghdl
################################################################################
