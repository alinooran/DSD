LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ROL IS 
    GENERIC(n : INTEGER := 16;
            m : INTEGER := 1);
    PORT(
        a       : IN std_logic_vector(n-1 downto 0);
        --right   : IN std_logic;
        y       : OUT std_logic_vector(n-1 downto 0)
    );
END ROL;
ARCHITECTURE rol OF ROL IS 

BEGIN 
    PROCESS(a, right)
        VARIABLE tmp : std_logic_vector(n-1 downto 0);
    BEGIN 
        tmp := a;
        FOR i IN 1 TO m LOOP
            tmp := tmp(n-2 DOWNTO 0) & tmp(n-1);
        END LOOP;
        --IF (right = '1') THEN
        --    FOR i IN 1 TO m LOOP
        --        tmp := '0' & tmp(n-1 DOWNTO 1);
        --    END LOOP;
        --ELSE
        --    FOR i IN 1 TO m LOOP
        --        tmp := tmp(n-2 DOWNTO 0) & '0';
        --    END LOOP;
        --END IF;
        y <= tmp;
    END PROCESS;
END rol;