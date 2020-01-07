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
-- vunit
library vunit_lib;
context vunit_lib.vunit_context;
use vunit_lib.array_pkg.all;
use vunit_lib.integer_array_pkg.all;

-- Xilinx
library xil_defaultlib;

entity xfft_0_tb is
  generic (
    g_NAME_TEST : string  := "";
    g_FFT_SIZE  : integer := 0;
    tb_path     : string  := "./";
    runner_cfg  : string
  );
end;
architecture bench of xfft_0_tb is
  -- Clock period
  constant clk_period               : time := 5 ns;
  -- Ports
  signal aclk                       : std_logic;
  signal aresetn                    : std_logic;
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
  signal m_axis_data_tuser          : std_logic_vector (15 downto 0);
  signal event_frame_started        : std_logic;
  signal event_tlast_unexpected     : std_logic;
  signal event_tlast_missing        : std_logic;
  signal event_data_in_channel_halt : std_logic;
  --
  constant c_FFT_SIZE_LOG2 : integer := integer(ceil(log2(real(g_FFT_SIZE))));
  --
  signal start_input : boolean := false;
  signal end_input   : boolean := false;
begin

  xfft_0_inst : entity xil_defaultlib.xfft_0
    port map(
      aclk                       => aclk,
      aresetn                    => aresetn,
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
      m_axis_data_tuser          => m_axis_data_tuser,
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
        ------------------------------------------------------------------------
        -- Initial values
        ------------------------------------------------------------------------
        aresetn <= '0';
        s_axis_config_tdata  <= (OTHERS => '0');
        s_axis_config_tvalid <= '0';
        wait for 20*clk_period;
        aresetn <= '1';
        wait for 20*clk_period;
        ------------------------------------------------------------------------
        -- Configuration
        ------------------------------------------------------------------------
        -- 9:16: PAD
        -- 8: 8: FDW_INV
        -- 7: 6: PAD
        -- 5: 0: NFFT
        s_axis_config_tdata(7  downto  0) <= std_logic_vector(to_unsigned(c_FFT_SIZE_LOG2,8));
        s_axis_config_tdata(15 downto  8) <= "00000001";
        s_axis_config_tvalid <= '1';
        wait for 1*clk_period;
        s_axis_config_tvalid <= '0';
        wait for 20*clk_period;
        ------------------------------------------------------------------------
        -- Data
        ------------------------------------------------------------------------
        wait for clk_period*1;
        start_input <= true;
        wait for clk_period*1;
        wait until (end_input = true);
        --
        wait for 10*g_FFT_SIZE*clk_period;

        test_runner_cleanup(runner);
      end if;
    end loop;
  end process main;

  input : process
    variable input_data : array_t;
    variable input_data_int : integer;
    variable sample_counter : integer := 0;
  begin
    s_axis_data_tdata  <= (OTHERS => '0');
    s_axis_data_tvalid <= '0';
    s_axis_data_tlast  <= '0';
    input_data.load_csv(tb_path & g_NAME_TEST & "_input" & ".csv");
    wait until (start_input = true);
    wait until (rising_edge(aclk));
    -- Inputs
    input_array : while sample_counter < input_data.length-1 loop
      s_axis_data_tdata  <= std_logic_vector(to_unsigned(input_data.get(sample_counter),
                                                            s_axis_data_tdata'length));
      s_axis_data_tvalid <= '1';
      if (sample_counter = input_data.length-1-1) then
        s_axis_data_tlast  <= '1';
      end if;
      if (s_axis_data_tready = '1')  then
        sample_counter := sample_counter + 1;
      end if;
      wait for 1*clk_period;
    end loop;
    s_axis_data_tvalid <= '0';
    s_axis_data_tlast  <= '0';
    end_input <= true;
  end process;


  output : process
    variable data_0_outputs : array_t;
    variable data_0_out_int : integer;
    variable data_1_outputs : array_t;
    variable data_1_out_int : integer;
  begin
    wait until (m_axis_data_tvalid = '1' and rising_edge(aclk));
    data_0_outputs.init(length => g_FFT_SIZE,
                    bit_width => 32,
                    is_signed => true);
    data_1_outputs.init(length => g_FFT_SIZE,
                    bit_width => 32,
                    is_signed => true);
    -- Inputs
    output_loop : for i in 0 to g_FFT_SIZE-1 loop
      data_0_out_int := to_integer(signed(m_axis_data_tdata(31 downto 0)));
      data_0_outputs.set(i,data_0_out_int);
      --
      data_1_out_int := to_integer(signed(m_axis_data_tdata(63 downto 32)));
      data_1_outputs.set(i,data_1_out_int);
      wait for 1*clk_period;
    end loop;
    data_0_outputs.save_csv(tb_path & g_NAME_TEST & "_out0_vhdl" & ".csv");
    data_1_outputs.save_csv(tb_path & g_NAME_TEST & "_out1_vhdl" & ".csv");
  end process;

  clk_process : process
  begin
    aclk <= '1';
    wait for clk_period/2;
    aclk <= '0';
    wait for clk_period/2;
  end process clk_process;

end;
