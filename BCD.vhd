library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;

entity BCD is
	Port( Inc,Reset:in std_logic;
			Cout: out std_logic;
			Count:out  integer range 0 to 9);
end BCD;

architecture Behavioral of BCD is
signal reg: integer range 0 to 9 := 9;
begin
Count <= reg;
process(Reset,Inc) begin
	if(Reset = '1')then
		reg <= 0;
		Cout <= '0';
	elsif(rising_edge(Inc)) then
		reg <= reg+1;
		if(reg >= 9)then
			reg <= 0;
			Cout <= '1';
		else 
			Cout <= '0';
		end if;
	end if;
end process;
end Behavioral;

