Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_std.all;

entity FullGame is
	port(	R,G:out std_logic_vector (2 downto 0);
			B:out std_logic_vector(1 downto 0);
			Hsync,Vsync:out std_logic;
			Number:out std_logic_vector(6 downto 0);
			ActiveSeg:out std_logic_vector(3 downto 0);
			upb,downb,leftb,rightb,CLK,Clear:in std_logic;
			GO: out std_logic
			);
	end entity;
	
architecture Behavioral of FullGame is

component SnakeGame is
	port(	PxMap:out std_logic_vector (7 downto 0);
			row:in integer range 0 to 14;
			col:in integer range 0 to 19;
			upb,downb,leftb,rightb,CLKS,CLKB,Clear:in std_logic;
			S0,S1,S2,S3:out integer range 0 to 9;
			GO:out std_logic);
	end component;
component SnakeGraphics is
	port(	R,G:out std_logic_vector (2 downto 0);
			B:out std_logic_vector(1 downto 0);
			row:out integer range 0 to 14;
			col:out integer range 0 to 19;
			Colors:in std_logic_vector (7 downto 0);
			Hpx,Vpx:in std_logic_vector(4 downto 0);
			Vidon:in std_logic);
	end component;
component VGA_Driver is
	port(	Hsync,Vsync,VidOn:out std_logic;
			Hpx,Vpx:out std_logic_vector(9 downto 0);
			CLK,Clear:in std_logic);
	end component;
component CLKButton is
	Port (O:out STD_LOGIC;CLK,Clear:in STD_LOGIC);
	end component;
component CLKSnake is
	Port (O:out STD_LOGIC;CLK,Clear:in STD_LOGIC);
	end component;
component CLKSeg is
	Port (O:out STD_LOGIC;CLK:in STD_LOGIC);
	end component;
component segment is
	Port(	S0,S1,S2,S3:in integer range 0 to 9;
			CLK:in std_logic;
			Number:out std_logic_vector(6 downto 0);
			Active:out std_logic_vector(3 downto 0));
	end component;
	
signal Vidon: std_logic;
signal Hpx,Vpx:std_logic_vector(9 downto 0);
signal Color: std_logic_vector(7 downto 0);
signal Row: integer range 0 to 14;
signal Column: integer range 0 to 19;
signal CLKS,CLKB: std_logic;
signal CLKsegment:std_logic;
signal S0,S1,S2,S3:integer range 0 to 9;
begin
C0: SnakeGame		port map(Color,Row,Column,upb,downb,leftb,rightb,CLKS,CLKB,Clear,S0,S1,S2,S3,GO);
C1: SnakeGraphics	port map(R,G,B,Row,Column,Color,Hpx(9 downto 5),Vpx(9 downto 5),Vidon);
C2: VGA_Driver 	port map(Hsync,Vsync,Vidon,Hpx,Vpx,CLK,Clear);
C3: CLKSnake 		port map(CLKS,CLK,Clear);
C4: CLKButton 		port map(CLKB,CLK,Clear);
C5: CLKseg			port map(CLKSegment,CLK);
C6: segment			port map(S0,S1,S2,S3,CLKsegment,Number,ActiveSeg);
end Behavioral;