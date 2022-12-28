library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
port(
	a, b, ci: in std_logic;
	co, s: out std_logic
);
end full_adder;

architecture synth of full_adder is 
begin
	co <= not ((not (b and a) and not(ci)) or not(a or b));
	s <= ( (a or b) and not (b and a)) xor ci;
end synth;
