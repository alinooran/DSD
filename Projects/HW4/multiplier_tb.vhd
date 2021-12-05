LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplier_tb IS
END multiplier_tb;

ARCHITECTURE test OF multiplier_tb IS 
    COMPONENT multiplier IS 
    GENERIC (n : integer := 8);
    PORT(
        a : IN std_logic_vector(n-1 downto 0);
        b : IN std_logic_vector(n-1 downto 0);
        y : OUT std_logic_vector(2*n-1 downto 0)
    );
    END COMPONENT;

    signal a,b : std_logic_vector(7 downto 0);
    signal y   : std_logic_vector(15 downto 0);
BEGIN 

    UUT: multiplier GENERIC MAP (n 	=> 8)
    PORT MAP(a => a, b => b, y => y);

    a <= "11111111", "00100110" after 10 ns, "10000101" after 20 ns, "10000001" after 30 ns;
    b <= "11111111", "00001111" after 10 ns, "01010101" after 20 ns, "00000011" after 30 ns;  
END test;
