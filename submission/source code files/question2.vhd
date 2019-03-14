

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity question2 is
Port(
clk, X1, X2 : in std_logic;
Z : out std_logic;
Y : out std_logic_vector(1 downto 0)
 );
end question2;

architecture Behavioral of question2 is
type state_type is (STA, STB, STC);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "10 11 01";
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
Z<='0';
CASE PS is

when STC =>
    if X2 = '1' then NS <= STB; z <='0'; 
    else NS <= STA; z <='1';
    end if;

when STA =>
    z<='0';
    if X1 ='1' then NS<= STC;
    else NS <= STA; 
    end if;
    
when STB =>
    if X2 ='1' then NS <= STB; z<='0';
    else NS <= STA; z <='1';
    end if;
when others => NS<=STA;

end case;



end process;

with PS select
Y<= "10" when STA,
    "01" when STC,
    "11" when STB,
    "10" when others;
end Behavioral;
