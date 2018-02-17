library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLKButton is
	port (O:out STD_LOGIC;CLK,Clear:in STD_LOGIC);
	end entity;

architecture Behavioral of CLKButton is
signal W:std_ulogic;
signal count: integer :=0;
begin
	O <= W;
	process(CLK,Clear) begin
		if (Clear = '1') then
			W<= '0';
			count <= 0;
		elsif rising_edge(CLK) then
			count <= count + 1;
			if count=(50000000/40)-1 then --diveds the button read speed to 120hz
				W <= not W;
				count <= 0;
				end if;
		end if;	
	end process;
end Behavioral;

