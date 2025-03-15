library ieee;
use ieee.std_logic_1164.all;

library complex_multiplier;
library floating_adder;

entity fractal_function is
port(
	clk, start: in std_logic;
	
	Zre, Zim: in std_logic_vector(31 downto 0);
	Cre, Cim: in std_logic_vector(31 downto 0);
	
	Rre, Rim: out std_logic_vector(31 downto 0);
	
	done: out std_logic
);
end;

architecture arch of fractal_function is
	signal Zre2, Zim2: std_logic_vector(31 downto 0);
begin
	-- implements Z^2 + C

	MULT: entity complex_multiplier.complex_multiplier
	port map (
		clk => clk,
		areset => '0',
		a => Zre,
		b => Zim,
		c => Zre,
		d => Zim,
		q => Zre2,
		r => Zim2
	);
	
	ADD_RE: entity floating_adder.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Zre2,
		b => Cre,
		q => Rre
	);
	
	ADD_IM: entity floating_adder.floating_adder
	port map (
		clk => clk,
		areset => '0',
		a => Zim2,
		b => Cim,
		q => Rim
	);
end;