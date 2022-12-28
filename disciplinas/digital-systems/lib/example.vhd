library ieee;
use ieee.std_logic_1164.all;
use work.pack.all;

entity example is
	constant nat: natural := 0;
	constant pos: positive := 1;
	constant pi: real := 3.14159265;
	constant s0: std_ulogic := 'H';
end;

architecture arch of example is
	constant cte: tt := 3;
	signal vec: byte := (others => '1');
	signal y0, y1: std_ulogic;
begin
	-- conditional signal assignment
	vec(0) <= '0' when y0 = '1' else
			  '1';

	-- selected signal assignment
	with cte select
		vec(1) <= '1' when 1|3,
				  'Z' when 0|2,
				  '0' when others;

	-- component instantiation
	and0: entity work.and_multiple(arch) port map(x => vec, y => y0);	
	and1: entity work.and_multiple(arch) port map(vec, y1);	

	process
		variable th: real := 0.0;
		variable ba: lets := Z;
		variable i: natural := 0;
	begin
		wait for 1 ns;
		wait on vec; -- sensitivity clause, line process sensitivity list
		wait until vec(0) = '0'; -- resume execution after condition is met, whenever an event occurs
		wait until falling_edge(vec(2));
		wait on vec until vec(1) = '1' for 5 ns;

		if th > 2.0*pi then
			th := 0.0;
		else
			th := th + pi/3.0;
		end if;

		case ba is
			when X => ba := W;
			when W | Y => ba := Z;
			when others => ba := W;
		end case;

		up_count(open, i);
		down_count(i);

		for j in 3 downto 1 loop
			i := add(i, j);
		end loop;

		assert i = 6 report "i nao zero" severity failure;

		-- array attributes
		-- vec(vec'range) <= (others => '1');
		-- vec(vec'left) <= '0';
		-- vec(vec'right) <= '0'; 
		-- vec'range, vec'reverse_range, vec'length

		-- signal attributes
		-- vec'delayed(T)
		-- vec'event
		-- vec'last_event
		-- vec'last_value

		th := 0.0;
		for j in vec'range loop
			if vec(j) = '1' then
				th := th + 1.0;
			end if;
		end loop;

		vec(2) <= not vec(2);
		vec(4 to 7) <= vec(0 to 3) xor x"A";

		-- wait forever
		wait;
	end process;
end;
