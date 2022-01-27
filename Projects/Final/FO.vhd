LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

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
ARCHITECTURE f0 OF FO IS 
BEGIN 
    PROCESS (inp, KIi1, KIi2, KIi3, KOi1, KOi2, KOi3)
        VARIABLE lef, righ :   std_logic_vector(15 downto 0);
        VARIABLE tmp        :   std_logic_vector(31 downto 0);
    BEGIN
        lef := inp(31 DOWNTO 16);
        righ := inp(15 DOWNTO 0);
        lef := lef xor KOi1;
	lef:=FI(lef,KIi1)
	lef:=lef xor righ
	righ:=righ xor KOi2
	righ:=FI(lef,KIi2)
	righ=righ xor lef
	lef=lef xor KOi3
	lef=FI(lef,KIi3)
	lef=lef xor righ
        tmp := lef & righ;
        outp <= tmp;
    END PROCESS;
END f0;
