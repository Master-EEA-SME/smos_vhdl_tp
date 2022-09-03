library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_and_gate is
end entity tb_and_gate;

architecture rtl of tb_and_gate is
    signal a, b : std_logic := '0';
begin

    -- Unit Under Test
    u_and_gate : entity work.and_gate
        port map (
            a_i => a,
            b_i => b,
            s_o => open
        );

    -- Stimulus
    process
    begin
        a <= '0'; b <= '0'; wait for 20 ns; -- Attendre 20 ns
        a <= '0'; b <= '1'; wait for 20 ns; -- Attendre 20 ns
        a <= '1'; b <= '0'; wait for 20 ns; -- Attendre 20 ns
        a <= '1'; b <= '1'; wait for 20 ns; -- Attendre 20 ns
    end process;
    
end architecture rtl;