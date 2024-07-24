library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity procedureTb is
 
end entity;

architecture sim of procedureTb is

    constant ClockFrequency : integer   := 10;     -- 10Hz to speed up the simulation time. 
    constant ClockPeriod    : time      := 1000 ms / ClockFrequency;


    signal clk          : std_logic := '1';
    signal nReset       : std_logic := '0';

    signal Seconds      : integer;
    signal Minutes      : integer;
    signal Hours        : integer;

begin

    -- Instantiate DUT

    timer1 : entity work.timer(rtl)
    generic map(ClockFrequency => ClockFrequency)
    port map(

    clk => clk,
    nReset => nReset,
    Seconds => Seconds,
    Minutes => Minutes,
    Hours => Hours

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