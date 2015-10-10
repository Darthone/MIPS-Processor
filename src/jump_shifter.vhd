
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity jump_shifter is
	--generic (n: natural);
	port(jump_im : in std_logic_vector(25 downto 0);
		 pc : in std_logic_vector(3 downto 0);
		 jump_addr: out std_logic_vector(31 downto 0));
end jump_shifter;


architecture Behavioral of jump_shifter is

begin
	process(pc, jump_im)
	begin
		jump_addr <= pc & jump_im & "00";
	end process;
	
end Behavioral;
