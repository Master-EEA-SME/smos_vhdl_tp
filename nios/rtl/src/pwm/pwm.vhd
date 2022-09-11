library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm is
    port (
        arst_i : in std_logic;
        clk_i : in std_logic;
        duty_i : in std_logic_vector(31 downto 0);
        freq_i : in std_logic_vector(31 downto 0);
        q_o : out std_logic
    );
end entity pwm;

architecture rtl of pwm is
    signal cnt : unsigned(31 downto 0);
begin
    
    process (clk_i, arst_i)
    begin
        if arst_i = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk_i) then
            cnt <= cnt + 1;
            if cnt >= unsigned(freq_i) then
                cnt <= (others => '0');
            end if;
        end if;
    end process;

    process (clk_i)
    begin
        if rising_edge(clk_i) then
            if cnt >= unsigned(duty_i) then
                q_o <= '1';
            else
                q_o <= '0';
            end if;
        end if;
    end process;
    
end architecture rtl;