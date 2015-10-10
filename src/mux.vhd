library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux is
	generic (n: natural);
	port(input0, input1 : in std_logic_vector(n-1 downto 0);
		 sel : in std_logic;
		 output: out std_logic_vector(n-1 downto 0));
end mux;


architecture Behavioral of mux is
begin
	output <= input0 when (sel = '0') else input1;
	--process(sel, input0, input1)
	--begin
	--	case sel is
	--		when '0' =>
	--			output <= input0;
	--		when '1' => 
	--			output <= input1;
	--		when others =>
	--			output <= input0;
	--	end case;
	--end process;

end Behavioral;
