library IEEE;
use IEEE.std_logic_1164.all;

entity top is
    port (
        pin_sw_i : in std_logic_vector(3 downto 0);
        pin_7seg_hex0_o : out std_logic_vector(6 downto 0)
    );
end entity top;

architecture rtl of top is
    signal sw : std_logic_vector(3 downto 0);
    signal s_7seg_hex0 : std_logic_vector(6 downto 0);
begin
    -- Pour corriger la polarité des leds de l'afficheur 7 seg, on instancie dans un fichier
    -- top level pour ensuite complementer la sortie du composant "seven_segment".
    -- On aurait pu aussi complementer la sortie "y_o" directement dans le composant
    -- "seven_segment" et ainsi s'en passer de ce fichier top level.
    -- On aurait pu aussi ajouter un paramètre générique "C_COMMON_ANODE" pour indiquer à notre
    -- composant "seven_segment" qu'on s'adresse à un afficheur 7 segments à anode commune et ainsi
    -- complementer la sortie "y_o" (voir fichier seven_segment_generic.vhd).

    sw <= pin_sw_i;
    
    u_seven_segment : entity work.seven_segment
        port map (
            x_i => sw,
            y_o => s_7seg_hex0
        );

    pin_7seg_hex0_o <= not s_7seg_hex0;

end architecture rtl;