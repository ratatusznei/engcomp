library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_480 is
port(
	x, y: in std_logic_vector(9 downto 0);
	q: out std_logic
);
end;

architecture comb of comparator_480 is
begin
	q <= '1' when unsigned(x) = 0 and unsigned(y) = 480 else '0';
end;