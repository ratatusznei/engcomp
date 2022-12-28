library ieee;
use ieee.std_logic_1164.all;

entity lab is
port(
	MAX10_CLK1_50: in std_ulogic;
	MAX10_CLK2_50: in std_ulogic;
	SW: in std_ulogic_vector(0 to 9);
	KEY: in std_ulogic_vector(0 to 1);

	LEDR: out std_ulogic_vector(0 to 9) := (others => 'Z');
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_ulogic_vector(0 to 7) := (others => 'Z');

	GPIO: in std_ulogic_vector(0 to 35);
	ARDUINO_IO: in std_ulogic_vector(0 to 15);
	ARDUINO_RESET_N: out std_ulogic := 'H';

	VGA_HS, VGA_VH: in std_ulogic;
	VGA_R, VGA_G, VGA_B: out std_ulogic_vector(0 to 3) := (others => 'Z')
);
end;

architecture top_level of lab is
begin
end;
