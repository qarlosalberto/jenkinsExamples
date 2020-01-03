--! Standard library.
library ieee;
--! Logic elements.
use ieee.std_logic_1164.all;
--! Arithmetic functions.
use ieee.numeric_std.all;
use ieee.math_real.all;
--
-- library std;
use std.textio.all;
--
library vunit_lib;
context vunit_lib.vunit_context;
-- use vunit_lib.array_pkg.all;
-- use vunit_lib.lang.all;
-- use vunit_lib.string_ops.all;
-- use vunit_lib.dictionary.all;
-- use vunit_lib.path.all;
-- use vunit_lib.log_types_pkg.all;
-- use vunit_lib.log_special_types_pkg.all;
-- use vunit_lib.log_pkg.all;
-- use vunit_lib.check_types_pkg.all;
-- use vunit_lib.check_special_types_pkg.all;
-- use vunit_lib.check_pkg.all;
-- use vunit_lib.run_types_pkg.all;
-- use vunit_lib.run_special_types_pkg.all;
-- use vunit_lib.run_base_pkg.all;
-- use vunit_lib.run_pkg.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
library xil_defaultlib;

entity xfft_0_tb is
  generic (runner_cfg : string);
end;
architecture bench of xfft_0_tb is
  -- Clock period
  constant clk_period               : time := 5 ns;
  -- Ports
  signal aclk                       : std_logic;
  signal s_axis_config_tdata        : std_logic_vector (15 downto 0);
  signal s_axis_config_tvalid       : std_logic;
  signal s_axis_config_tready       : std_logic;
  signal s_axis_data_tdata          : std_logic_vector (31 downto 0);
  signal s_axis_data_tvalid         : std_logic;
  signal s_axis_data_tready         : std_logic;
  signal s_axis_data_tlast          : std_logic;
  signal m_axis_data_tdata          : std_logic_vector (63 downto 0);
  signal m_axis_data_tvalid         : std_logic;
  signal m_axis_data_tlast          : std_logic;
  signal event_frame_started        : std_logic;
  signal event_tlast_unexpected     : std_logic;
  signal event_tlast_missing        : std_logic;
  signal event_data_in_channel_halt : std_logic;
begin

  xfft_0_inst : entity xil_defaultlib.xfft_0
    port map(
      aclk                       => aclk,
      s_axis_config_tdata        => s_axis_config_tdata,
      s_axis_config_tvalid       => s_axis_config_tvalid,
      s_axis_config_tready       => s_axis_config_tready,
      s_axis_data_tdata          => s_axis_data_tdata,
      s_axis_data_tvalid         => s_axis_data_tvalid,
      s_axis_data_tready         => s_axis_data_tready,
      s_axis_data_tlast          => s_axis_data_tlast,
      m_axis_data_tdata          => m_axis_data_tdata,
      m_axis_data_tvalid         => m_axis_data_tvalid,
      m_axis_data_tlast          => m_axis_data_tlast,
      event_frame_started        => event_frame_started,
      event_tlast_unexpected     => event_tlast_unexpected,
      event_tlast_missing        => event_tlast_missing,
      event_data_in_channel_halt => event_data_in_channel_halt
    );

  main : process
  begin
    test_runner_setup(runner, runner_cfg);
    while test_suite loop
      if run("test_alive") then
        info("Hello world test_alive");

        s_axis_config_tdata  <= (OTHERS => '0');
        s_axis_config_tvalid <= '0';
        s_axis_data_tdata    <= (OTHERS => '0');
        s_axis_data_tvalid   <= '0';
        s_axis_data_tlast    <= '0';

        wait for 100 ns;
        test_runner_cleanup(runner);

      elsif run("test_0") then
        info("Hello world test_0");
        wait for 100 ns;
        test_runner_cleanup(runner);
      end if;
    end loop;
  end process main;

    clk_process : process
    begin
      aclk <= '1';
      wait for clk_period/2;
      aclk <= '0';
      wait for clk_period/2;
    end process clk_process;

end;
