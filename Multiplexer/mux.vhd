library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;


entity mux is
 
generic(DataWidth : integer);

 port(
    --Inputs

    Input1 : in unsigned(DataWidth - 1 downto 0);
    Input2 : in unsigned(DataWidth - 1 downto 0);
    Input3 : in unsigned(DataWidth - 1 downto 0);
    Input4 : in unsigned(DataWidth - 1 downto 0);

    Selector : in unsigned(1 downto 0);

    --Outputs

    Output : out unsigned(DataWidth - 1 downto 0)

    );

end entity;

architecture rtl of mux is
begin

        -- MUX using case

        process(Selector, Input1, Input2, Input3, Input4) is
        begin

            case Selector is
                when "00" =>
                    Output <= Input1;
                when "01" =>
                    Output <= Input2;
                when "10" =>
                    Output <= Input3;
                when "11" =>
                    Output <= Input4;
                when others =>
                    Output <= (others => 'X');
            end case;


        end process;

end architecture;