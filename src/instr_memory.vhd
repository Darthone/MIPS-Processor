------------------------------------------------------
-- ECEC 355 Computer Architecture
-- MIPS Single Cycle Datapath
-- Cem Sahin - 08/04/2009
-- modified 07/21/2015
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity instr_memory is
	port (
		read_address: in STD_LOGIC_VECTOR (31 downto 0);
		instruction: out STD_LOGIC_VECTOR (31 downto 0));
end instr_memory;

architecture behavioral of instr_memory is	  
	type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

	signal data_mem: mem_array := (
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000");
	begin
	
	process(read_address)
	begin
		instruction <= data_mem(conv_integer(read_address(6 downto 2)));
	end process;


end behavioral;