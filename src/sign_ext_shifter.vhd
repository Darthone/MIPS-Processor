
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sign_ext_shifter is
	--generic (n: natural);
	port(sign_ext_im : in std_logic_vector(31 downto 0);
		 sign_ext_addr: out std_logic_vector(31 downto 0));
end sign_ext_shifter;


architecture Behavioral of sign_ext_shifter is
begin
	process(sign_ext_im)
	begin
		sign_ext_addr <= sign_ext_im(29 downto 0) & "00";
	end process;
end Behavioral;
