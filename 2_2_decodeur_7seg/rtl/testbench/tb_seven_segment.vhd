library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_seven_segment is
end entity tb_seven_segment;

architecture rtl of tb_seven_segment is
    -- On declare un signal "cnt" de type "unsigned" qui va servir à stimuler
    -- l'entrée de notre décodeur 7seg.
    signal cnt : unsigned(3 downto 0) := (others => '0');
begin
    -- Unit Under Test
    u_seven_segment : entity work.seven_segment
        port map (
            x_i => std_logic_vector(cnt), -- Conversion d'un signal type "unsigned" en "std_logic_vector"
            y_o => open
        );

    -- Stimulus
    process
    begin
        wait for 20 ns; -- On attend 20 ns
        cnt <= cnt + 1; -- On incremente le signal "cnt" de 1
    end process;
    
end architecture rtl;