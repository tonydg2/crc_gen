-- AXI interface protocol: "AMBA AXI and ACE protocol spec. (arm ihi 0022d)
--

library ieee, xil_defaultlib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use xil_defaultlib.axi_pkg.all;

entity axi_intfc is
  port  (
    clk200  : in std_logic;
		--axi     : axi_rec
    ACLK          : in  std_logic;
    ARESETN       : in  std_logic_vector ( 0 to 0 );
    -- Read address
		S_AXI_araddr  : in  std_logic_vector ( 31 downto 0 );
    S_AXI_arprot  : in  std_logic_vector ( 2 downto 0 );
    S_AXI_arready : out std_logic;
    S_AXI_arvalid : in  std_logic;
    -- Write address
		S_AXI_awaddr  : in  std_logic_vector ( 31 downto 0 );
    S_AXI_awprot  : in  std_logic_vector ( 2 downto 0 );
    S_AXI_awready : out std_logic;
    S_AXI_awvalid : in  std_logic;
    -- Write response
		S_AXI_bready  : in  std_logic;
    S_AXI_bresp   : out std_logic_vector ( 1 downto 0 );
    S_AXI_bvalid  : out std_logic;
    -- Read data
		S_AXI_rdata   : out std_logic_vector ( 31 downto 0 );
    S_AXI_rready  : in  std_logic;
    S_AXI_rresp   : out std_logic_vector ( 1 downto 0 );
    S_AXI_rvalid  : out std_logic;
    -- Write data
		S_AXI_wdata   : in  std_logic_vector ( 31 downto 0 );
    S_AXI_wready  : out std_logic;
    S_AXI_wstrb   : in  std_logic_vector ( 3 downto 0 );
    S_AXI_wvalid  : in  std_logic;
    -- Misc.
    reg0          : out std_logic_vector(31 downto 0) -- x43C0.0000
  );
-- NOTE AR# 54778
 attribute keep_hierarchy : string;
 attribute keep_hierarchy of axi_intfc : entity is "yes";

end axi_intfc;

architecture rtl of axi_intfc is

-- components

-- constants

  constant LOCAL_ADDR_HI : std_logic_vector(15 downto 0) := x"43C0";

-- types
  type rd_addr_type is (WAIT4_ARVALID,WAIT4_RVALID);
  type wr_addr_type is (WAIT4_AWVALID,DONE);
  type wrAddr_type  is (READY,WAIT4RESP);
  type wrData_type  is (READY,WAIT4RESP);
  type wrResp_type  is (WAIT4TRANS,WAIT4BREADY,WAIT4END);
  
  signal rd_addr_sm : rd_addr_type;
  signal wr_addr_sm : wr_addr_type;
  signal wrAddr_sm  : wrAddr_type;
  signal wrData_sm  : wrData_type;
  signal wrResp_sm  : wrResp_type;

-- signals 
  -- NOTE AR# 54778
	--* signal testSig : std_logic;
  --* attribute KEEP : string;
  --* attribute KEEP of testSig : signal is "true";
  
  alias rstn    is ARESETN       ;
  alias ARADDR  is S_AXI_araddr  ;
  alias ARPROT  is S_AXI_arprot  ;
  alias ARREADY is S_AXI_arready ;
  alias ARVALID is S_AXI_arvalid ;
  alias AWADDR  is S_AXI_awaddr  ;
  alias AWPROT  is S_AXI_awprot  ;
  alias AWREADY is S_AXI_awready ;
  alias AWVALID is S_AXI_awvalid ;
  alias BREADY  is S_AXI_bready  ;
  alias BRESP   is S_AXI_bresp   ;
  alias BVALID  is S_AXI_bvalid  ;
  alias RDATA   is S_AXI_rdata   ;
  alias RREADY  is S_AXI_rready  ;
  alias RRESP   is S_AXI_rresp   ;
  alias RVALID  is S_AXI_rvalid  ;
  alias WDATA   is S_AXI_wdata   ;
  alias WREADY  is S_AXI_wready  ;
  alias WSTRB   is S_AXI_wstrb   ;
  alias WVALID  is S_AXI_wvalid  ;
  
  signal rst          : std_logic;  
  signal rd_addr      : std_logic_vector(31 downto 0);                      
  signal addr0        : std_logic_vector(31 downto 0) := x"00000000";
  signal addr1        : std_logic_vector(31 downto 0) := x"002F005C";
  signal addr2        : std_logic_vector(31 downto 0) := x"DEAD0008";
  signal addr3        : std_logic_vector(31 downto 0) := x"DEAD000C";
  signal valid_raddr  : std_logic;
  signal local_raddr  : integer;
  signal valid_waddr  : std_logic;
  signal local_waddr  : integer;
  signal wr_addr      : std_logic_vector(31 downto 0);
  signal wr_data      : std_logic_vector(31 downto 0);
  signal wr_strb      : std_logic_vector(3 downto 0);
  signal wrAddr_rdy   : std_logic;
  signal wrData_rdy   : std_logic;


---------------------------------------------------------------------------------------------------
begin -- architecture
---------------------------------------------------------------------------------------------------
  rst   <= '1' when (rstn = "0") else '0';

  reg0  <= addr0;
---------------------------------------------------------------------------------------------------
-- debug
---------------------------------------------------------------------------------------------------

--ila : entity xil_defaultlib.ila_0
--PORT MAP (
--  clk                     => clk200,
--  probe0(255 downto 188)  => (others => '0'),
--  probe0(187)             => wrData_rdy,
--  probe0(186)             => wrAddr_rdy,
--  probe0(185)             => valid_waddr,
--  probe0(184 downto 177)  => addr0(7 downto 0),
--  probe0(176 downto 169)  => addr1(7 downto 0),
--  probe0(168 downto 161)  => addr2(7 downto 0),
--  probe0(160 downto 153)  => addr3(7 downto 0),
--  probe0(152)             => ACLK     ,
--  probe0(151 downto 120)  => ARADDR   ,
--  probe0(119 downto 117)  => ARPROT   ,
--  probe0(116)             => ARREADY  ,
--  probe0(115)             => ARVALID  ,
--  probe0(114 downto  83)  => AWADDR   ,
--  probe0( 82 downto  80)  => AWPROT   ,
--  probe0( 79)             => AWREADY  ,
--  probe0( 78)             => AWVALID  ,
--  probe0( 77)             => BREADY   ,
--  probe0( 76 downto  75)  => BRESP    ,
--  probe0( 74)             => BVALID   ,
--  probe0( 73 downto  42)  => RDATA    ,
--  probe0( 41)             => RREADY   ,
--  probe0( 40 downto  39)  => RRESP    ,
--  probe0( 38)             => RVALID   ,
--  probe0( 37 downto   6)  => WDATA    ,
--  probe0(  5)             => WREADY   ,
--  probe0(  4 downto   1)  => WSTRB    ,
--  probe0(  0)             => WVALID    
--);

---------------------------------------------------------------------------------------------------
-- read transaction
---------------------------------------------------------------------------------------------------
read_transaction : process(all)
begin
  if rising_edge(ACLK) then
    if rst = '1' then
      ARREADY     <= '0';
      RVALID      <= '0';
      rd_addr     <= (others => '0');
      rd_addr_sm  <= WAIT4_ARVALID;
    else
      ARREADY <= '0';
      case rd_addr_sm is
      when WAIT4_ARVALID =>
        if (ARVALID = '1') AND (valid_raddr = '1') then -- slave can wait for ARVALID before asserting ARREADY, (only this address space)
          rd_addr     <= ARADDR;                        -- latch address for use next clk cycle
          ARREADY     <= '1';                           -- 1 clk wide
          RVALID      <= '1';                           -- slave MUST wait for ARVALID AND ARREADY 
          rd_addr_sm  <= WAIT4_RVALID; 
        end if;
      when WAIT4_RVALID =>
        if RREADY = '1' then                            -- slave MUST NOT wait for RREADY before asserting RVALID     
          RVALID      <= '0';
          rd_addr_sm  <= WAIT4_ARVALID;
        end if;
      end case;
    end if;
  end if;
end process;

  valid_raddr <= '1' when (ARADDR(31 downto 8) = x"43C000") else '0'; -- this interface memory base address - 64k
  local_raddr <= to_integer(unsigned(rd_addr(7 downto 0)))/4;
  
read_data_select : process(all)
begin
  if RVALID = '1' then
    RRESP <= "00";
    case local_raddr is
    when 0 =>
      RDATA <= addr0;
    when 1 =>
      RDATA <= addr1;
    when 2 =>
      RDATA <= addr2;
    when 3 =>
      RDATA <= addr3;
    when others =>
      RDATA <= x"DEADDEAD";
    end case;
  else
    RDATA <= (others => '-');
    RRESP <= (others => '-');
  end if;
end process;
 
---------------------------------------------------------------------------------------------------
-- write transaction
---------------------------------------------------------------------------------------------------

  valid_waddr <= '1' when (AWADDR(31 downto 16) = LOCAL_ADDR_HI) else '0'; -- this interface memory base address - 64k

-- write transaction address capture
write_addr_capture : process(all)
begin
  if rising_edge(ACLK) then
    if rst = '1' then
      AWREADY     <= '0';
      wrAddr_rdy  <= '0';
      wr_addr     <= (others => '0');
      wrAddr_sm   <= READY;
    else
      case wrAddr_sm is
      -- Slave is ready, wait for valid addr from master
      when READY =>
        AWREADY     <= '1';
        wrAddr_rdy  <= '0';
        if (AWVALID = '1') then --AND (valid_waddr = '1') then -- only this address space
          AWREADY     <= '0';
          wrAddr_rdy  <= '1';     -- addr for current write transaction is latched and ready 
          wr_addr     <= AWADDR;  -- latch write addr
          wrAddr_sm   <= WAIT4RESP;
        end if;
      -- slave is not ready, wait until this write transaction response is completed
      when WAIT4RESP =>
        if (BVALID = '1') AND (BREADY = '1') then
          wrAddr_sm <= READY;
        end if;
      end case;        
    end if;
  end if;
end process;

-- write transaction data capture
write_data_capture : process(all)
begin
  if rising_edge(ACLK) then
    if rst = '1' then
      WREADY      <= '0';
      wrData_rdy  <= '0';
      wr_data     <= (others => '0');
      wr_strb     <= (others => '0');
      wrData_sm   <= READY;
    else
      case wrData_sm is
      -- Slave is ready, wait for valid data from master
      when READY =>
        WREADY      <= '1';
        wrData_rdy  <= '0';
        if (WVALID = '1') then --AND (valid_waddr = '1') then
          WREADY      <= '0';
          wrData_rdy  <= '1';
          wr_data     <= WDATA; -- latch data
          wr_strb     <= WSTRB; -- latch write strobe
          wrData_sm   <= WAIT4RESP;
        end if;
      -- slave is not ready, wait until this write transaction response is completed
      when WAIT4RESP =>
        if (BVALID = '1') AND (BREADY = '1') then
          wrData_sm <= READY;
        end if;
      end case;
    end if;
  end if;
end process;

-- write transaction response
write_response : process(all)
begin
  if rising_edge(ACLK) then
    if rst = '1' then
      BRESP     <= "--";
      BVALID    <= '0';
      wrResp_sm <= WAIT4TRANS;
    else
      case wrResp_sm is
      -- Wait for write transaction address/data to complete
      when WAIT4TRANS =>
        BRESP     <= "--";
        BVALID    <= '0';
        if (wrAddr_rdy = '1') AND (wrData_rdy = '1') then -- addr and data capture complete
          BRESP     <= "00";
          BVALID    <= '1';
          wrResp_sm <= WAIT4BREADY;
        end if;
      -- Wait for master to complete
      when WAIT4BREADY =>
        if BREADY = '1' then
          BRESP     <= "--";
          BVALID    <= '0';
          wrResp_sm <= WAIT4END;
        end if;
      when WAIT4END =>
        if (wrData_rdy = '0') AND (wrAddr_rdy = '0') then
          wrResp_sm <= WAIT4TRANS;
        end if;
      end case;
    end if;
  end if;
end process;

  local_waddr <= to_integer(unsigned(wr_addr(7 downto 0)))/4;                                                     

write_data_local : process(all) 
begin
  if (wrAddr_rdy = '1') AND (wrData_rdy = '1') then
    case local_waddr is
    when 0 =>
      addr0 <= wr_data; 
    when 1 =>
      addr1 <= wr_data;
    when 2 =>
      addr2 <= wr_data;
    when 3 =>
      addr3 <= wr_data;
    when others =>
      null;
    end case;
  end if;
end process;


end rtl; 
  
