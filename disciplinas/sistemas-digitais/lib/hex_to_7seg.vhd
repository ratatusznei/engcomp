library ieee;
use ieee.std_logic_1164.all;

entity hex_to_7seg is
port(
	hex0: in std_logic;
	hex1: in std_logic;
	hex2: in std_logic;
	hex3: in std_logic;
	
	segs0: out std_logic;
	segs1: out std_logic;
	segs2: out std_logic;
	segs3: out std_logic;
	segs4: out std_logic;
	segs5: out std_logic;
	segs6: out std_logic
);
end;

architecture flow of hex_to_7seg is
begin
	segs0 <= (not(hex3) and not(hex1) and (hex2 xor hex0)) or (hex3 and hex0 and (hex2 xor hex1));
	segs1 <= (hex2 and not(hex1) and (hex3 xor hex0)) or (hex3 and hex1 and hex0) or (hex2 and hex1 and not(hex0));
	segs2 <= (hex3 and hex2 and (hex1 or not(hex0))) or (not(hex3) and not(hex2) and hex1 and not(hex0));
	segs3 <= (not(hex3) and not(hex1) and (hex2 xor hex0)) or (hex2 and hex1 and hex0) or (hex3 and hex1 and not(hex2 xor hex0));
	segs4 <= (not(hex3) and hex0) or (not(hex3) and hex2 and not(hex1)) or (not(hex2) and not(hex1) and hex0);
	segs5 <= (hex2 and hex0 and (hex3 xor hex1)) or (not(hex3) and not(hex2) and (hex1 or hex0));
	segs6 <= (not(hex1) and not(hex0) and not(hex3 xor hex2)) or (not(hex3) and hex0 and not(hex2 xor hex1));
end synth;
