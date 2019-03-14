

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity question4 is
Port(
clk, X1, X2 : in std_logic;
Z1, Z2 : out std_logic
 );
end question4;

architecture Behavioral of question4 is
type state_type is (STA, STB, STC);

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
Z1<='0'; Z2 <='0';
CASE PS is

when STA =>
    if X1 = '1' then NS <= STB; Z2 <='1'; 
    else NS <= STC; Z2 <='0';
    end if;

when STB =>
    if X2 ='1' then NS<= STA; Z2<='0';
    else NS <= STC; Z2<='1';
    end if;
    
when STC =>
    Z2 <='1';
    if X1 ='1' then NS <= STB;
    else NS <= STA;
    end if;
when others => NS<=STA;

end case;



end process;

with PS select
Z1<= '0' when STA,
    '1' when STB,
    '1' when STC,
    '0' when others;
end Behavioral;
