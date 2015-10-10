
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sign_ext is
	port(im : in std_logic_vector(15 downto 0);
		 im_ext: out std_logic_vector(31 downto 0));
end sign_ext;


architecture Behavioral of sign_ext is
begin
	process(im)
	begin
		im_ext <= "0000000000000000" & im;
	end process;
end Behavioral;