library ieee;
use ieee.std_logic_1164.all;

package pack is
	subtype tt is integer range -1 to 3;
	subtype byte is std_ulogic_vector(0 to 7);

	type lets is (X, Y, Z, W);
	type word is array(0 to 31) of std_ulogic;
	type lets_array is array(lets) of std_ulogic;

	procedure up_count(max: in integer := 10; var: inout integer);
	procedure down_count(var: inout integer);
	function add (x1, x2: integer) return integer;
end;

package body pack is
	procedure up_count(max: in integer := 10; var: inout integer) is
	begin
		loop
			var := var+1;
			exit when var >= max;
		end loop;
	end;

	procedure down_count(var: inout integer) is
	begin
		while var > 0 loop
			var := var-1;
		end loop;
	end;

	function add (x1, x2: integer) return integer is
	begin
		return x1+x2;
	end;
end;
