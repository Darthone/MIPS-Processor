
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity branch_gate is
	port(branch_s, branch_c, zero: in std_logic;
		 branch: out std_logic);
end branch_gate;


architecture Behavioral of branch_gate is
begin
	process(branch_c, branch_s, zero)
	begin
		if branch_c = '1' then
			if branch_s = '1' then -- beq
				branch <= zero;
			else --bne
				branch <= not zero;
			end if;
		else
			branch <= '0';
		end if;
	end process;
	
end Behavioral;
