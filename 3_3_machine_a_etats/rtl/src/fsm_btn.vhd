library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fsm_btn is
    port (
        arst_n_i : in std_logic;
        clk_i : in std_logic;
        btn_i : in std_logic;
        press_event_o : out std_logic
    );
end entity fsm_btn;

architecture rtl of fsm_btn is
    type btn_st is (st_released, st_pressed);
    signal current_st : btn_st;
begin
    
    process (clk_i, arst_n_i)
    begin
        if arst_n_i = '0' then
            current_st <= st_released;
        elsif rising_edge(clk_i) then
            case current_st is
                when st_released =>
                    if btn_i = '1' then
                        current_st <= st_pressed;
                    end if;
                when st_pressed =>
                    if btn_i = '0' then
                        current_st <= st_released;
                    end if;
                when others =>
            end case;
        end if;
    end process;

    press_event_o <= 
        '1' when current_st = st_released and btn_i = '1' else
        '0';

end architecture rtl;