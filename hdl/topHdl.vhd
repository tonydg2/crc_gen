-- comment
-- header

library ieee, xil_defaultlib, unisim;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use xil_defaultlib.axi_pkg.all;
use unisim.vcomponents.all;

entity topHdl is
  port (
    DDR_addr          : inout std_logic_vector (14 downto 0);
    DDR_ba            : inout std_logic_vector (2 downto 0);
    DDR_cas_n         : inout std_logic;
    DDR_ck_n          : inout std_logic;
    DDR_ck_p          : inout std_logic;
    DDR_cke           : inout std_logic;
    DDR_cs_n          : inout std_logic;
    DDR_dm            : inout std_logic_vector (3 downto 0);
    DDR_dq            : inout std_logic_vector (31 downto 0);
    DDR_dqs_n         : inout std_logic_vector (3 downto 0);
    DDR_dqs_p         : inout std_logic_vector (3 downto 0);
    DDR_odt           : inout std_logic;
    DDR_ras_n         : inout std_logic;
    DDR_reset_n       : inout std_logic;
    DDR_we_n          : inout std_logic;
    FIXED_IO_ddr_vrn  : inout std_logic;
    FIXED_IO_ddr_vrp  : inout std_logic;
    FIXED_IO_mio      : inout std_logic_vector (53 downto 0);
    FIXED_IO_ps_clk   : inout std_logic;
    FIXED_IO_ps_porb  : inout std_logic;
    FIXED_IO_ps_srstb : inout std_logic;
    --
    SYSCLK_P          : in    std_logic;
    SYSCLK_N          : in    std_logic;
    USRCLK_P          : in    std_logic;
    USRCLK_N          : in    std_logic;
    GPIO_SW_N         : in    std_logic;
    GPIO_SW_S         : in    std_logic;
    PMOD1_0_LS        : out   std_logic;
    PMOD1_1_LS        : out   std_logic;
    PMOD1_2_LS        : out   std_logic;
    PMOD1_3_LS        : out   std_logic;
    PMOD2_0_LS        : out   std_logic;
    PMOD2_1_LS        : out   std_logic;
    PMOD2_2_LS        : out   std_logic;
    PMOD2_3_LS        : out   std_logic
   --sw  : in  std_logic_vector(3 downto 0);
   --led : out std_logic_vector(7 downto 0)
    );
end topHdl;

architecture rtl of topHdl is

-- components
component ila_32x4k is
  port (
    clk     : in std_logic;
    probe0  : in std_logic_vector(31 downto 0)
  );
end component ila_32x4k;

-- constants
constant CNT_MAX : integer := 2000000; -- 1000000 = 5ms @ 200mhz

-- types

-- signals 
signal M00_AXI_0 : axi_rec;
--
signal sysclk   	       : std_logic;
signal clk200   	       : std_logic;
signal cnt      	       : integer              := 0;
signal ledCnt   	       : unsigned(7 downto 0) := (others => '0');
signal areset_n 	       : std_logic;
signal clk50    	       : std_logic;
signal led_out  	       : std_logic_vector(3 downto 0);
signal Core0_nFIQ	       : std_logic; 
signal Core0_nIRQ	       : std_logic; 
signal IRQ_F2P   	       : std_logic_vector(2 downto 0); 
signal reg0              : std_logic_vector(31 downto 0); -- x43C0.0000
signal FIQ_int_sr        : std_logic_vector(1 downto 0);
signal IRQ_int_sr        : std_logic_vector(1 downto 0);  
signal FIQ_stb_stretch   : std_logic_vector(31 downto 0);
signal IRQ_stb_stretch   : std_logic_vector(31 downto 0);
signal FIQ_stb           : std_logic;
signal IRQ_stb           : std_logic;
signal IRQ_nFIQ          : std_logic;
signal IRQ_nIRQ          : std_logic;
---------------------------------------------------------------------------------------------------
begin  -- architecture
---------------------------------------------------------------------------------------------------

PMOD1_0_LS <= led_out(0);
PMOD1_1_LS <= led_out(1);
PMOD1_2_LS <= led_out(2);
PMOD1_3_LS <= led_out(3);
PMOD2_0_LS <= ledCnt(4);
PMOD2_1_LS <= ledCnt(5);
PMOD2_2_LS <= ledCnt(6);
PMOD2_3_LS <= ledCnt(7);
--pbsw        <= GPIO_SW_N & GPIO_SW_S;


IBUFGDS_inst : IBUFGDS
  port map (
    I  => SYSCLK_P,  -- Diff_p clock buffer input (connect directly to top-level port)
    IB => SYSCLK_N,  -- Diff_n clock buffer input (connect directly to top-level port)
    O  => sysclk                      -- Clock buffer output
    );

BUFG_inst : BUFG
  port map (
    I => sysclk,                      -- 1-bit input: Clock input
    O => clk200                       -- 1-bit output: Clock output
    );


led_proc : process(clk200)
begin
  if rising_edge(clk200) then
    cnt <= cnt + 1;
    if cnt = CNT_MAX then
      ledCnt <= ledCnt + 1;
      cnt    <= 0;
    end if;
  end if;
end process;

-- interrupt strobes, FIQ and IRQ interrupts are level only (active hi)
int_proc : process(clk200)
begin
  if rising_edge(clk200) then
    FIQ_int_sr      <= FIQ_int_sr(0) & ledCnt(7);
    IRQ_int_sr      <= IRQ_int_sr(0) & ledCnt(6);
    FIQ_stb_stretch <= FIQ_stb_stretch(30 downto 0) & FIQ_stb;
    IRQ_stb_stretch <= IRQ_stb_stretch(30 downto 0) & IRQ_stb;
  end if;
end process;

FIQ_stb <= '1' when (FIQ_int_sr = "01") else '0'; -- 1 clk wide strobe
IRQ_stb <= '1' when (IRQ_int_sr = "01") else '0';

Core0_nFIQ <= '1' when FIQ_stb_stretch /= x"00000000" else '0'; -- stretched interrupt
Core0_nIRQ <= '1' when IRQ_stb_stretch /= x"00000000" else '0';

-- interrupt enables
--Core0_nFIQ  <= '1' when (FIQ_int_sr = "01") and (reg0(0) = '1') else '0'; -- rising edge and enabled
--Core0_nIRQ  <= '1' when (IRQ_int_sr = "01") and (reg0(1) = '1') else '0'; -- rising edge and enabled
IRQ_nFIQ    <= Core0_nFIQ and reg0(0);
IRQ_nIRQ    <= Core0_nIRQ and reg0(1);

IRQ_F2P(2)  <= ledCnt(5) and reg0(2);
IRQ_F2P(1)  <= ledCnt(4) and reg0(3);
IRQ_F2P(0)  <= ledCnt(3) and reg0(4); 



ps : entity xil_defaultlib.PS_template_BD_wrapper
port map (
   DDR_0_addr            => DDR_addr           ,-- inout STD_LOGIC_VECTOR ( 14 downto 0 );
   DDR_0_ba              => DDR_ba             ,-- inout STD_LOGIC_VECTOR ( 2 downto 0 );
   DDR_0_cas_n           => DDR_cas_n          ,-- inout STD_LOGIC;
   DDR_0_ck_n            => DDR_ck_n           ,-- inout STD_LOGIC;
   DDR_0_ck_p            => DDR_ck_p           ,-- inout STD_LOGIC;
   DDR_0_cke             => DDR_cke            ,-- inout STD_LOGIC;
   DDR_0_cs_n            => DDR_cs_n           ,-- inout STD_LOGIC;
   DDR_0_dm              => DDR_dm             ,-- inout STD_LOGIC_VECTOR ( 3 downto 0 );
   DDR_0_dq              => DDR_dq             ,-- inout STD_LOGIC_VECTOR ( 31 downto 0 );
   DDR_0_dqs_n           => DDR_dqs_n          ,-- inout STD_LOGIC_VECTOR ( 3 downto 0 );
   DDR_0_dqs_p           => DDR_dqs_p          ,-- inout STD_LOGIC_VECTOR ( 3 downto 0 );
   DDR_0_odt             => DDR_odt            ,-- inout STD_LOGIC;
   DDR_0_ras_n           => DDR_ras_n          ,-- inout STD_LOGIC;
   DDR_0_reset_n         => DDR_reset_n        ,-- inout STD_LOGIC;
   DDR_0_we_n            => DDR_we_n           ,-- inout STD_LOGIC;
   FIXED_IO_0_ddr_vrn    => FIXED_IO_ddr_vrn   ,-- inout STD_LOGIC;
   FIXED_IO_0_ddr_vrp    => FIXED_IO_ddr_vrp   ,-- inout STD_LOGIC;
   FIXED_IO_0_mio        => FIXED_IO_mio       ,-- inout STD_LOGIC_VECTOR ( 53 downto 0 );
   FIXED_IO_0_ps_clk     => FIXED_IO_ps_clk    ,-- inout STD_LOGIC;
   FIXED_IO_0_ps_porb    => FIXED_IO_ps_porb   ,-- inout STD_LOGIC;
   FIXED_IO_0_ps_srstb   => FIXED_IO_ps_srstb  ,-- inout STD_LOGIC
   ACLK                  => M00_AXI_0.ACLK     ,-- out STD_LOGIC;
   ARESETN               => M00_AXI_0.ARESETN  ,-- out STD_LOGIC_VECTOR ( 0 to 0 );
   Core0_nFIQ_0 	       => IRQ_nFIQ           ,-- in STD_LOGIC;
   Core0_nIRQ_0 	       => IRQ_nIRQ           ,-- in STD_LOGIC;
   IRQ_F2P_0    	       => IRQ_F2P            ,-- in STD_LOGIC_VECTOR ( 2 downto 0 );
   M00_AXI_0_araddr      => M00_AXI_0.araddr   ,--out STD_LOGIC_VECTOR ( 31 downto 0 );
   M00_AXI_0_arprot      => M00_AXI_0.arprot   ,--out STD_LOGIC_VECTOR ( 2 downto 0 );
   M00_AXI_0_arready     => M00_AXI_0.arready  ,--in STD_LOGIC;
   M00_AXI_0_arvalid     => M00_AXI_0.arvalid  ,--out STD_LOGIC;
   M00_AXI_0_awaddr      => M00_AXI_0.awaddr   ,--out STD_LOGIC_VECTOR ( 31 downto 0 );
   M00_AXI_0_awprot      => M00_AXI_0.awprot   ,--out STD_LOGIC_VECTOR ( 2 downto 0 );
   M00_AXI_0_awready     => M00_AXI_0.awready  ,--in STD_LOGIC;
   M00_AXI_0_awvalid     => M00_AXI_0.awvalid  ,--out STD_LOGIC;
   M00_AXI_0_bready      => M00_AXI_0.bready   ,--out STD_LOGIC;
   M00_AXI_0_bresp       => M00_AXI_0.bresp    ,--in STD_LOGIC_VECTOR ( 1 downto 0 );
   M00_AXI_0_bvalid      => M00_AXI_0.bvalid   ,--in STD_LOGIC;
   M00_AXI_0_rdata       => M00_AXI_0.rdata    ,--in STD_LOGIC_VECTOR ( 31 downto 0 );
   M00_AXI_0_rready      => M00_AXI_0.rready   ,--out STD_LOGIC;
   M00_AXI_0_rresp       => M00_AXI_0.rresp    ,--in STD_LOGIC_VECTOR ( 1 downto 0 );
   M00_AXI_0_rvalid      => M00_AXI_0.rvalid   ,--in STD_LOGIC;
   M00_AXI_0_wdata       => M00_AXI_0.wdata    ,--out STD_LOGIC_VECTOR ( 31 downto 0 );
   M00_AXI_0_wready      => M00_AXI_0.wready   ,--in STD_LOGIC;
   M00_AXI_0_wstrb       => M00_AXI_0.wstrb    ,--out STD_LOGIC_VECTOR ( 3 downto 0 );
   M00_AXI_0_wvalid      => M00_AXI_0.wvalid    --out STD_LOGIC
);  

axi_intfc : entity xil_defaultlib.axi_intfc
port map (
  clk200        => clk200,
--	axi          => M00_AXI_0
  ACLK          => M00_AXI_0.ACLK     ,   --: in  std_logic;
  ARESETN       => M00_AXI_0.ARESETN  ,   --: in  std_logic_vector ( 0 to 0 );
  S_AXI_araddr  => M00_AXI_0.araddr   ,   --: in  std_logic_vector ( 31 downto 0 );
  S_AXI_arprot  => M00_AXI_0.arprot   ,   --: in  std_logic_vector ( 2 downto 0 );
  S_AXI_arready => M00_AXI_0.arready  ,   --: out std_logic;
  S_AXI_arvalid => M00_AXI_0.arvalid  ,   --: in  std_logic;
  S_AXI_awaddr  => M00_AXI_0.awaddr   ,   --: in  std_logic_vector ( 31 downto 0 );
  S_AXI_awprot  => M00_AXI_0.awprot   ,   --: in  std_logic_vector ( 2 downto 0 );
  S_AXI_awready => M00_AXI_0.awready  ,   --: out std_logic;
  S_AXI_awvalid => M00_AXI_0.awvalid  ,   --: in  std_logic;
  S_AXI_bready  => M00_AXI_0.bready   ,   --: in  std_logic;
  S_AXI_bresp   => M00_AXI_0.bresp    ,   --: out std_logic_vector ( 1 downto 0 );
  S_AXI_bvalid  => M00_AXI_0.bvalid   ,   --: out std_logic;
  S_AXI_rdata   => M00_AXI_0.rdata    ,   --: out std_logic_vector ( 31 downto 0 );
  S_AXI_rready  => M00_AXI_0.rready   ,   --: in  std_logic;
  S_AXI_rresp   => M00_AXI_0.rresp    ,   --: out std_logic_vector ( 1 downto 0 );
  S_AXI_rvalid  => M00_AXI_0.rvalid   ,   --: out std_logic;
  S_AXI_wdata   => M00_AXI_0.wdata    ,   --: in  std_logic_vector ( 31 downto 0 );
  S_AXI_wready  => M00_AXI_0.wready   ,   --: out std_logic;
  S_AXI_wstrb   => M00_AXI_0.wstrb    ,   --: in  std_logic_vector ( 3 downto 0 );
  S_AXI_wvalid  => M00_AXI_0.wvalid   ,   --: in  std_logic
  reg0          => reg0                   --: out std_logic_vector(31 downto 0) -- x43C0.0000
);



----------------------------------------------------------------------------------------------------
-- DEBUG
----------------------------------------------------------------------------------------------------

ila : ila_32x4k
port map (
  clk                   => clk200      ,
  probe0(31 downto 15)  => (others => '0'),
  probe0(14)            => reg0(0)     ,
  probe0(13)            => reg0(1)     ,
  probe0(12)            => reg0(2)     ,
  probe0(11)            => reg0(3)     ,
  probe0(10)            => reg0(4)     ,
  probe0(9)             => ledCnt(7)   ,
  probe0(8)             => ledCnt(6)   ,
  probe0(7)             => ledCnt(5)   ,
  probe0(6)             => ledCnt(4)   ,
  probe0(5)             => ledCnt(3)   ,
  probe0(4)             => Core0_nFIQ  ,
  probe0(3)             => Core0_nIRQ  ,
  probe0(2)             => IRQ_F2P(2)  ,
  probe0(1)             => IRQ_F2P(1)  ,
  probe0(0)             => IRQ_F2P(0)
); 


----------------------------------------------------------------------------------------------------
end rtl;
----------------------------------------------------------------------------------------------------