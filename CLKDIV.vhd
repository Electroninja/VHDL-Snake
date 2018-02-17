Library IEEE;						-- used to divided the normal clk 50Mhz in half for vga
use IEEE.std_logic_1164.all;

entity CLKDIV is
	port(O:out std_logic; CLK,Clear:in std_logic);
	end entity;
	
architecture Behavioral of CLKDIV is
signal outp: std_logic;
begin
	O <= outp;
	process(CLK,Clear) begin
		if(Clear='1') then
			outp <= '0';
		elsif(rising_edge(CLK)) then
			outp <= not outp;
		end if;
	end process;
end Behavioral;