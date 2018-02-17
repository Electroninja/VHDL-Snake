library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;

entity segment is
	Port(	S0,S1,S2,S3:in integer range 0 to 9;
			CLK:in std_logic;
			Number:out std_logic_vector(6 downto 0);
			Active:out std_logic_vector(3 downto 0));
end segment;

architecture Behavioral of segment is
signal count:integer range 0 to 3;
begin
process(CLK)begin
	if(rising_edge(CLK)) then
	count <= count + 1;
	end if;
end process;

process(count,S0,S1,S2,S3)begin
	case count is
		when 0 =>
			Active <= "0111";
			case(S0) is
				when 0 => Number <= "0000001";
				when 1 => Number <= "1001111";
				when 2 => Number <= "0010010";
				when 3 => Number <= "0000110";
				when 4 => Number <= "1001100";
				when 5 => Number <= "0100100";
				when 6 => Number <= "0100000";
				when 7 => Number <= "0001111";
				when 8 => Number <= "0000000";
				when 9 => Number <= "0000100";
				when others => Number <= "1111111";
			end case;
		when 1 =>
			Active <= "1011";
			case(S1) is
				when 0 => Number <= "0000001";
				when 1 => Number <= "1001111";
				when 2 => Number <= "0010010";
				when 3 => Number <= "0000110";
				when 4 => Number <= "1001100";
				when 5 => Number <= "0100100";
				when 6 => Number <= "0100000";
				when 7 => Number <= "0001111";
				when 8 => Number <= "0000000";
				when 9 => Number <= "0000100";
				when others => Number <= "1111111";
			end case;
		when 2 =>
			Active <= "1101";
			case(S2) is
				when 0 => Number <= "0000001";
				when 1 => Number <= "1001111";
				when 2 => Number <= "0010010";
				when 3 => Number <= "0000110";
				when 4 => Number <= "1001100";
				when 5 => Number <= "0100100";
				when 6 => Number <= "0100000";
				when 7 => Number <= "0001111";
				when 8 => Number <= "0000000";
				when 9 => Number <= "0000100";
				when others => Number <= "1111111";
			end case;
		when 3 =>
			Active <= "1110";
			case(S3) is
				when 0 => Number <= "0000001";
				when 1 => Number <= "1001111";
				when 2 => Number <= "0010010";
				when 3 => Number <= "0000110";
				when 4 => Number <= "1001100";
				when 5 => Number <= "0100100";
				when 6 => Number <= "0100000";
				when 7 => Number <= "0001111";
				when 8 => Number <= "0000000";
				when 9 => Number <= "0000100";
				when others => Number <= "1111111";
			end case;
	end case;	
end process;
end Behavioral;

