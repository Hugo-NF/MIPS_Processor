library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPS_DEBOUNCE is
    port(	clock : in std_logic;
            reset : in std_logic;
            button_in : in std_logic;
            pulse_out : out std_logic
        );
end MIPS_DEBOUNCE;

architecture behavioral of MIPS_DEBOUNCE is
constant COUNT_MAX : integer := 20; -- debounce time
constant BTN_ACTIVE : std_logic := '1'; -- define when button is pressed

signal count : integer := 0;
type state_type is (idle,wait_time);
signal state : state_type := idle;

begin
process(reset,clock)
begin
    if(reset = '1') then
        state <= idle;
        pulse_out <= '0';
   elsif(rising_edge(clock)) then
        case (state) is
            when idle =>
                if(button_in = BTN_ACTIVE) then  
                    state <= wait_time;
                else
                    state <= idle; --wait until button is pressed.
                end if;
                pulse_out <= '0';
            when wait_time =>
                if(count = COUNT_MAX) then
                    count <= 0;
                    if(button_in = BTN_ACTIVE) then
                        pulse_out <= '1';
                    end if;
                    state <= idle;  
                else
                    count <= count + 1;
                end if; 
        end case;       
    end if;        
end process;                  
                                                                                
end architecture behavioral;