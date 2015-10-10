library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity alu is

	port(input0, input1 : in std_logic_vector(31 downto 0);
		 alu_ctrl : in std_logic_vector(3 downto 0);
		 shamt : in std_logic_vector(4 downto 0);
		 output: out std_logic_vector(31 downto 0);
		 zero : out std_logic);
end alu;


architecture Behavioral of alu is
begin
	process(alu_ctrl, input0, input1)
	begin
		case alu_ctrl is
			when "0000" => -- and
				output <= input0 and input1;
			when "0001" => -- or
				output <= input0 or input1;
			when "0010" => -- add
				output <= input0 + input1;
			when "0011" => -- sll
				output <= to_stdlogicvector(to_bitvector(input0) sla conv_integer(shamt));
				--output <= std_logic_vector((shl(conv_integer(input0), conv_integer(shamt))));
				--output <= input0 sll conv_integer(shamt);
			when "0110" => -- subtract
				output <= input0 - input1;
			when "0111" => -- set-on-less-than
				if input0 < input1 then
					output <= "00000000000000000000000000000001"; -- & (input0 < input1);
				else 
					output <= "00000000000000000000000000000000";
				end if;
			when "1100" => -- nor
				output <= input0 nor input1;
			when others => 
				output <= "00000000000000000000000000000000";
		end case;
		
		if input0 = input1 then
			zero <= '1';
		else 
			Zero <= '0';
		end if;
	end process;
	
	
end Behavioral;