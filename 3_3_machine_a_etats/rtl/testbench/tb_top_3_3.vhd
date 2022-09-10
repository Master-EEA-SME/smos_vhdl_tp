library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_top_3_3 is
end entity tb_top_3_3;

architecture rtl of tb_top_3_3 is
    constant CLK_PER : time := 20 ns;
    signal arst_n, clk : std_logic := '0';
    signal btn_incr_n, btn_decr_n : std_logic;
begin
    -- UUT
    u_top_3_3 : entity work.top_3_3
        port map (
            pin_arst_n_i => arst_n,
            pin_clk_i => clk,
            pin_btn_incr_n_i => btn_incr_n,
            pin_btn_decr_n_i => btn_decr_n,
            pin_7seg_hex_o => open
        );

    -- Stimulus
    arst_n <= '0', '1' after 63 ns;
    clk <= not clk after CLK_PER / 2;

    process
    begin
        btn_incr_n <= '1'; btn_decr_n <= '1'; wait for 5*CLK_PER; -- btn_incr relaché,  btn_decr relaché
        btn_incr_n <= '0'; btn_decr_n <= '1'; wait for 5*CLK_PER; -- btn_incr appuié,  btn_decr relaché
        btn_incr_n <= '1'; btn_decr_n <= '0'; wait for 5*CLK_PER; -- btn_incr relaché,  btn_decr appuié
        btn_incr_n <= '0'; btn_decr_n <= '0'; wait for 5*CLK_PER; -- btn_incr appuié,  btn_decr appuié
    end process;
    
end architecture rtl;