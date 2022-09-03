library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_counter is
end entity tb_counter;

architecture rtl of tb_counter is
    constant CLK_PER : time := 20 ns;
    signal arst_n, clk : std_logic := '0';
    signal srst, en : std_logic := '0';
begin
    -- Unit Under Test
    u_counter : entity work.counter
        generic map (
            C_N => 7
        )
        port map (
            arst_n_i => arst_n,
            clk_i => clk,
            srst_i => srst,
            en_i => en,
            q_o => open
        );
    -- Stimulus
    arst_n <= '1' after 63 ns;
    clk <= not clk after CLK_PER / 2;
    process
    begin
        srst <= '0'; en <= '0'; wait for 5*CLK_PER;
        srst <= '0'; en <= '1'; wait for 5*CLK_PER;
        srst <= '1'; en <= '1'; wait for 5*CLK_PER;
        srst <= '1'; en <= '0'; wait for 5*CLK_PER;
        srst <= '0'; en <= '0'; wait for 5*CLK_PER;
        srst <= '0'; en <= '1'; wait;
    end process;
    
end architecture rtl;