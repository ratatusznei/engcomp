library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xy_to_address is
port(
	x, y: in std_logic_vector(9 downto 0);
	address: out std_logic_vector(18 downto 0)
);
end;

architecture arch of xy_to_address is
	signal a: std_logic_vector(19 downto 0);
begin
	a <= std_logic_vector(unsigned(x) + unsigned(y) * 640);
	address <= a(18 downto 0);
end;