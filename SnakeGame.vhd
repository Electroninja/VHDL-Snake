Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_std.all;

entity SnakeGame is
	port(	PxMap:out std_logic_vector (7 downto 0);
			row:in integer range 0 to 14;
			col:in integer range 0 to 19;
			upb,downb,leftb,rightb,CLKS,CLKB,Clear:in std_logic;
			S0,S1,S2,S3:out integer range 0 to 9;
			GO:out std_logic);
	end entity;
	
architecture Behavioral of SnakeGame is

component BCD is
	Port(	Inc,Reset:in std_logic;
			Cout: out std_logic;
			Count:out  integer range 0 to 9);
	end component;

signal Xv,SnakeX,FoodX: integer range 0 to 19;
signal Yv,SnakeY,FoodY: integer range 0 to 14;
signal RandX: integer range 0 to 19 := 7;
signal RandY: integer range 0 to 14 := 7;
signal BCDCin,GameOver: std_logic := '0';
signal Carry0,Carry1,Carry2,Carry3: std_logic;
signal SnakeLength: integer range 0 to 31:=0;
type GameX is array(0 to 31) of integer range 0 to 20;
type GameY is array(0 to 31) of integer range 0 to 15;
signal TailX: GameX;
signal TailY: GameY;
begin

--Deals with the timer
BCD0:	BCD	port map(Carry1,Clear,Carry0,S0);
BCD1:	BCD	port map(Carry2,Clear,Carry1,S1);
BCD2:	BCD	port map(Carry3,Clear,Carry2,S2);
BCD3:	BCD	port map(BCDCin,Clear,Carry3,S3);
GO <= GameOver;
--Deals with updating the grid
process(CLKS,SnakeX,SnakeY,SnakeLength)begin
	if(rising_edge(CLKS))then
		for i in 31 downto 1 loop
			if(i > SnakeLength) then
				TailX(i) <= 20;
				TailY(i) <= 15;
			else
				TailX(i) <= TailX(i-1);
				TailY(i) <= TailY(i-1);
			end if;
		end loop;
		TailX(0) <= SnakeX;
		TailY(0) <= SnakeY;
	end if;
end process;

--Deals with Gaming over
process(Clear,SnakeX,SnakeY,TailX,TailY,CLKS)begin
	if(Clear = '1') then
		GameOver <= '0';
	elsif(rising_edge(CLKB)) then
		for i in 1 to 31 loop
			if(TailY(i) = SnakeY and  TailX(i) = SnakeX) then
				GameOver <= '1';
				exit;
			end if;
		end loop;
	end if;
end process;

--Deals with graphics Driver;
process(row,col,FoodX,FoodY,SnakeX,SnakeY,GameOver)begin
	if(GameOver = '1') then
		PxMap <= "11111111";
	elsif(FoodX = col and FoodY = row) then
		PxMap <= "11110000";
	elsif(SnakeX = col and SnakeY = row) then
		PxMap <= "11100000";
	else
		PxMap <= "00000011";
		for i in 0 to 31 loop
			if(TailX(i) = col and TailY(i) = row) then
				PxMap <= "00111000";
				exit;
			end if;
		end loop;
	end if;
end process;

--sets the Velocity of snake head
process(CLKB,Clear)begin
	if(Clear = '1') then
		Xv <= 0;
		Yv <= 0;
	elsif(rising_edge(CLKB)) then
		if(upb = '1') then
			Xv <= 0;
			Yv <= 14;
		elsif(downb = '1')then
			Xv <= 0;
			Yv <= 1;
		elsif(leftb = '1')then
			Xv <= 19;
			Yv <= 0;
		elsif(rightb = '1')then
			Xv <= 1;
			Yv <= 0;
		else 
			Xv <= Xv;
			Yv <= Yv;
		end if;
	end if;
end process;

--Used for the food & points
process(SnakeX,SnakeY,CLKB,Clear) begin
	if(Clear = '1') then
			RandX <= 5;
			RandY <= 9;
			FoodX	<= 4;
			FoodY <= 4;
			SnakeLength <= 0;
	elsif(rising_edge(CLKB)) then
		if(RandX+3 >= 19) then
			RandX <= 0;
		else
			RandX <= RandX + 3;
		end if;
		if(RandY+3 >= 14) then
			RandY <= 0;
		else
			RandY <= RandY + 3;
		end if;
		if(SnakeX = FoodX and SnakeY = FoodY) then
			FoodX <= RandX;
			FoodY <= RandY;
			BCDCin <= '1';
			SnakeLength <= SnakeLength + 1;
		else
			BCDCin <= '0';
		end if;
	end if;
end process;

--Deals with updating the SnakeHead
process(CLKS,Clear)begin
	if(Clear = '1') then
		SnakeX <= 10;
		SnakeY <= 7;
	elsif(rising_edge(CLKS)) then
			if(SnakeX+Xv >= 20) then
				SnakeX <= SnakeX+Xv-20;
			else
				SnakeX <= SnakeX + Xv;
			end if;
			if(SnakeY+Yv >= 15) then
				SnakeY <= SnakeY + Yv-15;
			else
				SnakeY <= SnakeY + Yv;
			end if;
	end if;
end process;

end Behavioral;