library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iteration_counter is
generic(
	max_iterations: integer := 100
);
port(
	clk: in std_logic;
	reset: in std_logic;
	x, y: in std_logic_vector(9 downto 0);
	Cre_in, Cim_in: in std_logic_vector(31 downto 0);
	
	xout, yout: out std_logic_vector(9 downto 0);
	count: buffer std_logic_vector(31 downto 0);
	clk_mem: out std_logic := '0';
	done: buffer std_logic := '1'
);
end;

architecture arch of iteration_counter is
	signal Zre: std_logic_vector(31 downto 0) := Cre_in;
	signal Zim: std_logic_vector(31 downto 0) := Cim_in;
	signal Cre: std_logic_vector(31 downto 0) := Cre_in;
	signal Cim: std_logic_vector(31 downto 0) := Cim_in;

	signal Zre2, Zim2: std_logic_vector(31 downto 0) := (others => '0');
	signal next_Zre, next_Zim: std_logic_vector(31 downto 0) := (others => '0');
	
	signal has_escaped: std_logic := '0';
begin
	MULT: entity work.complex_multiplier
	port map(
		clk => clk,
		areset => '0',
		a => Zre,  b => Zim,
		c => Zre,  d => Zim,
		q => Zre2, r => Zim2
	);

	ADD_RE: entity work.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Zre2,
		b => Cre,
		q => next_Zre
	);
	
	ADD_IM: entity work.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Zim2,
		b => Cim,
		q => next_Zim
	);
	
	has_escaped <= Zre(30) or Zim(30); -- exp >= 1
	
	process (clk)
		variable i: integer := 0;
	begin
		if rising_edge(clk)
		then
			if reset = '1'
			then
				Zre <= Cre_in;
				Zim <= Cim_in;
				Cre <= Cre_in;
				Cim <= Cim_in;
				xout <= x;
				yout <= y;
				count <= std_logic_vector(to_unsigned(0, count'length));
				clk_mem <= '0';
				done <= '0';

				i := 0;
			elsif unsigned(count) < max_iterations and has_escaped = '0' and done = '0'
			then
				Zre <= Zre;
				Zim <= Zim;
				Cre <= Cre;
				Cim <= Cim;
				xout <= xout;
				yout <= yout;
				count <= count;
				clk_mem <= '0';
				done <= '0';
			
				i := i + 1;
				if i >= 32
				then
					count <= std_logic_vector(unsigned(count) + 1);
					Zre <= next_Zre;
					Zim <= next_Zim;
					i := 0;
				end if;
			else
				Zre <= Zre;
				Zim <= Zim;
				Cre <= Cre;
				Cim <= Cim;
				xout <= xout;
				yout <= yout;
				count <= count;
				
				case i is
					when 0|1|2 => done <= '0';
					when others => done <= '1';
				end case;
				
				case i is
					when 0|2 => clk_mem <= '1';
					when others => clk_mem <= '0';
				end case;
				
				if i < 3
				then
					i := i + 1;
				end if;
			end if;
		end if;
	end process;
end;