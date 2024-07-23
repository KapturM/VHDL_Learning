library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity flipflop is
port(

    clk         : in std_logic;
    nReset      : in std_logic;
    Input       : in std_logic;
    Output      : out std_logic
);
end entity;

architecture rtl of flipflop is

begin

    process(clk) is
    begin

        if rising_edge(clk) then

            if nReset = '0' then
                Output <= '0';
            else
                Output <= Input;
            end if;

        end if;

    end process;


end architecture;