# -*- coding: utf-8 -*-
from os.path import join , dirname, abspath
import subprocess
from vunit.ghdl_interface import GHDLInterface
from vunit.simulator_factory import SIMULATOR_FACTORY
from vunit   import VUnit, VUnitCLI
from vivado_util import add_vivado_ip
import numpy as np
import sys
##############################################################################
##############################################################################
##############################################################################

#pre_check func
def make_pre_check(name_test,fft_size):
    MAX = 1000000
    input = np.random.randint(MAX, size=fft_size)
    np.savetxt(name_test + '_input' + '.csv', input, delimiter=',',fmt='%1d')
#post_check func
def make_post_check(name_test,fft_size):
  """
  After test.
  """
  def post_check(output_path):
    out0VHDL = np.loadtxt(name_test + "_out0_vhdl" + ".csv",dtype=int,delimiter=',')
    out1VHDL = np.loadtxt(name_test + "_out1_vhdl" + ".csv",dtype=int,delimiter=',')
    check = True
    return check
  return post_check

##############################################################################
##############################################################################
##############################################################################

#Check GHDL backend.
code_coverage=False

#Check simulator.
print ("=============================================")
simulator_class = SIMULATOR_FACTORY.select_simulator()
simname = simulator_class.name
print (simname)
if (simname == "modelsim"):
  f= open("modelsim.do","w+")
  f.write("add wave * \nlog -r /*\nvcd file\nvcd add -r /*\n")
  f.close()
print ("=============================================")

##############################################################################
##############################################################################
##############################################################################

#VUnit instance.
ui = VUnit.from_argv()

reload(sys)
sys.setdefaultencoding('utf8')

#UVVM libraries path.
if (simname=="ghdl" or simname=="GHDL"):
  xilinx_libraries_path = "/opt/Xilinx/ise-lib-comp/xilinx-ise"
  unisim_path = join(xilinx_libraries_path,"unisim","v08")
  uvvm_util_root    = "/opt/Xilinx/UVVM-lib/uvvm_util/v08"
  uvvm_axilite_root = "/opt/Xilinx/UVVM-lib/bitvis_vip_axilite/v08"
  unisim_path = join(xilinx_libraries_path,"unisim","v08")
  unimacro_path = join(xilinx_libraries_path,"unimacro","v08")
  corelib_path = join(xilinx_libraries_path,"xilinxcorelib","v08")
  xpm_used = 0

elif (simname=="modelsim" or simname=="MODELSIM"):
  xilinx_libraries_path = "/fpga/libraries/vivado-modelsim"
  unisim_path   = join(xilinx_libraries_path,"unisim")
  unimacro_path = join(xilinx_libraries_path,"unimacro")
  xpm_path      = join(xilinx_libraries_path,"xpm")
  xpm_used = 1

#Add UVVM libraries.

##############################################################################
##############################################################################
##############################################################################

#Add array pkg.
ui.add_array_util()

#Add module sources.
root = dirname(__file__)
add_vivado_ip(ui, output_path=join(root, "vivado_libs"), project_file=join(root, "../","vivado_project", "vivado_project.xpr"))

#Add tb sources.
fft_tb_lib = ui.add_library("tb_lib")
fft_tb_lib.add_source_files("fft_tb.vhd")

#func precheck
tb_generated = fft_tb_lib.entity("xfft_0_tb")

tb_path       = "./"
g_FFT_SIZE = [64]
for test in tb_generated.get_tests():
    for i in range(0,len(g_FFT_SIZE)):
        name_test = "fft" + str(g_FFT_SIZE[i])
        test.add_config(name=str(name_test),
        pre_config=make_pre_check(name_test,g_FFT_SIZE[i]),
        generics=dict(g_NAME_TEST=name_test,g_FFT_SIZE=g_FFT_SIZE[i],tb_path=tb_path),
        post_check=make_post_check(name_test,g_FFT_SIZE[i]))


##############################################################################
##############################################################################
##############################################################################
#GHDL parameters.
if(code_coverage==True):
  ui.set_sim_option("ghdl.elab_flags"      , [ "-frelaxed-rules", "-Wl,-lgcov" ])
  ui.set_sim_option("modelsim.init_files.after_load" ,["modelsim.do"])
else:
  ui.set_sim_option("modelsim.init_files.after_load" ,["modelsim.do"])

ui.set_sim_option("disable_ieee_warnings", True)

#Run tests.
try:
  ui.main()
except SystemExit as exc:
  all_ok = exc.code == 0

#Code coverage.
if all_ok:
    exit(0)
else:
    exit(1)
