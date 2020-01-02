#!/bin/bash
################################################################################
# Arguments:
#   - 0: ModelSim installation path.
#   - 1: ModelSim installation file.
################################################################################
MODELSIM_PATH=$1
MODELSIM_INSTALL_FILE=$2
################################################################################
echo "*************************************************************************"
echo " MODELSIM INSTALLATION"
echo "*************************************************************************"
################################################################################
sudo apt install -y gnat gcc g++ make zlib1g-dev git wget libgmp3-dev libmpfr-dev
################################################################################
echo "+++++++++++ Installing ModelSim..."
chmod +x $MODELSIM_INSTALL_FILE
sudo ./$MODELSIM_INSTALL_FILE --unattendedmodeui none --mode unattended \
                                        --installdir $MODELSIM_PATH --accept_eula 1 \
                                        --modelsim_edition modelsim_ase &
sleep 3m
rm -rf /tmp/$MODELSIM_INSTALL_FILE

echo "+++++++++++ Installing 32-bits libraries..."
dpkg --add-architecture i386
sudo apt-get -qq update
sudo apt-get install -y libxft2 lib32ncurses5 libxft2:i386 libxext6:i386

cd $MODELSIM_PATH/modelsim_ase
sudo ln -s linuxaloem linuxpe
sudo ln -s linuxaloem linux_x86_64pe
sudo chmod +r+w -R $MODELSIM_PATH

echo 'export VUNIT_MODELSIM_INI='$MODELSIM_PATH'/modelsim_ase/modelsim.ini' >> sudo /etc/bash.bashrc
echo 'export VUNIT_MODELSIM_PATH='$MODELSIM_PATH'/modelsim_ase/linuxaloem' >> sudo /etc/bash.bashrc
echo 'PATH=$PATH:'$MODELSIM_PATH'/modelsim_ase/linuxaloem' >> sudo /etc/bash.bashrc

exit
