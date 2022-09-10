library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_3_3 is
    port (
        pin_arst_n_i : in std_logic;
        pin_clk_i : in std_logic;
        pin_btn_incr_n_i : in std_logic;
        pin_btn_decr_n_i : in std_logic;
        pin_7seg_hex_o : out std_logic_vector(6 downto 0)
    );
end entity top_3_3;

architecture rtl of top_3_3 is
    signal async_btn_incr, async_btn_decr : std_logic;
    signal btn_incr, incr_event : std_logic;
    signal btn_decr, decr_event : std_logic;
    signal cnt_en, cnt_ud : std_logic;
    signal cnt_q : std_logic_vector(3 downto 0);
    signal hex_7seg : std_logic_vector(6 downto 0);
begin
    async_btn_incr <= not pin_btn_incr_n_i;
    async_btn_decr <= not pin_btn_decr_n_i;

-- Synchronisation des boutons. On rend les signaux btn_incr et btn_decr synchrones par rapport à l'horloge clk_i
    u_sync_incr : entity work.flip_flop
        port map (
            pre_i => '0',
            clr_i => '0',
            clk_i => pin_clk_i,
            d_i => async_btn_incr,
            q_o => btn_incr
        );
    u_sync_decr : entity work.flip_flop
        port map (
            pre_i => '0',
            clr_i => '0',
            clk_i => pin_clk_i,
            d_i => async_btn_decr,
            q_o => btn_decr
        );

-- Instanciations du composant fsm_btn qui permettront de détecter l'évènement d'appui sur les 2 boutons
    u_increment : entity work.fsm_btn
        port map (
            arst_n_i => pin_arst_n_i,
            clk_i => pin_clk_i,
            btn_i => btn_incr,
            press_event_o => incr_event
        );
    u_decrement : entity work.fsm_btn
        port map (
            arst_n_i => pin_arst_n_i,
            clk_i => pin_clk_i,
            btn_i => btn_decr,
            press_event_o => decr_event
        );

-- Logique combinatoire pour incrémenter ou décrémenter le compteur en fonction des évènements détectés et de l'état des boutons
-- en respectant la consigne de l'exercice    
    cnt_en <=
        '1' when (incr_event = '1' and btn_decr = '0') or (decr_event = '1' and btn_incr = '0') else
        '0';
    cnt_ud <= decr_event;

-- Instanciation du compteur
    u_counter : entity work.counter
        generic map (
            C_N => 4
        )
        port map (
            arst_n_i => pin_arst_n_i,
            clk_i => pin_clk_i,
            srst_i => '0',
            en_i => cnt_en,
            ud_i => cnt_ud,
            q_o => cnt_q
        );

-- Instanciation du décodeur sept segments
    u_seven_segment : entity work.seven_segment
        port map (
            x_i => cnt_q,
            y_o => hex_7seg
        );

    pin_7seg_hex_o <= not hex_7seg;

end architecture rtl;