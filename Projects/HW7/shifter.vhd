LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
ENTITY shifter IS
  PORT(
	a: IN std_logic_vector(31 downto 0);
	b: IN std_logic_vector(4 downto 0);
	res: OUT std_logic_vector(31 downto 0)
	);
END shifter;
ARCHITECTURE shifter OF shifter IS 
BEGIN

    PROCESS(a, b)
        VARIABLE c : std_logic_vector(31 downto 0);
        VARIABLE x : INTEGER RANGE 0 TO 31;
    BEGIN
        x := to_integer(unsigned(b));
        c := (31 downto 0);
        while x > 0 LOOP 
            c := c(30 downto 0) & '0';
            x := x - 1;
        END LOOP;
        res <= c;
    END PROCESS;
END shifter;
		

