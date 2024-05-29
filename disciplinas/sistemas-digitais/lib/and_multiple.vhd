library ieee;
use ieee.std_logic_1164.all;

entity and_multiple is
	port(
		x: in std_ulogic_vector;
		y: out std_ulogic
	);
end;

architecture arch of and_multiple is
begin
	process (x)
		variable t: std_ulogic := '1';
	begin
		for j in x'range loop
			t := t and x(j);
		end loop;
		y <= t after 5 ns;
	end process;
end arch;
