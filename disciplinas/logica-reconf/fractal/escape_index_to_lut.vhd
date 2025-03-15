library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity escape_index_to_lut is
generic(
	lim: integer := 100
);
port(
	i_in: in std_logic_vector(31 downto 0);
	i_out: out std_logic_vector(1 downto 0)
);
end;

architecture arch of escape_index_to_lut is
begin
	i_out <= "00" when unsigned(i_in) >= lim else
				"01" when unsigned(i_in) >= (lim-10) else
				"10" when unsigned(i_in) >= (lim-40) else
				"11";
end;
