library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGA_Driver is
	port(	Hsync,Vsync,VidOn:out std_logic;
			Hpx,Vpx:out std_logic_vector(9 downto 0);
			CLK,Clear:in std_logic);
end VGA_Driver;

architecture Behavioral of VGA_Driver is
Component VGA_640x480 is
	port(	Hsync,Vsync,VidOn:out std_logic;
			Hpx,Vpx:out std_logic_vector(9 downto 0);
			CLK,Clear:in std_logic);
	end component;
Component CLKDIV is
	port(O:out std_logic; CLK,Clear:in std_logic);
	end component;

signal DivCLK: std_logic;
begin

VC0: CLKDIV port map(DivCLK,CLK,Clear);
VC1: VGA_640x480 port map(Hsync,Vsync,Vidon,Hpx,Vpx,DivCLK,Clear);

end Behavioral;

