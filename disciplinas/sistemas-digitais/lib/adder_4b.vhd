library ieee;
use ieee.std_logic_1164.all;

entity adder_4b is
port(
	a, b: in std_logic_vector(3 downto 0);
	s: out std_logic_vector(3 downto 0);
	ci: in std_logic;
	co: out std_logic
);
end adder_4b;

architecture flux of adder_4b is
	signal c01, c12, c23: std_logic;
begin
	adder0: entity work.full_adder port map(
		a => a(0), b => b(0), ci => ci,
		co => c01, s => s(0)
	);
	adder1: entity work.full_adder port map(
		a => a(1), b => b(1), ci => c01,
		co => c12, s => s(1)
	);
	adder2: entity work.full_adder port map(
		a => a(2), b => b(2), ci => c12,
		co => c23, s => s(2)
	);
	adder3: entity work.full_adder port map(
		a => a(3), b => b(3), ci => c23,
		co => co, s => s(3)
	);
end flux;