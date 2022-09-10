library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_fsm_btn is
end entity tb_fsm_btn;

architecture rtl of tb_fsm_btn is
    constant CLK_PER : time := 20 ns;
    signal arst_n : std_logic := '0';
    signal clk : std_logic := '0';
    signal t_btn, btn : std_logic;
begin
    
    arst_n <= '1' after 63 ns;
    clk <= not clk after CLK_PER / 2;

    u_fsm_btn : entity work.fsm_btn
        port map (
            arst_n_i => arst_n,
            clk_i => clk,
            btn_i => btn,
            press_event_o => open
        );

    -- On rend synchrone l'entrée à stimuler
    process (clk)
    begin
        if rising_edge(clk) then
            btn <= t_btn;
        end if;
    end process;

    process
    begin
        t_btn <= '0'; wait for 5*CLK_PER;
        t_btn <= '1'; wait for 5*CLK_PER;
        t_btn <= '0'; wait for 5*CLK_PER;
        t_btn <= '1'; wait for 2*CLK_PER;
    end process;
    
end architecture rtl;