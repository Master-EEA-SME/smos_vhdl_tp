library IEEE;
use IEEE.std_logic_1164.all;

entity and_gate is
    port (
        a_i : in std_logic;
        b_i : in std_logic;
        s_o : out std_logic
    );
end entity and_gate;

architecture rtl_and_gate of and_gate is
begin
    s_o <= a_i and b_i;
end architecture rtl_and_gate;
