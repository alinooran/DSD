LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.my_pack.ALL;

ENTITY FO IS 
    PORT(
        inp     : IN std_logic_vector(31 downto 0);
        KIi1    : IN std_logic_vector(15 downto 0);
        KIi2    : IN std_logic_vector(15 downto 0);
	    KIi3    : IN std_logic_vector(15 downto 0);
	    KOi1    : IN std_logic_vector(15 downto 0);
	    KOi2    : IN std_logic_vector(15 downto 0);
	    KOi3    : IN std_logic_vector(15 downto 0);
        outp    : OUT std_logic_vector(31 downto 0)
    );
END FO;
ARCHITECTURE fo OF FO IS 
BEGIN 
    PROCESS (inp, KIi1, KIi2, KIi3, KOi1, KOi2, KOi3)
        VARIABLE left, right :   std_logic_vector(15 downto 0);
        VARIABLE tmp         :   std_logic_vector(31 downto 0);
    BEGIN
        left  := inp(31 DOWNTO 16);
        right := inp(15 DOWNTO 0);
        left  := left XOR KOi1;
	    left  := FI(left,KIi1);
	    left  := left XOR right;
	    right := right XOR KOi2;
	    right := FI(right,KIi2);
	    right := right XOR left;
	    left  := left XOR KOi3;
	    left  := FI(left,KIi3);
	    left  := left XOR right;
        tmp   := right & left;
        outp  <= tmp;
    END PROCESS;
END fo;
