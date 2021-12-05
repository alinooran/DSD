LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY multiplier IS 
    GENERIC (n : integer := 8);
    PORT(
        a : IN std_logic_vector(n-1 downto 0);
        b : IN std_logic_vector(n-1 downto 0);
        y : OUT std_logic_vector(2*n-1 downto 0)
    );
END multiplier;
ARCHITECTURE multi OF multiplier IS
    TYPE result IS ARRAY(0 TO n) OF std_logic_vector(2*n-1 downto 0);
    SIGNAL tmp_res : result := (others => (OTHERS => '0'));
    SIGNAL res : result := (others => (OTHERS => '0'));
BEGIN  
   
    G: FOR i IN 0 TO n-1 GENERATE
            tmp_res(i)(n - 1 + i DOWNTO i) <= a AND (n-1 DOWNTO 0 => b(i));
            res(i + 1) <= tmp_res(i) + res(i);
    END GENERATE G;
    y <= res(n);
END multi;