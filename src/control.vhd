library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity control is

	port(instr: in std_logic_vector(5 downto 0);
		 reg_dst : out std_logic;
		 branch: out std_logic;
		 jump : out std_logic;
		 MemRead : out std_logic;
		 MemtoReg : out std_logic;
		 MemWrite : out std_logic;
		 ALUSrc : out std_logic;
		 RegWrite : out std_logic;
		 ALUOp : out std_logic_vector(1 downto 0);
		 branch_s : out std_logic);
end control;


architecture Behavioral of control is
begin
	process(instr)
	begin
		branch_s <= '1';
		case instr is
			when "000000" => -- R type
				reg_dst <= '1';
				branch <= '0';
				jump <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				RegWrite <= '1';
				ALUOp <= "10";
				
			when "100011" => -- LW
				reg_dst <= '0';
				branch <= '0';
				jump <= '0';
				MemRead <= '1';
				MemtoReg <= '1';
				MemWrite <= '0';
				ALUSrc <= '1';
				RegWrite <= '1';
				ALUOp <= "00";
				
			when "000100" => -- BEQ
				reg_dst <= '0'; -- X
				branch <= '1';
				jump <= '0';
				MemRead <= '0';
				MemtoReg <= '0'; -- X
				MemWrite <= '0';
				ALUSrc <= '0';
				RegWrite <= '0';
				ALUOp <= "01";
				branch_s <= '1';
				
			when "000101" => -- BEQ
				reg_dst <= '0'; -- X
				branch <= '1';
				jump <= '0';
				MemRead <= '0';
				MemtoReg <= '0'; -- X
				MemWrite <= '0';
				ALUSrc <= '0';
				RegWrite <= '0';
				ALUOp <= "01";
				branch_s <= '0';
				
			when "101011" => -- SW
				reg_dst <= '1';
				branch <= '0';
				jump <= '0';
				MemRead <= '0';
				MemtoReg <= '0'; -- X
				MemWrite <= '1';
				ALUSrc <= '1';
				RegWrite <= '0';
				ALUOp <= "00";
				
			when "000010" => -- J
				reg_dst <= '0'; --X
				branch <= '0';
				jump <= '1';
				MemRead <= '0';
				MemtoReg <= '0'; -- X
				MemWrite <= '0';
				ALUSrc <= '0'; --X
				RegWrite <= '0';
				ALUOp <= "00"; --XX
			
			when "001000" => -- addi
				reg_dst <= '0'; 
				branch <= '0';
				jump <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '1'; 
				RegWrite <= '1';
				ALUOp <= "00";
			
			when others => 
				reg_dst <= '0'; 
				branch <= '0';
				jump <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0'; 
				RegWrite <= '0';
				ALUOp <= "00";
				
		end case;
	end process;
	
end Behavioral;