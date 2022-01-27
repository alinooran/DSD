LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FI IS 
    PORT(
        inp       : IN std_logic_vector(15 downto 0);
        subkey    : IN std_logic_vector(15 downto 0);
        outp      : OUT std_logic_vector(15 downto 0)
    );
END FI;
ARCHITECTURE fi OF FI IS 
BEGIN 
   
END fi;