# -*- coding: utf-8 -*-
from os.path import join , dirname, abspath
import subprocess
from vunit.ghdl_interface import GHDLInterface
from vunit.simulator_factory import SIMULATOR_FACTORY
from vunit   import VUnit, VUnitCLI
from vivado_util import add_vivado_ip
import sys
##############################################################################
##############################################################################
##############################################################################

#pre_check func
def make_pre_check(fft_size):
    print(str(fft_size))
#post_check func
def make_post_check():
  """
  After test.
  """
  def post_check(output_path):
    check = True
    return check
  return post_check

##############################################################################
##############################################################################
##############################################################################

#Check GHDL backend.
code_coverage=False
if( GHDLInterface.determine_backend("")=="gcc" or  GHDLInterface.determine_backend("")=="GCC"):
  code_coverage=True
else:
  code_coverage=False

#Check simulator.
print "============================================="
simulator_class = SIMULATOR_FACTORY.select_simulator()
simname = simulator_class.name
print simname
if (simname == "modelsim"):
  f= open("modelsim.do","w+")
  f.write("add wave * \nlog -r /*\nvcd file\nvcd add -r /*\n")
  f.close()
print "============================================="

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
        test.add_config(name=str(g_FFT_SIZE[i]),
        pre_config=make_pre_check(g_FFT_SIZE[i]),
        generics=dict(g_NAME_TEST=str(g_FFT_SIZE[i]),g_FFT_SIZE=g_FFT_SIZE[i],tb_path=tb_path),
        post_check=make_post_check())


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
  if(code_coverage==True and simname == "ghdl"):
    pass
  else:
    exit(0)
else:
  exit(1)
