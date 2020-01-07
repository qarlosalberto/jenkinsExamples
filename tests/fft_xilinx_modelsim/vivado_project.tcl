#+++ TOP PROJECT +++ 
set script_path [file normalize [info script]]
set script_dir [file dirname ${script_path}]
puts "+++ Dir Script ${script_dir} +++ "
puts "+ Creating Project : vivado_project +" 
file mkdir ${script_dir}/vivado_project
create_project vivado_project ${script_dir}/vivado_project -force
#+++ Set project properties +++
puts "+ Setting properties... +"
set_property target_language Verilog [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property part xc7z020clg400-2 [current_project]
#+++ Add sources +++
update_compile_order -fileset [get_filesets sources_1]
remove_files [get_files -filter {IS_AUTO_DISABLED}]
#+++ Add VHDL and Verilog +++
#+++ Add MEM +++
#+++ Add COE +++
#+++ Add XDC +++
#+++ Add edif +++
#+++ Add DCP +++
#+++ Synthesis properties +++
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY rebuilt [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.GATED_CLOCK_CONVERSION off [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.BUFG 12 [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.DIRECTIVE Default [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.FANOUT_LIMIT 10000 [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.RETIMING 0 [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.FSM_EXTRACTION auto [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.KEEP_EQUIVALENT_REGISTERS 0 [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.NO_LC 0 [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.NO_SRLEXTRACT 0 [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.SHREG_MIN_SIZE 3 [get_runs synth_1]
#+++ Implementation properties +++
#+++ Add TCL +++
#+++ Add IPS +++
source  ${script_dir}/src/ip/ips.tcl
#+++ Add BD +++
#+++ TOP PROJECT END+++ 
