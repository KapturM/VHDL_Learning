library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity FiniteStateMachineTB is
 
end entity;

architecture sim of FiniteStateMachineTB is

    constant ClockFrequency : integer   := 100;     -- 100Hz to speed up the simulation time. 
    constant ClockPeriod    : time      := 1000 ms / ClockFrequency;


    signal clk          : std_logic := '1';
    signal nReset       : std_logic := '0';
    
    signal NorthRed     : std_logic;
    signal NorthYellow  : std_logic;
    signal NorthGreen   : std_logic;

    signal WestRed      : std_logic;
    signal WestYellow   : std_logic;
    signal WestGreen    : std_logic;


begin

    -- Instantiate DUT
    TrafficLights : entity work.TrafficLights(rtl)
    generic map(ClockFrequency => ClockFrequency)
    port map(
        clk         => clk,
        nReset      => nReset,
        
        NorthRed    => NorthRed,
        NorthYellow => NorthYellow,
        NorthGreen  => NorthGreen,

        WestRed     => WestRed,
        WestYellow  => WestYellow,
        WestGreen   => WestGreen
        
        );

    -- Process for generating clock
    clk <= not clk after ClockPeriod / 2;

    -- Test bench procedure
    process is
    begin

        wait until rising_edge(clk);
        wait until rising_edge(clk);

        nReset <= '1';
        
    wait;
    end process;

end architecture;