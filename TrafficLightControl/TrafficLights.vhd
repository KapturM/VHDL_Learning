library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity TrafficLights is
generic(ClockFrequency : integer);

port(

    clk         : in    std_logic;
    nReset      : in    std_logic;

    -- Lights
    NorthRed        : out std_logic;
    NorthYellow     : out std_logic;
    NorthGreen      : out std_logic;

    WestRed         : out std_logic;
    WestYellow      : out std_logic;
    WestGreen       : out std_logic


);

end entity;

architecture rtl of TrafficLights is

    type tState is (NorthNext, StartNorth, North, StopNorth, 
                    WestNext, StartWest, West, StopWest);

    signal State : tState;

    -- Counter signal, 1 min max
    signal Counter : integer range 0 to ClockFrequency * 60;

begin

    process(clk) is

        -- Change state after a certain amount of time
        procedure ChangeState(ToState : tState;
                                Minutes : integer := 0;
                                Seconds : integer := 0) is
        variable TotalSeconds   : integer;      
        variable ClockCycles    : integer;         
        begin

            TotalSeconds    := Seconds + Minutes * 60;
            ClockCycles     := TotalSeconds * ClockFrequency - 1;

            if Counter = ClockCycles then
                Counter <= 0;
                State   <= ToState;

            end if;

        end procedure;


    begin

        if rising_edge(clk) then
            if nReset = '0' then
                -- Reset values
                State           <= NorthNext;

                Counter         <= 0;

                NorthRed        <= '1';
                NorthYellow     <= '0';
                NorthGreen      <= '0';
            
                WestRed         <= '1';
                WestYellow      <= '0';
                WestGreen       <= '0';
    
            else

                -- Default values
                NorthRed        <= '0';
                NorthYellow     <= '0';
                NorthGreen      <= '0';
            
                WestRed         <= '0';
                WestYellow      <= '0';
                WestGreen       <= '0';

                Counter <= Counter + 1;

                case State is

                -- Red in all directions
                when NorthNext =>
                    NorthRed        <= '1';
                    WestRed         <= '1';

                    ChangeState(StartNorth, Seconds => 5);

                -- Red and yellow in N S directions
                when StartNorth =>
                    NorthRed        <= '1';
                    NorthYellow     <= '1';
                    WestRed         <= '1';

                    ChangeState(North, Seconds => 5);

                -- Green in N S directions
                when North =>
                    NorthGreen      <= '1';
                    WestRed         <= '1';

                    ChangeState(StopNorth, Minutes => 1);

                -- Yellow in N S directions
                when StopNorth =>
                    NorthYellow     <= '1';
                    WestRed         <= '1';

                    ChangeState(WestNext, Seconds => 5);
    
                -- Red in all directions
                when WestNext =>
                    NorthRed        <= '1';
                    WestRed         <= '1';

                    ChangeState(StartWest, Seconds => 5);
    
                -- Red and Yellow in W E directions
                when StartWest =>
                    WestRed         <= '1';
                    WestYellow      <= '1';
                    NorthRed        <= '1';

                    ChangeState(West, Seconds => 5);
   
                -- Green in W E directions
                when West =>
                    WestGreen       <= '1';
                    NorthRed        <= '1';

                    ChangeState(StopWest, Minutes => 1);

                -- Yellow in W E directions
                when StopWest =>
                    WestYellow      <= '1';
                    NorthRed        <= '1';

                    ChangeState(NorthNext, Seconds => 5);

                end case;
    
    
            end if;

        end if;

    end process;


end architecture;