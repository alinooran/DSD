LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FL IS 
    PORT(
        inp     : IN std_logic_vector(31 downto 0);
        --index   : IN std_logic;
        KIi1    : IN std_logic_vector(15 downto 0);
        KIi2    : IN std_logic_vector(15 downto 0);
        KIi3    : IN std_logic_vector(15 downto 0);
        outp    : OUT std_logic_vector(31 downto 0)
    );
END FL;
ARCHITECTURE fl OF FL IS 
    --COMPONENT shifter 
    --    GENERIC(n : INTEGER := 16;
    --            m : INTEGER := 1);
    --    PORT(
    --        a       : IN std_logic_vector(n-1 downto 0);
    --        right   : IN std_logic;
    --        y       : OUT std_logic_vector(n-1 downto 0)
    --    );
    --END COMPONENT;

    SIGNAL l, r, a, b   : std_logic_vector(15 downto 0);
BEGIN 
    --shiftR  :   shifter GENERIC MAP () PORT MAP ();
    --l <= inp(31 DOWNTO 16);
    --r <= 
    PROCESS (inp, index)
        VARIABLE l, r, a, b :   std_logic_vector(15 downto 0);
    BEGIN
        l := inp(31 DOWNTO 16);
        r := inp(15 DOWNTO 0);
    END PROCESS;
END fl;