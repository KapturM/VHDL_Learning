library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity flipflopTb is
 
end entity;

architecture sim of flipflopTb is

    constant ClockFrequency : integer   := 100e6;     -- 100MHz
    constant ClockPeriod    : time      := 1000 ms / ClockFrequency;

    signal clk : std_logic := '1';
    signal nReset : std_logic := '0';
    signal Input : std_logic := '0';
    signal Output : std_logic := '0';

begin

    -- Initialize a flip flop module. This is called DUT (Device under test)

    flipflop1   : entity work.flipflop(rtl)
    port map (
        
    clk => clk,   
    nReset => nReset,   
    Input => Input,       
    Output => Output      

    );

    -- Process for generating clock

    clk <= not clk after ClockPeriod / 2;

    -- Test bench procedure

    process is
    begin

        -- Turn off reset mode
        nReset <= '1';


        -- What happens with not synchronized signals?

        wait for 20 ns;
        Input <= '1';

        wait for 22 ns;
        Input <= '0';

        wait for 6 ns;
        Input <= '1';

        -- Reset DUT

        nReset <= '0';

        wait;
    end process;


end architecture;