----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2019 04:02:21 PM
-- Design Name: 
-- Module Name: question6 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity question6 is
    Port ( clk : in STD_LOGIC;
           X : in STD_LOGIC;
           Z1, Z2 : out STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (1 downto 0));
end question6;

architecture Behavioral of question6 is
type state_type is (ST0, ST1, ST2, ST3);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "00 10 01 11";
signal PS , NS : state_type;
begin

sync_proc: process( clk, NS)
begin
if rising_edge(clk) then
PS <= NS;
end if;
end process;

comb_proc: process(X, PS)
begin
Z1<='0';
CASE PS is

when ST0 =>
    Z1 <= '1'; 
    Z2 <='0';
    if X = '1' then NS <= ST0; 
    else NS <= ST1;
    end if;

when ST1 =>
    Z1 <='1';
    Z2 <='0';
    if X ='1' then NS<= ST0;
    else NS <= ST2; 
    end if;
    
when ST2 =>
    Z1 <='0';
    Z2 <='0';
    if X ='1' then NS <= ST2;
    else NS <= ST3;
    end if;
    
when ST3 =>
    Z1 <='0';
    if X ='1' then NS <= ST2; Z2 <='0';
    else NS <= ST0; Z2 <='1';
    end if;
    
when others => NS<=ST0;

end case;



end process;
with PS select
Y<= "00" when ST0,
    "10" when ST1,
    "01" when ST2,
    "11" when ST3,
    "00" when others;

end Behavioral;
