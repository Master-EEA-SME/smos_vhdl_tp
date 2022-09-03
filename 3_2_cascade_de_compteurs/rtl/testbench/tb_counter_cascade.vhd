library IEEE;
use IEEE.std_logic_1164.all;

entity tb_counter_cascade is
end entity tb_counter_cascade;


architecture rtl of tb_counter_cascade is
    constant CLK_PER : time := 20 ns;
    signal arst_n, clk : std_logic := '0';
begin
    -- UUT
    u_counter_cascade : entity work.counter_cascade
        port map (
            pin_arst_n_i => arst_n,
            pin_clk_i => clk,
            pin_7seg_hex0_o => open
        );
    -- Stimulus
    arst_n <= '1' after 63 ns;
    clk <= not clk after CLK_PER / 2;
end architecture rtl;