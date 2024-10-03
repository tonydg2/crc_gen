--
--
library ieee, crc_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use crc_lib.crc_pkg.all;

entity generic_crc_tb is
end entity generic_crc_tb;

architecture bhv of generic_crc_tb is
-- constants

-- types

-- signals
signal clk          : std_logic := '0';
signal clk_n        : std_logic;
signal rst          : std_logic := '1';
signal crc_en       : std_logic := '0';

signal checksum_rdy : std_logic;

--constant poly         : std_logic_vector := "1100000111";
--constant poly         : std_logic_vector := "00000111";
constant poly         : std_logic_vector := x"9b";
constant init         : std_logic_vector := x"ff"; --ffffffff
constant refin        : std_logic        := '0';
constant refout       : std_logic        := '0';
constant xorout       : std_logic_vector := x"00"; --00000000

--constant data         : std_logic_vector := x"45ababab99";
--constant data         : std_logic_vector := x"5a66666b";
constant data         : std_logic_vector := x"05";

--signal checksum     : std_logic_vector((poly'length - 2) downto 0);
signal checksum     : std_logic_vector((poly'length - 1) downto 0);



--type testArray is array (natural range <>) of std_logic_vector;
--constant testCon : testArray(0 to 2)(31 downto 0) := (x"04C11DB7", x"ffffffff", x"fffffff7");

type checkSumArray is array (natural range <>) of std_logic_vector;

--signal cs8 : checkSumArray(0 to CRC8_MAX-1)(7 downto 0);
signal cs8      : csumArray(0 to TESTS_MAX-1)(0 to CRC8_MAX-1)(7 downto 0);
signal verif8   : csumArray(0 to TESTS_MAX-1)(0 to CRC8_MAX-1)(0 downto 0);
signal cs16     : csumArray(0 to TESTS_MAX-1)(0 to CRC16_MAX-1)(15 downto 0);
signal verif16  : csumArray(0 to TESTS_MAX-1)(0 to CRC16_MAX-1)(0 downto 0);
signal cs32     : csumArray(0 to TESTS_MAX-1)(0 to CRC32_MAX-1)(31 downto 0);
signal verif32  : csumArray(0 to TESTS_MAX-1)(0 to CRC32_MAX-1)(0 downto 0);
--signal cs16 : checkSumArray(0 to CRC16_MAX-1)(15 downto 0);
--signal verif16 : checkSumArray(0 to CRC16_MAX-1)(0 downto 0);
--signal cs32 : checkSumArray(0 to CRC32_MAX-1)(31 downto 0);
--signal verif32 : checkSumArray(0 to CRC32_MAX-1)(0 downto 0);

--signal cs8_data : 

signal test1 : std_logic_vector(7 downto 0);

----------------------------------------------------------------------------------------------------
begin  -- architecture
----------------------------------------------------------------------------------------------------
clk   <= not clk after 2.5 ns;        -- 200mhz
clk_n <= not clk;

process
begin
  wait for 100 ns;
  rst    <= not rst;
  wait for 20 ns;
  crc_en <= '1';
  wait for 10 ns;
  crc_en <= '0';
  test1 <= CRC8_CONFIG.poly(0);
  wait for 10 ns;
  test1 <= CRC8_CONFIG.poly(1);


  wait until (checksum_rdy = '1');
  wait until (checksum_rdy = '0');

  wait for 500 ns;

  for i in 0 to (TESTS_MAX-1) loop 
    for x in 0 to (CRC8_MAX-1) loop 
      --wait until (checksum_rdy = '1');
      if (cs8(i)(x) = DATA16_TEST_VALUES.csum8(i)(x)) then 
--      if (cs8(i)(x) = chksums8(i)(x)) then 
        verif8(i)(x) <= "1";
      else 
        verif8(i)(x) <= "0";
        report "CRC8 FAILED i:" & integer'image(i) & " x:" & integer'image(x) severity warning;
      end if;
    end loop;
  end loop;

  for i in 0 to (TESTS_MAX-1) loop 
    for x in 0 to (CRC16_MAX-1) loop 
      if (cs16(i)(x) = DATA16_TEST_VALUES.csum16(i)(x)) then 
        verif16(i)(x) <= "1";
      else 
        verif16(i)(x) <= "0";
        report "CRC16 FAILED i:" & integer'image(i) & " x:" & integer'image(x) severity warning;
      end if;
    end loop;
  end loop;

  for i in 0 to (TESTS_MAX-1) loop 
    for x in 0 to (CRC32_MAX-1) loop 
      if (cs32(i)(x) = DATA16_TEST_VALUES.csum32(i)(x)) then 
        verif32(i)(x) <= "1";
      else 
        verif32(i)(x) <= "0";
        report "CRC32 FAILED i:" & integer'image(i) & " x:" & integer'image(x) severity warning;
      end if;
    end loop;
  end loop;


--  for x in 0 to (CRC8_MAX-1) loop 
--    --wait until (checksum_rdy = '1');
--    if (cs8(x) = CRC8_CONFIG.res(x)) then 
--      verif8(x) <= "1";
--    else 
--      verif8(x) <= "0";
--      report "CRC8 FAILED index " & integer'image(x) severity warning;
--    end if;
--  end loop;
--  
--  for x in 0 to (CRC16_MAX-1) loop 
--    --wait until (checksum_rdy = '1');
--    if (cs16(x) = CRC16_CONFIG.res(x)) then 
--      verif16(x) <= "1";
--    else 
--      verif16(x) <= "0";
--      report "CRC16 FAILED index " & integer'image(x) severity warning;
--    end if;
--  end loop;
--
--  for x in 0 to (CRC32_MAX-1) loop 
--    --wait until (checksum_rdy = '1');
--    if (cs32(x) = CRC32_CONFIG.res(x)) then 
--      verif32(x) <= "1";
--    else 
--      verif32(x) <= "0";
--      report "CRC32 FAILED index " & integer'image(x) severity warning;
--    end if;
--  end loop;

 
 -- if poly'ascending = true then
 --   report "*** true*****";
 -- else
 --   report "*** false*****";
 -- end if;
  

  wait;
end process;

  generic_crc : entity crc_lib.generic_crc
    generic map (
      Polynomial        => poly,          -- std_logic_vector := "100000111";-- default = z^8 + z^2 + z + 1
      InitialConditions => init,          -- std_logic_vector := "0";
      DirectMethod      => '1',           -- std_logic := '0';
      ReflectInputBytes => refin,         -- std_logic := '0';
      ReflectChecksums  => refout,        -- std_logic := '0';
      FinalXOR          => xorout,        -- std_logic_vector := "0";
      ChecksumsPerFrame => 1              -- integer := 1
      )
    port map (
      clk               => clk,           -- in  std_logic;
      rst               => rst,           -- in  std_logic;
      crc_en            => crc_en,        -- in  std_logic;
      data              => data,          -- in  std_logic_vector
      checksum          => checksum,      -- out std_logic_vector
      checksum_rdy      => checksum_rdy   -- out std_logic
      );

gen_crc8_test : for i in 0 to (TESTS_MAX-1) generate 
  gen_crc8_inst : for x in 0 to (CRC8_MAX-1) generate 
    generic_crc : entity crc_lib.generic_crc
      generic map (
        Polynomial        => CRC8_CONFIG.poly(x),
        InitialConditions => CRC8_CONFIG.init(x),
        ReflectInputBytes => CRC8_CONFIG.refi(x),
        ReflectChecksums  => CRC8_CONFIG.refo(x),
        FinalXOR          => CRC8_CONFIG.fxor(x),
        DirectMethod      => '1',
        ChecksumsPerFrame => 1
        )
      port map (
        clk               => clk,       -- in  std_logic;
        rst               => rst,       -- in  std_logic;
        crc_en            => crc_en,    -- in  std_logic;
        data              => DATA16_TEST_VALUES.data(i),      -- in  std_logic_vector
        checksum          => cs8(i)(x),      -- out std_logic_vector
        checksum_rdy      => open       -- out std_logic
        );
  end generate;
end generate;

gen_crc16_test : for i in 0 to (TESTS_MAX-1) generate 
  gen_crc16_inst : for x in 0 to (CRC16_MAX-1) generate 
    generic_crc : entity crc_lib.generic_crc
      generic map (
        Polynomial        => CRC16_CONFIG.poly(x),
        InitialConditions => CRC16_CONFIG.init(x),
        ReflectInputBytes => CRC16_CONFIG.refi(x),
        ReflectChecksums  => CRC16_CONFIG.refo(x),
        FinalXOR          => CRC16_CONFIG.fxor(x),
        DirectMethod      => '1',
        ChecksumsPerFrame => 1
        )
      port map (
        clk               => clk,       -- in  std_logic;
        rst               => rst,       -- in  std_logic;
        crc_en            => crc_en,    -- in  std_logic;
        data              => DATA16_TEST_VALUES.data(i),      -- in  std_logic_vector
        checksum          => cs16(i)(x),      -- out std_logic_vector
        checksum_rdy      => open       -- out std_logic
        );
  end generate;
end generate;

gen_crc32_test : for i in 0 to (TESTS_MAX-1) generate 
  gen_crc32_inst : for x in 0 to (CRC32_MAX-1) generate 
    generic_crc : entity crc_lib.generic_crc
      generic map (
        Polynomial        => CRC32_CONFIG.poly(x),
        InitialConditions => CRC32_CONFIG.init(x),
        ReflectInputBytes => CRC32_CONFIG.refi(x),
        ReflectChecksums  => CRC32_CONFIG.refo(x),
        FinalXOR          => CRC32_CONFIG.fxor(x),
        DirectMethod      => '1',
        ChecksumsPerFrame => 1
        )
      port map (
        clk               => clk,       -- in  std_logic;
        rst               => rst,       -- in  std_logic;
        crc_en            => crc_en,    -- in  std_logic;
        data              => DATA16_TEST_VALUES.data(i),      -- in  std_logic_vector
        checksum          => cs32(i)(x),      -- out std_logic_vector
        checksum_rdy      => open       -- out std_logic
        );
  end generate;
end generate;

--gen_crc16_inst : for x in 0 to (CRC16_MAX-1) generate 
--  generic_crc : entity crc_lib.generic_crc
--    generic map (
--      Polynomial        => CRC16_CONFIG.poly(x),
--      InitialConditions => CRC16_CONFIG.init(x),
--      ReflectInputBytes => CRC16_CONFIG.refi(x),
--      ReflectChecksums  => CRC16_CONFIG.refo(x),
--      FinalXOR          => CRC16_CONFIG.fxor(x),
--      DirectMethod      => '1',
--      ChecksumsPerFrame => 1
--      )
--    port map (
--      clk               => clk,       -- in  std_logic;
--      rst               => rst,       -- in  std_logic;
--      crc_en            => crc_en,    -- in  std_logic;
--      data              => data,      -- in  std_logic_vector
--      checksum          => cs16(x),      -- out std_logic_vector
--      checksum_rdy      => open       -- out std_logic
--      );
--end generate;
--
--gen_crc32_inst : for x in 0 to (CRC32_MAX-1) generate 
--  generic_crc : entity crc_lib.generic_crc
--    generic map (
--      Polynomial        => CRC32_CONFIG.poly(x),
--      InitialConditions => CRC32_CONFIG.init(x),
--      ReflectInputBytes => CRC32_CONFIG.refi(x),
--      ReflectChecksums  => CRC32_CONFIG.refo(x),
--      FinalXOR          => CRC32_CONFIG.fxor(x),
--      DirectMethod      => '1',
--      ChecksumsPerFrame => 1
--      )
--    port map (
--      clk               => clk,       -- in  std_logic;
--      rst               => rst,       -- in  std_logic;
--      crc_en            => crc_en,    -- in  std_logic;
--      data              => data,      -- in  std_logic_vector
--      checksum          => cs32(x),      -- out std_logic_vector
--      checksum_rdy      => open       -- out std_logic
--      );
--end generate;


end architecture bhv;
