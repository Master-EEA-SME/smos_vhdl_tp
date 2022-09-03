library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
    generic (
        C_N : integer := 8
    );
    port (
        arst_n_i : in std_logic;
        clk_i : in std_logic;
        srst_i : in std_logic;
        en_i : in std_logic;
        q_o : out std_logic_vector(C_N - 1 downto 0)
    );
end entity counter;

architecture rtl of counter is
    signal q : unsigned(q_o'range);
begin
    process (clk_i, arst_n_i)
    begin
        if arst_n_i = '0' then
            q <= (others => '0');
        elsif rising_edge(clk_i) then
            if srst_i = '1' then
                q <= (others => '0');
            else
                if en_i = '1' then
                    q <= q + 1;
                end if;
            end if;
        end if;
    end process;
    q_o <= std_logic_vector(q); -- Conversion du signal type "unsigned" en "std_logic_vector"
end architecture rtl;