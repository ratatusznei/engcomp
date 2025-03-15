library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
generic(
	q_width: natural := 19;
	q_modulus: natural := 307_200
);
port(
	clk: in std_logic;
	q: out std_logic_vector(q_width-1 downto 0)
);
end;

architecture behav of counter is
	signal counter: integer range 0 to q_modulus+1 := 0;
	
begin
	process (clk)
	begin
		if rising_edge(clk)
		then
			if counter = q_modulus then
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	q <= std_logic_vector(to_unsigned(counter, q'length));
end;