
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity jump_adder is
	port(sign_ext_addr, pc : in std_logic_vector(31 downto 0);
		 branch_addr: out std_logic_vector(31 downto 0));
end jump_adder;


architecture Behavioral of jump_adder is
begin
	process(pc, sign_ext_addr)
	begin
		branch_addr <= sign_ext_addr + pc;
	end process;
	
end Behavioral;
