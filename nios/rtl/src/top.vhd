library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library soc;

entity top is
    port (
        pin_arst_n_i : in std_logic;
        pin_clk_i : in std_logic;
        pin_btn_n_i : in std_logic;
        pin_led_o : out std_logic_vector(7 downto 0)
    );
end entity top;

architecture rtl of top is
    signal arst_n : std_logic;
    signal clk : std_logic;
    signal btn : std_logic;
begin
    arst_n <= pin_arst_n_i;
    clk <= pin_clk_i;

    process (clk)
    begin
        if rising_edge(clk) then
            btn <= not pin_btn_n_i;
        end if;
    end process;

    u_soc : entity soc.soc
		port map (
			reset_reset_n  => arst_n,
			clk_clk        => clk,
			buttons_export => btn,
			leds_export    => pin_led_o
		);
    
end architecture rtl;