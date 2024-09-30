--
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package axi_pkg is
  
  type axi_rec is record
    ACLK     : STD_LOGIC; 
    ARESETN  : STD_LOGIC_VECTOR ( 0 to 0 );  
    araddr   : STD_LOGIC_VECTOR ( 31 downto 0 );
    arprot   : STD_LOGIC_VECTOR ( 2 downto 0 );
    arready  : STD_LOGIC;
    arvalid  : STD_LOGIC;
    awaddr   : STD_LOGIC_VECTOR ( 31 downto 0 );
    awprot   : STD_LOGIC_VECTOR ( 2 downto 0 );
    awready  : STD_LOGIC;
    awvalid  : STD_LOGIC;
    bready   : STD_LOGIC;
    bresp    : STD_LOGIC_VECTOR ( 1 downto 0 );
    bvalid   : STD_LOGIC;
    rdata    : STD_LOGIC_VECTOR ( 31 downto 0 );
    rready   : STD_LOGIC;
    rresp    : STD_LOGIC_VECTOR ( 1 downto 0 );
    rvalid   : STD_LOGIC;
    wdata    : STD_LOGIC_VECTOR ( 31 downto 0 );
    wready   : STD_LOGIC;
    wstrb    : STD_LOGIC_VECTOR ( 3 downto 0 );
    wvalid   : STD_LOGIC;
  end record axi_rec;
  
end package axi_pkg;