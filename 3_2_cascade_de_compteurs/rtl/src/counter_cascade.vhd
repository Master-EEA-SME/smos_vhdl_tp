library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter_cascade is
    port (
        pin_arst_n_i : in std_logic;
        pin_clk_i : in std_logic;
        pin_7seg_hex0_o : out std_logic_vector(6 downto 0)
    );
end entity counter_cascade;

architecture rtl of counter_cascade is
    signal arst_n : std_logic;
    signal clk : std_logic;
    signal cnt0_q : std_logic_vector(25 downto 0);
    signal cnt1_q : std_logic_vector(3 downto 0);
    signal cnt0_srst, cnt1_en : std_logic;
    signal s_7seg_hex0 : std_logic_vector(6 downto 0);
begin
    arst_n <= pin_arst_n_i; 
    clk <= pin_clk_i;

    u_cnt0 : entity work.counter
        generic map (
            C_N => cnt0_q'length
        )
        port map (
            arst_n_i => arst_n,
            clk_i => clk,
            srst_i => cnt0_srst,
            en_i => '1',
            q_o => cnt0_q
        );

    cnt1_en <= 
        '1' when unsigned(cnt0_q) >= 50e6 - 1 else
        '0';

    cnt0_srst <= cnt1_en;

    u_cnt1 : entity work.counter
        generic map (
            C_N => cnt1_q'length
        )
        port map (
            arst_n_i => arst_n,
            clk_i => clk,
            srst_i => '0',
            en_i => cnt1_en,
            q_o => cnt1_q
        );

    u_seven_segment : entity work.seven_segment
        port map (
            x_i => cnt1_q,
            y_o => s_7seg_hex0
        );
      
    pin_7seg_hex0_o <= not s_7seg_hex0;
    
end architecture rtl;