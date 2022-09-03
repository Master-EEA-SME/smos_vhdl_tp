library IEEE;
use IEEE.std_logic_1164.all;

entity seven_segment is
    port (
        x_i : in std_logic_vector(3 downto 0);
        y_o : out std_logic_vector(6 downto 0)
    );
end entity seven_segment;

architecture rtl_seven_segment of seven_segment is
    
begin
    
    with x_i select
        y_o <= 
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
    
-- L'expression x"X" permet de specifier un vecteur de 4 bits de type std_logic_vector
-- en hexadecimal. Pour pouvoir utiliser cette expression il faut que le vecteur std_logic_vector
-- soit d'une taille d'un multiple de 4. 
-- Ex : 
-- x"4" --> la taille du std_logic_vector doit être de 4 : std_logic_vector(3 downto 0) ou std_logic_vector(0 to 3) or std_logic_vector(7 downto 4)
-- x"12" --> la taille du std_logic_vector doit être de 8 : std_logic_vector(7 downto 0) ou std_logic_vector(0 to 7) or std_logic_vector(11 downto 4)
-- x"123" --> la taille du std_logic_vector doit être de 12 : std_logic_vector(11 downto 0) ou std_logic_vector(0 to 11) or std_logic_vector(15 downto 4)

end architecture rtl_seven_segment;