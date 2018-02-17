library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLKSeg is
	Port (O:out STD_LOGIC;CLK:in STD_LOGIC);
	end entity;

architecture Behavioral of CLKSeg is
signal W:std_ulogic;
signal count: integer :=0;
begin
	O <= W;
	process(CLK) begin
		if rising_edge(CLK) then
			count <= count + 1;
			if count=(50000000/800)-1 then --diveds the button read speed to 400hz
				W <= not W;
				count <= 0;
				end if;
		end if;	
	end process;
end Behavioral;



