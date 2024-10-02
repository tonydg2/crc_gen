-- INPUT VALUE = 0x5
--
--  Algorithm	                  Result	        Check	          Poly	          Init	    RefIn	  RefOut	      XorOut
--  
--  CRC-8	                      0x"6B"  	      0x"F4"  	      0x"07"  	      0x"00"	  false	  false 	      0x"00"
--  CRC-8/CDMA2000	            0x"1A"  	      0x"DA"  	      0x"9B"  	      0x"FF"	  false	  false 	      0x"00"
--  CRC-8/DARC	                0x"8D"  	      0x"15"  	      0x"39"  	      0x"00"	  true	  true  	      0x"00"
--  CRC-8/DVB-S2	              0x"7F"  	      0x"BC"  	      0x"D5"  	      0x"00"	  false	  false 	      0x"00"
--  CRC-8/EBU	                  0x"0E"  	      0x"97"  	      0x"1D"  	      0x"FF"	  true	  true  	      0x"00"
--  CRC-8/I-CODE                0x"D9"  	      0x"7E"  	      0x"1D"  	      0x"FD"	  false	  false 	      0x"00"
--  CRC-8/ITU	                  0x"3E"  	      0x"A1"  	      0x"07"  	      0x"00"	  false	  false 	      0x"55"
--  CRC-8/MAXIM	                0x"4F"  	      0x"A1"  	      0x"31"  	      0x"00"	  true	  true  	      0x"00"
--  CRC-8/ROHC	                0x"2F"  	      0x"D0"  	      0x"07"  	      0x"FF"	  true	  true  	      0x"00"
--  CRC-8/WCDMA	                0x"E6"  	      0x"25"  	      0x"9B"  	      0x"00"	  true	  true  	      0x"00"
--  
--  CRC-16/CCITT-FALSE        0x"4B7A"  	    0x"29B1"  	    0x"1021"  	    0x"FFFF"	  false	  false 	    0x"0000"
--  CRC-16/ARC	              0x"25B4"        0x"BB3D"  	    0x"8005"  	    0x"0000"	  true	  true  	    0x"0000"
--  CRC-16/AUG-CCITT	        0x"ABB8"  	    0x"E5CC"  	    0x"1021"  	    0x"1D0F"	  false	  false 	    0x"0000"
--  CRC-16/BUYPASS	          0x"8372"  	    0x"FEE8"  	    0x"8005"  	    0x"0000"	  false	  false 	    0x"0000"
--  CRC-16/CDMA2000	          0x"9A83"  	    0x"4C06"  	    0x"C867"  	    0x"FFFF"	  false	  false 	    0x"0000"
--  CRC-16/DDS-110	          0x"5B72"  	    0x"9ECF"  	    0x"8005"  	    0x"800D"	  false	  false 	    0x"0000"
--  CRC-16/DECT-R	            0x"B82B"  	    0x"007E"  	    0x"0589"  	    0x"0000"	  false	  false 	    0x"0001"
--  CRC-16/DECT-X	            0x"B82A"  	    0x"007F"  	    0x"0589"  	    0x"0000"	  false	  false 	    0x"0000"
--  CRC-16/DNP	              0x"4535"  	    0x"EA82"  	    0x"3D65"  	    0x"0000"	  true	  true  	    0x"FFFF"
--  CRC-16/EN-13757	          0x"F455"  	    0x"C2B7"  	    0x"3D65"  	    0x"0000"	  false	  false 	    0x"FFFF"
--  CRC-16/GENIBUS	          0x"B485"  	    0x"D64E"  	    0x"1021"  	    0x"FFFF"	  false	  false 	    0x"FFFF"
--  CRC-16/MAXIM	            0x"DA4B"  	    0x"44C2"  	    0x"8005"  	    0x"0000"	  true	  true  	    0x"FFFF"
--  CRC-16/MCRF4XX	          0x"5AA1"  	    0x"6F91"  	    0x"1021"  	    0x"FFFF"	  true	  true  	    0x"0000"
--  CRC-16/RIELLO	            0x"6C3E"  	    0x"63D0"  	    0x"1021"  	    0x"B2AA"	  true	  true  	    0x"0000"
--  CRC-16/T10-DIF	          0x"1D45"  	    0x"D0DB"  	    0x"8BB7"  	    0x"0000"	  false	  false 	    0x"0000"
--  CRC-16/TELEDISK	          0x"FD47"  	    0x"0FB3"  	    0x"A097"  	    0x"0000"	  false	  false 	    0x"0000"
--  CRC-16/TMS37157	          0x"44AB"  	    0x"26B1"  	    0x"1021"  	    0x"89EC"	  true	  true  	    0x"0000"
--  CRC-16/USB	              0x"DA6F"  	    0x"B4C8"  	    0x"8005"  	    0x"FFFF"	  true	  true  	    0x"FFFF"
--  CRC-A	                    0x"6A7F"        0x"BF05"  	    0x"1021"  	    0x"C6C6"	  true	  true  	    0x"0000"
--  CRC-16/KERMIT	            0x"6A29"  	    0x"2189"  	    0x"1021"  	    0x"0000"	  true	  true  	    0x"0000"
--  CRC-16/MODBUS	            0x"2590"  	    0x"4B37"  	    0x"8005"  	    0x"FFFF"	  true	  true  	    0x"0000"
--  CRC-16/X-25	              0x"A55E"  	    0x"906E"  	    0x"1021"  	    0x"FFFF"	  true	  true  	    0x"FFFF"
--  CRC-16/XMODEM	            0x"5A76"  	    0x"31C3"  	    0x"1021"  	    0x"0000"	  false	  false 	    0x"0000"
--  
--  CRC-32	              0x"55404551"  	0x"CBF43926"  	0x"04C11DB7"  	0x"FFFFFFFF"	  true	  true  	0x"FFFFFFFF"
--  CRC-32/BZIP2	        0x"7E68D2A4"  	0x"FC891918"  	0x"04C11DB7"  	0x"FFFFFFFF"	  false	  false 	0x"FFFFFFFF"
--  CRC-32C	              0x"C3989B4C"  	0x"E3069283"  	0x"1EDC6F41"  	0x"FFFFFFFF"	  true	  true  	0x"FFFFFFFF"
--  CRC-32D	              0x"778BBC7E"  	0x"87315576"  	0x"A833982B"  	0x"FFFFFFFF"	  true	  true  	0x"FFFFFFFF"
--  CRC-32/JAMCRC	        0x"AABFBAAE"  	0x"340BC6D9"  	0x"04C11DB7"  	0x"FFFFFFFF"	  true	  true  	0x"00000000"
--  CRC-32/MPEG-2	        0x"81972D5B"  	0x"0376E6E7"  	0x"04C11DB7"  	0x"FFFFFFFF"	  false	  false 	0x"00000000"
--  CRC-32/POSIX	        0x"39786938"  	0x"765E7680"  	0x"04C11DB7"  	0x"00000000"	  false	  false 	0x"FFFFFFFF"
--  CRC-32Q	              0x"E5997626"  	0x"3010BF7F"  	0x"814141AB"  	0x"00000000"	  false	  false 	0x"00000000"
--  CRC-32/XFER 	        0x"8EE76DB6"  	0x"BD0BE338"  	0x"000000AF"  	0x"00000000"	  false	  false 	0x"00000000"
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

--Algorithm,  CRC-8,CRC-8/CDMA2000,CRC-8/DARC,CRC-8/DVB-S2,CRC-8/EBU,CRC-8/I-CODE,CRC-8/ITU,CRC-8/MAXIM,CRC-8/ROHC,CRC-8/WCDMA 
--Result,     x"1B",x"21",x"83",x"2B",x"A6",x"97",x"4E",x"3F",x"59",x"F6"
--Check,      x"F4",x"DA",x"15",x"BC",x"97",x"7E",x"A1",x"A1",x"D0",x"25"
--Poly,       x"07",x"9B",x"39",x"D5",x"1D",x"1D",x"07",x"31",x"07",x"9B"
--Init,       x"00",x"FF",x"00",x"00",x"FF",x"FD",x"00",x"00",x"FF",x"00"
--XorOut,     x"00",x"00",x"00",x"00",x"00",x"00",x"55",x"00",x"00",x"00"
--RefIn,      '0','0','1','0','1','0','0','1','1','1'
--RefOut,     '0','0','1','0','1','0','0','1','1','1'
--  
--Algorithm,  CRC-16/CCITT-FALS,CRC-16/ARC,CRC-16/AUG-CCITT,CRC-16/BUYPASS,CRC-16/CDMA2000,CRC-16/DDS-110,CRC-16/DECT-R,CRC-16/DECT-X,CRC-16/DNP,CRC-16/EN-13757,CRC-16/GENIBUS,CRC-16/MAXIM,CRC-16/MCRF4XX,CRC-16/RIELLO,CRC-16/T10-DIF,CRC-16/TELEDISK,CRC-16/TMS37157,CRC-16/USB,CRC-A,CRC-16/KERMIT,CRC-16/MODBUS,CRC-16/X-25,CRC-16/XMODEM
--Result,     x"B155",x"03C0",x"9C39",x"001E",x"1259",x"8E1D",x"13AC",x"13AD",x"10D9",x"370E",x"4EAA",x"FC3F",x"582A",x"CE19",x"39B2",x"C372",x"D29A",x"BC80",x"0653",x"57AD",x"437F",x"A7D5",x"50A5"
--Check,      x"29B1",x"BB3D",x"E5CC",x"FEE8",x"4C06",x"9ECF",x"007E",x"007F",x"EA82",x"C2B7",x"D64E",x"44C2",x"6F91",x"63D0",x"D0DB",x"0FB3",x"26B1",x"B4C8",x"BF05",x"2189",x"4B37",x"906E",x"31C3"
--Poly,       x"1021",x"8005",x"1021",x"8005",x"C867",x"8005",x"0589",x"0589",x"3D65",x"3D65",x"1021",x"8005",x"1021",x"1021",x"8BB7",x"A097",x"1021",x"8005",x"1021",x"1021",x"8005",x"1021",x"1021"
--Init,       x"FFFF",x"0000",x"1D0F",x"0000",x"FFFF",x"800D",x"0000",x"0000",x"0000",x"0000",x"FFFF",x"0000",x"FFFF",x"B2AA",x"0000",x"0000",x"89EC",x"FFFF",x"C6C6",x"0000",x"FFFF",x"FFFF",x"0000"
--XorOut,     x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0001",x"0000",x"FFFF",x"FFFF",x"FFFF",x"FFFF",x"0000",x"0000",x"0000",x"0000",x"0000",x"FFFF",x"0000",x"0000",x"0000",x"FFFF",x"0000"
--RefIn,      '0','1','0','0','0','0','0','0','1','0','0','1','1','1','0','0','1','1','1','1','1','1','0
--RefOut,     '0','1','0','0','0','0','0','0','1','0','0','1','1','1','0','0','1','1','1','1','1','1','0
--  
--Algorithm,  CRC-32,CRC-32/BZIP2,CRC-32C,CRC-32D,CRC-32/JAMCRC,CRC-32/MPEG-2,CRC-32/POSIX,CRC-32Q,CRC-32/XFER ,
--Result,     x"A2681B02",x"A6322B20",x"678C474D",x"FAF0A950",x"5D97E4FD",x"59CDD4DF",x"E83A9494",x"078785FA",x"00000213"
--Check,      x"CBF43926",x"FC891918",x"E3069283",x"87315576",x"340BC6D9",x"0376E6E7",x"765E7680",x"3010BF7F",x"BD0BE338" 
--Poly,       x"04C11DB7",x"04C11DB7",x"1EDC6F41",x"A833982B",x"04C11DB7",x"04C11DB7",x"04C11DB7",x"814141AB",x"000000AF" 
--Init,       x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"00000000",x"00000000",x"00000000" 
--XorOut,     x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"00000000",x"00000000",x"FFFFFFFF",x"00000000",x"00000000" 
--RefIn,      '1','0','1','1','1','0','0','0','0' 
--RefOut,     '1','0','1','1','1','0','0','0','0' 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package crc_pkg is

  type dataArray is array (natural range <>) of std_logic_vector;
  type boolArray is array (natural range <>) of std_logic;

  constant CRC8_MAX   : natural := 10;
  constant CRC16_MAX  : natural := 23;
  constant CRC32_MAX  : natural := 9;

  type crc8_rec is record 
    res  : dataArray(0 to CRC8_MAX-1)(7 downto 0);
    chk  : dataArray(0 to CRC8_MAX-1)(7 downto 0);
    poly : dataArray(0 to CRC8_MAX-1)(7 downto 0);
    init : dataArray(0 to CRC8_MAX-1)(7 downto 0);
    fxor : dataArray(0 to CRC8_MAX-1)(7 downto 0);
    refi : boolArray(0 to CRC8_MAX-1);
    refo : boolArray(0 to CRC8_MAX-1);
  end record crc8_rec;

  type crc16_rec is record 
    res  : dataArray(0 to CRC16_MAX-1)(15 downto 0);
    chk  : dataArray(0 to CRC16_MAX-1)(15 downto 0);
    poly : dataArray(0 to CRC16_MAX-1)(15 downto 0);
    init : dataArray(0 to CRC16_MAX-1)(15 downto 0);
    fxor : dataArray(0 to CRC16_MAX-1)(15 downto 0);
    refi : boolArray(0 to CRC16_MAX-1);
    refo : boolArray(0 to CRC16_MAX-1);
  end record crc16_rec;

  type crc32_rec is record 
    res  : dataArray(0 to CRC32_MAX-1)(31 downto 0);
    chk  : dataArray(0 to CRC32_MAX-1)(31 downto 0);
    poly : dataArray(0 to CRC32_MAX-1)(31 downto 0);
    init : dataArray(0 to CRC32_MAX-1)(31 downto 0);
    fxor : dataArray(0 to CRC32_MAX-1)(31 downto 0);
    refi : boolArray(0 to CRC32_MAX-1);
    refo : boolArray(0 to CRC32_MAX-1);
  end record crc32_rec;

  constant CRC8_TEST_VALUES : crc8_rec := (
    res  => (x"1B", x"21",  x"83",  x"2B",  x"A6",  x"97",  x"4E",  x"3F",  x"59",  x"F6"),
    chk  => (x"F4", x"DA",  x"15",  x"BC",  x"97",  x"7E",  x"A1",  x"A1",  x"D0",  x"25"),
    poly => (x"07", x"9B",  x"39",  x"D5",  x"1D",  x"1D",  x"07",  x"31",  x"07",  x"9B"),
    init => (x"00", x"FF",  x"00",  x"00",  x"FF",  x"FD",  x"00",  x"00",  x"FF",  x"00"),
    fxor => (x"00", x"00",  x"00",  x"00",  x"00",  x"00",  x"55",  x"00",  x"00",  x"00"),
    refi => ('0',     '0',    '1',    '0',    '1',    '0',    '0',    '1',    '1',    '1'),
    refo => ('0',     '0',    '1',    '0',    '1',    '0',    '0',    '1',    '1',    '1')
  );

  constant CRC16_TEST_VALUES : crc16_rec := (
    res  => (x"B155",x"03C0",x"9C39",x"001E",x"1259",x"8E1D",x"13AC",x"13AD",x"10D9",x"370E",x"4EAA",x"FC3F",x"582A",x"CE19",x"39B2",x"C372",x"D29A",x"BC80",x"0653",x"57AD",x"437F",x"A7D5",x"50A5"),
    chk  => (x"29B1",x"BB3D",x"E5CC",x"FEE8",x"4C06",x"9ECF",x"007E",x"007F",x"EA82",x"C2B7",x"D64E",x"44C2",x"6F91",x"63D0",x"D0DB",x"0FB3",x"26B1",x"B4C8",x"BF05",x"2189",x"4B37",x"906E",x"31C3"),
    poly => (x"1021",x"8005",x"1021",x"8005",x"C867",x"8005",x"0589",x"0589",x"3D65",x"3D65",x"1021",x"8005",x"1021",x"1021",x"8BB7",x"A097",x"1021",x"8005",x"1021",x"1021",x"8005",x"1021",x"1021"),
    init => (x"FFFF",x"0000",x"1D0F",x"0000",x"FFFF",x"800D",x"0000",x"0000",x"0000",x"0000",x"FFFF",x"0000",x"FFFF",x"B2AA",x"0000",x"0000",x"89EC",x"FFFF",x"C6C6",x"0000",x"FFFF",x"FFFF",x"0000"),
    fxor => (x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0001",x"0000",x"FFFF",x"FFFF",x"FFFF",x"FFFF",x"0000",x"0000",x"0000",x"0000",x"0000",x"FFFF",x"0000",x"0000",x"0000",x"FFFF",x"0000"),
    refi => ('0','1','0','0','0','0','0','0','1','0','0','1','1','1','0','0','1','1','1','1','1','1','0'),
    refo => ('0','1','0','0','0','0','0','0','1','0','0','1','1','1','0','0','1','1','1','1','1','1','0')
  );

  constant CRC32_TEST_VALUES : crc32_rec := (
    res  => (x"A2681B02",x"A6322B20",x"678C474D",x"FAF0A950",x"5D97E4FD",x"59CDD4DF",x"E83A9494",x"078785FA",x"00000213"),
    chk  => (x"CBF43926",x"FC891918",x"E3069283",x"87315576",x"340BC6D9",x"0376E6E7",x"765E7680",x"3010BF7F",x"BD0BE338"),
    poly => (x"04C11DB7",x"04C11DB7",x"1EDC6F41",x"A833982B",x"04C11DB7",x"04C11DB7",x"04C11DB7",x"814141AB",x"000000AF"),
    init => (x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"00000000",x"00000000",x"00000000"),
    fxor => (x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"FFFFFFFF",x"00000000",x"00000000",x"FFFFFFFF",x"00000000",x"00000000"),
    refi => ('1','0','1','1','1','0','0','0','0'),
    refo => ('1','0','1','1','1','0','0','0','0')
  );


end package crc_pkg;

