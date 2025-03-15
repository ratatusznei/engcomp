library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_coordinate_generator is
port(
	clk: in std_logic;
	reset: in std_logic;
	request_pin: in std_logic;
	
	re0: in std_logic_vector(31 downto 0);
	im0: in std_logic_vector(31 downto 0);
	inc_re: in std_logic_vector(31 downto 0);
	inc_im: in std_logic_vector(31 downto 0);
	
	x, y: buffer std_logic_vector(9 downto 0) := (others => '0');
	Cre, Cim: buffer std_logic_vector(31 downto 0) := x"bf800000";
	new_coordinate_clk: out std_logic := '0';
	done: buffer std_logic := '0'
);
end;

architecture arch of complex_coordinate_generator is	
	signal next_Cre, next_Cim: std_logic_vector(31 downto 0) := (others => '0');
begin
	ADD_RE: entity work.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Cre,
		b => inc_re,
		q => next_Cre
	);
	
	ADD_IM: entity work.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Cim,
		b => inc_im,
		q => next_Cim
	);

	process (clk) is
		variable i: integer := 0;
		variable just_reset: integer := 1;
	begin
		if rising_edge(clk)
		then
			if reset = '1' or done = '1'
			then
				Cre <= re0;
				Cim <= im0;
				x <= (others => '0');
				y <= (others => '0');
				done <= '0';
				new_coordinate_clk <= '0';
				
				just_reset := 1;
				i := 0;
			elsif just_reset = 1
			then
				if i < 12
				then
					Cre <= re0;
					Cim <= im0;
					x <= (others => '0');
					y <= (others => '0');
					done <= '0';
					new_coordinate_clk <= '0';
				
					just_reset := 1;
					i := i + 1;
				else
					Cre <= re0;
					Cim <= im0;
					x <= (others => '0');
					y <= (others => '0');
					done <= '0';
					new_coordinate_clk <= '0';
				
					just_reset := 0;
					i := 0;
				end if;
			elsif unsigned(y) > 480
			then
				Cre <= Cre;
				Cim <= Cim;
				x <= x;
				y <= y;
				done <= '1';
				new_coordinate_clk <= '0';

				i := 0;
			elsif unsigned(x) = 640
			then
				if i < 12
				then
					Cre <= Cre;
					Cim <= Cim;
					x <= x;
					y <= y;
					done <= done;
					new_coordinate_clk <= '0';
				
					i := i + 1;
				elsif i < 14 and request_pin = '1'
				then
					Cre <= Cre;
					Cim <= Cim;
					x <= x;
					y <= y;
					done <= done;
					new_coordinate_clk <= '1';
					
					i := i + 1;
				elsif i = 12 and request_pin = '0'
				then
					Cre <= Cre;
					Cim <= Cim;
					x <= x;
					y <= y;
					done <= done;
					new_coordinate_clk <= '0';
					
					i := 12;
				else
					Cre <= re0;
					Cim <= next_Cim;
					x <= std_logic_vector(to_unsigned(0, x'length));
					y <= std_logic_vector(unsigned(y)+1);
					done <= done;
					new_coordinate_clk <= '0';					
					
					i := 0;
				end if;
			else
				if i < 12
				then
					Cre <= Cre;
					Cim <= Cim;
					x <= x;
					y <= y;
					done <= done;
					new_coordinate_clk <= '0';

					i := i + 1;
				elsif i < 14 and request_pin = '1'
				then
					Cre <= Cre;
					Cim <= Cim;
					x <= x;
					y <= y;
					done <= done;
					new_coordinate_clk <= '1';
					
					i := i + 1;
				elsif i = 12 and request_pin = '0'
				then
					Cre <= Cre;
					Cim <= Cim;
					x <= x;
					y <= y;
					done <= done;
					new_coordinate_clk <= '0';
					
					i := 12;
				else
					Cre <= next_Cre;
					Cim <= Cim;
					x <= std_logic_vector(unsigned(x)+1);
					y <= y;
					done <= done;
					new_coordinate_clk <= '0';

					i := 0;
				end if;
			end if;
		end if;
	end process;
end;