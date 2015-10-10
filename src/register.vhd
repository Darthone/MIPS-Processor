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


entity registers is
	port (
		reg_write, ck : in std_logic;
		reg_reg1, reg_reg2, write_reg : in STD_LOGIC_VECTOR (4 downto 0);
		write_data : in STD_LOGIC_VECTOR (31 downto 0);
		read_data1, read_data2 : out STD_LOGIC_VECTOR (31 downto 0));
end registers;

architecture behavioral of registers is	  
	type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
	
	signal data_mem: mem_array := (
		X"00000000", -- initialize data memory
		X"00000000", -- mem 1
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000", 
		X"00000000", -- mem 10 
		X"00000000", 
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",  
		X"00000000", -- mem 20
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000", 
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000", 
		X"00000000", -- mem 30
		X"00000000");
		
	begin
	
	read_data1 <= data_mem(conv_integer(reg_reg1));
	read_data2 <= data_mem(conv_integer(reg_reg2));
	
	process(reg_write, write_data, ck, reg_reg1, reg_reg2, write_reg, write_data)
	begin
		if ck = '0' and ck'event then
			if (reg_write = '1') then
				data_mem(conv_integer(write_reg)) <= write_data;
			end if;
		end if;
	end process;

end behavioral;