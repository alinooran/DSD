LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FL IS 
    PORT(
        inp     : IN std_logic_vector(31 downto 0);
        KLi1    : IN std_logic_vector(15 downto 0);
        KLi2    : IN std_logic_vector(15 downto 0);
        outp    : OUT std_logic_vector(31 downto 0)
    );
END FL;
ARCHITECTURE fl OF FL IS 
BEGIN 
    PROCESS (inp, KLi1, KLi2)
        VARIABLE l, r, a, b :   std_logic_vector(15 downto 0);
        VARIABLE tmp        :   std_logic_vector(31 downto 0);
    BEGIN
        l := inp(31 DOWNTO 16);
        r := inp(15 DOWNTO 0);
        a := l AND KLi1;
        r := r XOR (a(14 DOWNTO 0) & a(15));
        b := r OR KLi2;
        l := l XOR (b(14 DOWNTO 0) & b(15));
        tmp := l & r;
        outp <= tmp;
    END PROCESS;
END fl;