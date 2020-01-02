#!/bin/bash
################################################################################
# Arguments:
#   - 0: Xilinx path.
################################################################################
XILINX_PATH=$1
################################################################################
CONFIG_FILE=install_config.txt
echo "
#### Vivado HL Design Edition Install Configuration ####
Edition=Vivado HL Design Edition
# Path where Xilinx software will be installed.
Destination="$XILINX_PATH"
# Choose the Products/Devices the you would like to install.
Modules=Zynq UltraScale+ MPSoC:1,DocNav:1,Kintex-7:1,Virtex UltraScale+:1,Virtex UltraScale+ HBM ES:0,Zynq-7000:1,Kintex UltraScale+:1,Model Composer:0,ARM Cortex-A53:1,Spartan-7:1,Zynq UltraScale+ RFSoC ES:0,Engineering Sample Devices:0,Kintex UltraScale:1,Virtex UltraScale:1,SDK Core Tools:1,Zynq UltraScale+ RFSoC:1,ARM Cortex-A9:1,ARM Cortex R5:1,Virtex-7:1,Virtex UltraScale+ 58G ES:0,Zynq UltraScale+ MPSoC ES:0,MicroBlaze:1,Artix-7:1
# Choose the post install scripts you'd like to run as part of the finalization step. Please note that some of these scripts may require user interaction during runtime.
InstallOptions=
## Shortcuts and File associations ##
# Choose whether Start menu/Application menu shortcuts will be created or not.
CreateProgramGroupShortcuts=1
# Choose the name of the Start menu/Application menu shortcut. This setting will be ignored if you choose NOT to create shortcuts.
ProgramGroupFolder=Xilinx Design Tools
# Choose whether shortcuts will be created for All users or just the Current user. Shortcuts can be created for all users only if you run the installer as administrator.
CreateShortcutsForAllUsers=0
# Choose whether shortcuts will be created on the desktop or not.
CreateDesktopShortcuts=1
# Choose whether file associations will be created or not.
CreateFileAssociation=1
# Choose whether disk usage will be optimized (reduced) after installation
EnableDiskUsageOptimization=1
" >> $CONFIG_FILE
