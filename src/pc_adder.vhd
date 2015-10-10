
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity pc_adder is
	port(cur_addr : in std_logic_vector(31 downto 0);
		 next_addr: out std_logic_vector(31 downto 0));
end pc_adder;


architecture Behavioral of pc_adder is
begin
	process(cur_addr)
	begin
		next_addr <= cur_addr + 4;
	end process;
end Behavioral;


