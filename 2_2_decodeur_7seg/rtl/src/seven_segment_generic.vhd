library IEEE;
use IEEE.std_logic_1164.all;

entity seven_segment_generic is
    generic (
        C_COMMON_ANODE : boolean := FALSE
    );
    port (
        x_i : in std_logic_vector(3 downto 0);
        y_o : out std_logic_vector(6 downto 0)
    );
end entity seven_segment_generic;

architecture rtl_seven_segment_generic of seven_segment_generic is
    signal y : std_logic_vector(6 downto 0);
begin
    
    with x_i select
        y <= 
            "0111111" when x"0",
            "0000110" when x"1",
            "1011011" when x"2",
            "1001111" when x"3",
            "1100110" when x"4",
            "1101101" when x"5",
            "1111101" when x"6",
            "0000111" when x"7",
            "1111111" when x"8",
            "1101111" when x"9",
            "1110111" when x"A",
            "1111100" when x"B",
            "0111001" when x"C",
            "1011110" when x"D",
            "1111001" when x"E",
            "1110001" when x"F",
            "0000000" when others; -- Il faut specifier "when others" même si tous les cas sont couverts

    y_o <= 
        not y when C_COMMON_ANODE = TRUE else
        y;

end architecture rtl_seven_segment_generic;