

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity question13 is
Port(
clk, X1, X2 : in std_logic;
CS, RD : out std_logic;
Y : out std_logic_vector(2 downto 0)
 );
end question13;

architecture Behavioral of question13 is
type state_type is (STA, STB, STC);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "001 010 100";
signal PS, NS : state_type;



begin

sync_proc: process( clk, NS)
begin
if rising_edge(clk) then
PS <= NS;
end if;
end process;

comb_proc: process(X1, X2, PS)
begin
CS <='0'; RD <='0';
CASE PS is

when STA =>
    if X1 = '1' then NS <= STC; CS <='1'; RD <= '0';
    else NS <= STB; CS <='0'; RD <='1';
    end if;

when STB =>
    NS<=STC;
    CS <='1'; RD <='1';
    
when STC =>
    if X2 ='1' then NS <= STC; CS<='0'; RD<='1';
    else NS <= STA; CS <='0'; RD<='0';
    end if;
when others => NS<=STA;

end case;



end process;

with PS select
Y<= "001" when STA,
    "010" when STB,
    "100" when STC,
    "001" when others;
end Behavioral;
