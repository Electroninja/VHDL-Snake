Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_std.all;

entity SnakeGraphics is
	port(	R,G:out std_logic_vector (2 downto 0);
			B:out std_logic_vector(1 downto 0);
			row:out integer range 0 to 14;
			col:out integer range 0 to 19;
			Colors:in std_logic_vector (7 downto 0);
			Hpx,Vpx:in std_logic_vector(4 downto 0);
			Vidon:in std_logic);
	end entity;
	
architecture Behavioral of SnakeGraphics is
begin
process(Colors,Vidon,Hpx,Vpx) begin
		if(Vidon = '1') then
				R <= Colors(7 downto 5);
				G <= Colors(4 downto 2);
				B <= Colors(1 downto 0);
				row <= to_integer(unsigned(Vpx));
				col <= to_integer(unsigned(Hpx));
		else
			R <= "000";
			G <= "000";
			B <= "00";
		end if;
	end process;
end Behavioral;