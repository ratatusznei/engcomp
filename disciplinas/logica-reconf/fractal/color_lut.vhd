library ieee;
use ieee.std_logic_1164.all;

entity color_lut is
port(
	index: in std_logic_vector(1 downto 0);
	r, g, b: out std_logic_vector(3 downto 0)
);
end;

architecture comb of color_lut is
	signal rgb: std_logic_vector(11 downto 0);
begin
	r <= rgb(11 downto 8);
	g <= rgb(7 downto 4);
	b <= rgb(3 downto 0);

	process (index) is
	begin
		case index is
			when "00" => rgb <= x"FFF";
			when "01" => rgb <= x"F00";
			when "10" => rgb <= x"00F";
			when "11" => rgb <= x"000";
		end case;	
	end process;
end;