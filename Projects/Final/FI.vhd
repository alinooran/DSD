LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.my_pack.ALL;

ENTITY FI IS 
    PORT(
        inp       : IN std_logic_vector(15 downto 0);
        subkey    : IN std_logic_vector(15 downto 0);
        outp      : OUT std_logic_vector(15 downto 0)
    );
END FI;
ARCHITECTURE fi OF FI IS 
BEGIN 
    PROCESS (inp, subkey)
        VARIABLE nine, seven    :   std_logic_vector(15 downto 0) := (OTHERS => '0');
    BEGIN 
        nine  := "0000000" & inp(15 DOWNTO 7);
        seven := "000000000" & inp(6 DOWNTO 0);
        nine  := ("0000000" & S9(nine(8 DOWNTO 0))) XOR seven;
        seven := "000000000" & (S7(seven(6 DOWNTO 0)) XOR nine(6 DOWNTO 0));
        seven := seven XOR ("000000000" & subkey(15 DOWNTO 9));
        nine  := nine XOR ("0000000" & subkey(8 DOWNTO 0));
        nine  := ("0000000" & S9(nine(8 DOWNTO 0))) XOR seven;
        seven := ("000000000" & S7(seven(6 DOWNTO 0))) XOR ("000000000" & nine(6 DOWNTO 0));
        outp  <= seven(6 DOWNTO 0) & nine(8 DOWNTO 0);
    END PROCESS;
END fi;