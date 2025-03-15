library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity position_generator is
port(
	clk: in std_logic;

	re0: out std_logic_vector(31 downto 0) := x"c0000000";
	im0: out std_logic_vector(31 downto 0) := x"bf800000";
	inc_re: out std_logic_vector(31 downto 0) := x"3b99999a";
	inc_im: out std_logic_vector(31 downto 0) := x"3b888889"
);
end;

architecture arch of position_generator is	
begin
	process (clk)
		variable i: integer range 0 to 9;
	begin
		if rising_edge(clk) then
			case i is
				when 0 => re0 <= x"c0000000"; im0 <= x"bf800000"; inc_re <= x"3b99999a"; inc_im <= x"3b888889";
				when 1 => re0 <= x"bfed3a07"; im0 <= x"bf78091a"; inc_re <= x"3b8a2050"; inc_im <= x"3b76103b";
				when 2 => re0 <= x"bfda740e"; im0 <= x"bf701234"; inc_re <= x"3b754e0d"; inc_im <= x"3b5b0f66";
				when 3 => re0 <= x"bfc7ae14"; im0 <= x"bf681b4f"; inc_re <= x"3b565b7a"; inc_im <= x"3b400e90";
				when 4 => re0 <= x"bfb4e81b"; im0 <= x"bf602469"; inc_re <= x"3b3768e7"; inc_im <= x"3b250dbb";
				when 5 => re0 <= x"bfa22222"; im0 <= x"bf582d83"; inc_re <= x"3b187654"; inc_im <= x"3b0a0ce5";
				when 6 => re0 <= x"bf8f5c29"; im0 <= x"bf50369d"; inc_re <= x"3af30782"; inc_im <= x"3ade181f";
				when 7 => re0 <= x"bf792c60"; im0 <= x"bf483fb7"; inc_re <= x"3ab5225c"; inc_im <= x"3aa81674";
				when 8 => re0 <= x"bf53a06d"; im0 <= x"bf4048d1"; inc_re <= x"3a6e7a6d"; inc_im <= x"3a642991";
				when 9 => re0 <= x"bf2e147b"; im0 <= x"bf3851ec"; inc_re <= x"39e56042"; inc_im <= x"39f04c75";

			end case;
			
			if i = 9 then
				i := 0;
			else
				i := i + 1;
			end if;
		end if;
	end process;
end;
