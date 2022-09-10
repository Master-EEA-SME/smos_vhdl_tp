library IEEE;
use IEEE.std_logic_1164.all;

entity flip_flop is
    port (
        pre_i : in std_logic;
        clr_i : in std_logic;
        clk_i : in std_logic;
        d_i : in std_logic;
        q_o : out std_logic
    );
end entity flip_flop;

architecture rtl of flip_flop is
    
begin
    
    process (clk_i, pre_i, clr_i)
    begin
        if pre_i = '1' then
            q_o <= '1';
        elsif clr_i = '1' then
            q_o <= '0';
        elsif rising_edge(clk_i) then
            q_o <= d_i;
        end if;
    end process;
    
end architecture rtl;