library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fractal_gen is
generic(
	max_iterations: integer := 100
);
port(
	clk: in std_logic;
	reset: in std_logic;
	
	re0: in std_logic_vector(31 downto 0);
	im0: in std_logic_vector(31 downto 0);
	inc_re: in std_logic_vector(31 downto 0);
	inc_im: in std_logic_vector(31 downto 0);
	
	x, y: buffer std_logic_vector(9 downto 0);
	count: buffer std_logic_vector(31 downto 0);
	clk_mem: buffer std_logic := '0';
	done: buffer std_logic := '0'
);
end;

architecture arch of fractal_gen is
	type state_type is (JUST_RESET, COMPUTING, WRITING, MOVING, FINISHED);
	signal curr_state: state_type := JUST_RESET;
	
	-- Variaveis da recorrencia
	signal Cre, Cim: std_logic_vector(31 downto 0);
	signal Zre, Zim: std_logic_vector(31 downto 0);

	-- Saidas de circuitos aritimeticos
	signal next_Cre, next_Cim: std_logic_vector(31 downto 0);
	signal next_Zre, next_Zim: std_logic_vector(31 downto 0);
	signal Zre2, Zim2: std_logic_vector(31 downto 0);
	
	signal has_escaped: std_logic;
begin
	process (clk)
		variable i: integer range 0 to 63 := 0;
	begin	
		if rising_edge(clk) then
			if reset = '1' then
				curr_state <= JUST_RESET;
			end if;

			case curr_state is
				when JUST_RESET =>
					Cre <= re0;
					Cim <= im0;
					x <= (others => '0');
					y <= (others => '0');
					clk_mem <= '0';
					done <= '0';

					if i < 3 then
						i := i + 1;
					else
						curr_state <= COMPUTING;
						i := 0;
					end if;
				
				when COMPUTING =>
					-- invariante: Cre e Cim validos na entrada
					--             count valido na saida
					if i = 0 then
						Zre <= Cre;
						Zim <= Cim;
						count <= (others => '0');
						i := 1;
					elsif unsigned(count) >= max_iterations or has_escaped = '1' then
						curr_state <= WRITING;
						i := 0;
					elsif i < 33 then
						i := i + 1; -- espera propagar pelo circuito da recorrencia
					else
						Zre <= next_Zre;
						Zim <= next_Zim;
						i := 1;
						count <= std_logic_vector(unsigned(count) + 1);
					end if;

				when WRITING =>
					case i is
						when 0 => 
							clk_mem <= '1';
							i := i + 1;
						when 1 => 
							clk_mem <= '0';
							i := i + 1;
						when others =>
							curr_state <= MOVING; 
							i := 0;
					end case;

				when MOVING =>
					if i < 12 then
						i := i + 1;
					else
						if x = std_logic_vector(to_unsigned(639, x'length)) and y = std_logic_vector(to_unsigned(479, x'length)) then
							curr_state <= FINISHED;
							i := 0;
						elsif x = std_logic_vector(to_unsigned(639, x'length)) then
							x <= (others => '0');
							y <= std_logic_vector(unsigned(y) + 1);
							Cre <= re0;
							Cim <= next_Cim;
							curr_state <= COMPUTING;
							i := 0;
						else
							x <= std_logic_vector(unsigned(x) + 1);
							Cre <= next_Cre;
							curr_state <= COMPUTING;
							i := 0;
						end if;
					end if;
				
				when FINISHED =>
					done <= '1';
			end case;
		end if;
	end process;
	
	-- Se a orbita escapou da regiao -2 < re,im < 2
	has_escaped <= Zre(30) or Zim(30); -- exp >= 1
	
	-- ADDER para calcular o proximo C, toma 12 ciclos de clock
	ADD_CREAL: entity work.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Cre,
		b => inc_re,
		q => next_Cre
	);
	
	ADD_CIMAGINARY: entity work.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Cim,
		b => inc_im,
		q => next_Cim
	);	
	
	-- Circuitaria para calcular a recorrencia, toma 32 ciclos de clock
	-- next Z = Z^2 + C
	COMPLEX_MULT_Z2: entity work.complex_multiplier
	port map(
		clk => clk,
		areset => '0',
		a => Zre,  b => Zim,
		c => Zre,  d => Zim,
		q => Zre2, r => Zim2
	);

	ADD_Z2_C_REAL: entity work.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Zre2,
		b => Cre,
		q => next_Zre
	);
	
	ADD_Z2_C_IMAGINARY: entity work.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Zim2,
		b => Cim,
		q => next_Zim
	);
end;