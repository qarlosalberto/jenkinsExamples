#+++ IP LIST +++ 
#+++ xfft START +++ 
set ip_name xfft_0
create_ip -name xfft -vendor xilinx.com -library ip -version 9.1 -module_name ${ip_name}
set_property -dict [list \
  CONFIG.ACLK_INTF.FREQ_HZ {100000000} \
  CONFIG.Component_Name {xfft_0} \
  CONFIG.aclken {false} \
  CONFIG.aresetn {true} \
  CONFIG.butterfly_type {use_luts} \
  CONFIG.channels {1} \
  CONFIG.complex_mult_type {use_mults_resources} \
  CONFIG.cyclic_prefix_insertion {false} \
  CONFIG.data_format {fixed_point} \
  CONFIG.implementation_options {automatically_select} \
  CONFIG.input_width {16} \
  CONFIG.memory_options_data {block_ram} \
  CONFIG.memory_options_hybrid {false} \
  CONFIG.memory_options_phase_factors {block_ram} \
  CONFIG.memory_options_reorder {block_ram} \
  CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {0} \
  CONFIG.output_ordering {natural_order} \
  CONFIG.ovflo {false} \
  CONFIG.phase_factor_width {16} \
  CONFIG.rounding_modes {truncation} \
  CONFIG.run_time_configurable_transform_length {true} \
  CONFIG.scaling_options {unscaled} \
  CONFIG.target_clock_frequency {250} \
  CONFIG.target_data_throughput {50} \
  CONFIG.throttle_scheme {realtime} \
  CONFIG.transform_length {32768} \
  CONFIG.xk_index {true} \
  ] [get_ips ${ip_name}]
#+++ xfft END +++ 

#+++ IP LIST END +++ 
