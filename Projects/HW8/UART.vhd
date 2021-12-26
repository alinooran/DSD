LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY shifter IS
  PORT(
        start       : IN std_logic;
        clk         : IN std_logic;
        rst         : IN std_logic;
        rx          : IN std_logic;
        data_in     : IN std_logic_vector(7 downto 0);
        baud        : IN std_logic_vector(7 downto 0);
        tx          : OUT std_logic;
        data_ready  : OUT std_logic;
        data_outt   : OUT std_logic_vector(7 downto 0)
	);
END shifter;
ARCHITECTURE shifter OF shifter IS
    SIGNAL new_clk  :   std_logic   := '0';
BEGIN
    PROCESS (clk)
        VARIABLE counter : INTEGER RANGE 0 TO 256 := 0;
        VARIABLE limit : INTEGER := to_integer(unsigned(baud));
    BEGIN
        IF (clk = '1' AND clk'EVENT) THEN
            IF (counter = limit) THEN
                new_clk <= '1';
                counter := 0;
            ELSE
                counter := counter + 1;
                new_clk <= '0';
            END IF;
        END IF;
    END PROCESS;
END shifter;
		

