--
--
library ieee,xil_defaultlib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topHdl_tb is
end entity topHdl_tb;

architecture bhv of topHdl_tb is
-- constants

-- types

-- signals
signal clk 		: std_logic := '0';
signal clk_n 	: std_logic;

----------------------------------------------------------------------------------------------------
begin	-- architecture
----------------------------------------------------------------------------------------------------

clk 	<= not clk after 2.5 ns; -- 200mhz
clk_n	<= not clk;


topHdl_tb : entity xil_defaultlib.topHdl 
port map (
	DDR_addr          => open,	-- inout std_logic_vector (14 downto 0);
    DDR_ba            => open,	-- inout std_logic_vector (2 downto 0);
    DDR_cas_n         => open,	-- inout std_logic;
    DDR_ck_n          => open,	-- inout std_logic;
    DDR_ck_p          => open,	-- inout std_logic;
    DDR_cke           => open,	-- inout std_logic;
    DDR_cs_n          => open,	-- inout std_logic;
    DDR_dm            => open,	-- inout std_logic_vector (3 downto 0);
    DDR_dq            => open,	-- inout std_logic_vector (31 downto 0);
    DDR_dqs_n         => open,	-- inout std_logic_vector (3 downto 0);
    DDR_dqs_p         => open,	-- inout std_logic_vector (3 downto 0);
    DDR_odt           => open,	-- inout std_logic;
    DDR_ras_n         => open,	-- inout std_logic;
    DDR_reset_n       => open,	-- inout std_logic;
    DDR_we_n          => open,	-- inout std_logic;
    FIXED_IO_ddr_vrn  => open,	-- inout std_logic;
    FIXED_IO_ddr_vrp  => open,	-- inout std_logic;
    FIXED_IO_mio      => open,	-- inout std_logic_vector (53 downto 0);
    FIXED_IO_ps_clk   => open,	-- inout std_logic;
    FIXED_IO_ps_porb  => open,	-- inout std_logic;
    FIXED_IO_ps_srstb => open,	-- inout std_logic;
    --										
    SYSCLK_P          => clk,		-- in    std_logic;
    SYSCLK_N          => clk_n,	-- in    std_logic;
    GPIO_SW_N         => (others => '0'),	-- in    std_logic;
    GPIO_SW_S         => (others => '0'),	-- in    std_logic;
    PMOD1_0_LS        => open,	-- out   std_logic;
    PMOD1_1_LS        => open,	-- out   std_logic;
    PMOD1_2_LS        => open,	-- out   std_logic;
    PMOD1_3_LS        => open,	-- out   std_logic;
    PMOD2_0_LS        => open,	-- out   std_logic;
    PMOD2_1_LS        => open,	-- out   std_logic;
    PMOD2_2_LS        => open,	-- out   std_logic;
    PMOD2_3_LS        => open 	-- out   std_logic
);


end architecture bhv;
