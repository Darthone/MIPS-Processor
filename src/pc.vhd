library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity pc is
	port(ck : in std_logic);
end pc;


architecture Behavioral of pc is

	component control is
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
	end component;
	
	component instr_memory is
		port (
			read_address: in STD_LOGIC_VECTOR (31 downto 0);
			instruction: out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component memory is
		port (
			address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
			MemWrite, MemRead,ck: in STD_LOGIC;
			read_data: out STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	component alu_ctrl is
		port(funct : in std_logic_vector(5 downto 0);
			alu_op : in std_logic_vector(1 downto 0);
			alu_ctrl_out: out std_logic_vector(3 downto 0));
	end component;
	
	component jump_adder is
		port(sign_ext_addr, pc : in std_logic_vector(31 downto 0);
			 branch_addr: out std_logic_vector(31 downto 0));
	end component;

	component jump_shifter is
		port(jump_im : in std_logic_vector(25 downto 0);
			pc : in std_logic_vector(3 downto 0);
			jump_addr: out std_logic_vector(31 downto 0));
	end component;

	component alu is
		port(input0, input1 : in std_logic_vector(31 downto 0);
			 alu_ctrl : in std_logic_vector(3 downto 0);
			 shamt : in std_logic_vector(4 downto 0);
			 output: out std_logic_vector(31 downto 0);
			 zero : out std_logic);
	end component;

	component sign_ext_shifter is
		port(sign_ext_im : in std_logic_vector(31 downto 0);
			 sign_ext_addr: out std_logic_vector(31 downto 0));
	end component;

	component mux is
		generic (n: natural);
		port(input0, input1 : in std_logic_vector(n-1 downto 0);
			 sel : in std_logic;
			 output: out std_logic_vector(n-1 downto 0));
	end component;

	component pc_adder is
		port(cur_addr : in std_logic_vector(31 downto 0);
			 next_addr: out std_logic_vector(31 downto 0));
	end component;
	
	component registers is
		port (
			reg_write, ck : in std_logic;
			reg_reg1, reg_reg2, write_reg : in STD_LOGIC_VECTOR (4 downto 0);
			write_data : in STD_LOGIC_VECTOR (31 downto 0);
			read_data1, read_data2 : out STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component sign_ext is
		port(im : in std_logic_vector(15 downto 0);
			 im_ext: out std_logic_vector(31 downto 0));
	end component;
	
	
	component branch_gate is
		port(branch_s, branch_c, zero: in std_logic;
			 branch: out std_logic);
	end component;
	
	--instr
	signal instr_31_0 : std_logic_vector(31 downto 0) := X"00000000"; 
	signal instr_25_0 : std_logic_vector(25 downto 0);
	signal instr_31_26 : std_logic_vector(5 downto 0);
	signal instr_25_21 : std_logic_vector(4 downto 0);
	signal instr_20_16 : std_logic_vector(4 downto 0);
	signal instr_15_11 : std_logic_vector(4 downto 0);
	signal instr_10_6 : std_logic_vector(4 downto 0);
	signal instr_15_0 : std_logic_vector(15 downto 0);
	signal instr_5_0 : std_logic_vector(5 downto 0);
	
	--control
	signal regdst_c : std_logic := '0';
	signal jump_c : std_logic := '0';
	signal branch_c: std_logic := '0';
	signal branch_s_c: std_logic := '0';
	signal memread_c : std_logic := '0';
	signal memtoreg_c: std_logic := '0';
	signal memwrite_c : std_logic := '0';
	signal alusrc_c : std_logic := '0';
	signal regwrite_c : std_logic := '0';
	signal aluop_c : std_logic_vector(1 downto 0) := "00";
	
	--reg
	signal write_reg : std_logic_vector(4 downto 0) := "00000";
	signal read_data1 : std_logic_vector(31 downto 0) := X"00000000";
	signal read_data2 : std_logic_vector(31 downto 0) := X"00000000";
	
	signal signext_val : std_logic_vector(31 downto 0) := X"00000000";
	
	--alu
	signal alusrc2 : std_logic_vector(31 downto 0) := X"00000000";
	signal aluctrl : std_logic_vector(3 downto 0) := "0000";
	signal alures : std_logic_vector(31 downto 0) := X"00000000";
	signal aluzero : std_logic := '0';
	
	
	--main mem
	signal read_data_m : std_logic_vector(31 downto 0) := X"00000000";
	signal memtoreg_val : std_logic_vector(31 downto 0) := X"00000000";
	
	-- jump/branch stuff
	signal pc_inc_val : std_logic_vector(31 downto 0) := X"00000000";
	signal pc_31_28 :  std_logic_vector(3 downto 0) := "0000";
	signal jump_shift_val : std_logic_vector(31 downto 0) := X"00000000";
	signal signext_shift_val : std_logic_vector(31 downto 0) := X"00000000";
	signal jump_alu_val : std_logic_vector(31 downto 0) := X"00000000";
	signal branch_sel : std_logic := '0';
	signal branch_mux_val : std_logic_vector(31 downto 0) := X"00000000";
	
	
	 signal next_addr : std_logic_vector(31 downto 0) := X"00000000";
	 signal addr: std_logic_vector(31 downto 0)  := X"00000000";
begin
	instr_mem : instr_memory
		port map(addr, instr_31_0);
		
	ctrl : control
		port map(instr_31_26, regdst_c, branch_c, jump_c, memread_c, memtoreg_c, memwrite_c, alusrc_c, regwrite_c, aluop_c, branch_s_c);
	
	reg_mux : mux
		generic map (5) port map (instr_20_16, instr_15_11, regdst_c, write_reg);
	
	regs : registers
		port map(regwrite_c, ck, instr_25_21, instr_20_16, write_reg, memtoreg_val, read_data1, read_data2);
		
	pc_add : pc_adder
		port map(addr, pc_inc_val);
		
	sign_e : sign_ext
		port map(instr_15_0, signext_val);
	
	sign_e_s : sign_ext_shifter
		port map (signext_val, signext_shift_val);
		
	j_addr : jump_adder
		port map(pc_inc_val, signext_shift_val, jump_alu_val);
		
	b_mux : mux
		generic map(32) port map(pc_inc_val, jump_alu_val, branch_sel, branch_mux_val);
	
	b_gate : branch_gate
		port map(branch_s_c, branch_c, aluzero, branch_sel);
	
	j_mux : mux
		generic map(32) port map(branch_mux_val, jump_shift_val, jump_c, next_addr);
	
	alu_co : alu_ctrl
		port map(instr_5_0, aluop_c, aluctrl);
	
	j_shifter : jump_shifter
		port map(instr_25_0, pc_31_28, jump_shift_val);
	
	alu_mux : mux
		generic map(32) port map (read_data2, signext_val, alusrc_c, alusrc2);
		
	alu_c : alu
		port map (read_data1, alusrc2, aluctrl, instr_10_6, alures, aluzero);
	
	main_mem : memory
		port map(alures, read_data2, memwrite_c, memread_c, ck, read_data_m);
		
	mem_mux : mux
		generic map(32) port map (alures, read_data_m, memtoreg_c, memtoreg_val);
		

	instr_25_0 <= instr_31_0(25 downto 0);
	instr_31_26 <= instr_31_0(31 downto 26);
	instr_25_21 <= instr_31_0(25 downto 21);
	instr_20_16 <= instr_31_0(20 downto 16);
	instr_15_11 <= instr_31_0(15 downto 11);
	instr_15_0 <= instr_31_0(15 downto 0);
	instr_10_6 <= instr_31_0(10 downto 6);
	instr_5_0 <= instr_31_0(5 downto 0);
	pc_31_28 <= pc_inc_val(31 downto 28);
		
	process(ck)	
	begin
		if ck = '0' and ck'event then
			addr <= next_addr;
		end if;
	end process;
end Behavioral;





