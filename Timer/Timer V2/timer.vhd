library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity timer is
generic(ClockFrequency : integer);

port(

    clk         : in    std_logic;
    nReset      : in    std_logic;
    Seconds     : inout   integer;
    Minutes     : inout   integer;
    Hours       : inout   integer

);
end entity;

architecture rtl of timer is

    -- Counting clock periods
    signal Ticks : integer;


    -- Increment signal by 1
    procedure IncrementWrap(signal Counter      : inout integer; 
                            constant WrapValue  : in integer;
                            constant Enable     : in boolean;
                            variable Wrapped    : out boolean) is
    begin

        Wrapped := false;

        if Enable then
            if Counter = WrapValue - 1 then
                Wrapped := True;
                Counter <= 0;
    
            else
                Wrapped := False;
                Counter <= Counter + 1;
            end if;
        end if;

    end procedure;

begin

    process(clk) is

        variable Wrap : boolean;

    begin

        if rising_edge(clk) then

            if nReset = '0' then
                Ticks   <= 0;
                Seconds <= 0;
                Minutes <= 0;
                Hours   <= 0;

            else
                IncrementWrap(Ticks, ClockFrequency, true, Wrap);
                IncrementWrap(Seconds, 60, Wrap, Wrap);
                IncrementWrap(Minutes, 60, Wrap, Wrap);
                IncrementWrap(Hours, 24, Wrap, Wrap);

            end if;

        end if;

    end process;


end architecture;