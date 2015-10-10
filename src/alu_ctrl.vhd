library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_ctrl is

	port(funct : in std_logic_vector(5 downto 0);
		 alu_op : in std_logic_vector(1 downto 0);
		 alu_ctrl_out: out std_logic_vector(3 downto 0));
end alu_ctrl;


architecture Behavioral of alu_ctrl is
begin
	process(alu_op, funct)
	begin
		case alu_op is
			when "00" => -- lw /sw
				alu_ctrl_out <= "0010";
			when "01" => -- beq
				alu_ctrl_out <= "0110";
			when "10" => -- r type
				case funct is
					when "100000" => -- add
						alu_ctrl_out <= "0010";
					when "000000" => -- sll
						alu_ctrl_out <= "0011";
					when "100010" => -- sub
						alu_ctrl_out <= "0110";
					when "100100" => -- and
						alu_ctrl_out <= "0000";
					when "100101" => -- or
						alu_ctrl_out <= "0001";
					when "101010" => -- set on less than
						alu_ctrl_out <= "0111";
					when others =>
						alu_ctrl_out <= "0000";
				end case;
			when others => 
				alu_ctrl_out <= "0000";
		end case;
	end process;
end Behavioral;