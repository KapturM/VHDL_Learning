library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;


entity muxTb is
end entity;

architecture sim of muxTb is

    constant DataWidth : integer := 8;

    signal Selector : unsigned(1 downto 0) := (others => '0');

    signal Input1 : unsigned(DataWidth - 1 downto 0) := x"AA";
    signal Input2 : unsigned(DataWidth - 1 downto 0) := x"BB";
    signal Input3 : unsigned(DataWidth - 1 downto 0) := x"CC";
    signal Input4 : unsigned(DataWidth - 1 downto 0) := x"DD";

    signal Output : unsigned(7 downto 0);


begin

    --Create an instance of MUX module

    i_Mux1 : entity work.mux(rtl)
    generic map (DataWidth => DataWidth)
    port map (
        Selector => Selector,
        Input1 => Input1,
        Input2 => Input2,
        Input3 => Input3,
        Input4 => Input4,
        Output => Output
    );

    --Testbench process
    process is
    begin

        wait for 10 ns;
        Selector <= Selector + 1;
        
        wait for 10 ns;
        Selector <= Selector + 1;
        
        wait for 10 ns;
        Selector <= Selector + 1;
        
        wait for 10 ns;
        Selector <= Selector + 1;
        
        wait for 10 ns;
        Selector <= "UU";

        wait;

    end process;




end architecture;