LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.my_pack.ALL;

ENTITY KASUMI IS 
    PORT(
        clk, rst :   IN std_logic;
        inp      :   IN   std_logic_vector(63 downto 0);
        key      :   IN   std_logic_vector(127 downto 0);
        outp     :   OUT std_logic_vector(63 downto 0)
    );
END KASUMI;
ARCHITECTURE kasumi OF KASUMI IS 
    COMPONENT KS IS 
        PORT(
            k       : IN std_logic_vector(127 downto 0);
            KLi1    : OUT key_array;
            KLi2    : OUT key_array;
            KOi1    : OUT key_array;
            KOi2    : OUT key_array;
            KOi3    : OUT key_array;
            KIi1    : OUT key_array;
            KIi2    : OUT key_array;
            KIi3    : OUT key_array
        );
    END COMPONENT;
    SIGNAL KLi1, KLi2, KOi1, KOi2, KOi3, KIi1, KIi2, KIi3   :   key_array;
    SIGNAL out_reg  : std_logic_vector(63 downto 0);
BEGIN 

    keys : KS PORT MAP (key, KLi1, KLi2, KOi1, KOi2, KOi3, KIi1, KIi2, KIi3);

    PROCESS (inp, KLi1, KLi2, KOi1, KOi2, KOi3, KIi1, KIi2, KIi3)
        VARIABLE left, right, tmp   :   std_logic_vector(31 downto 0);
        VARIABLE n  : INTEGER;
    BEGIN 
        left  := inp(63 DOWNTO 32);
        right := inp(31 DOWNTO 0);
        n := 0;
        WHILE (n <= 7) LOOP
            tmp := FL(left, KLi1(n), KLi2(n));
            tmp := FO(tmp, KIi1(n), KIi2(n), KIi3(n), KOi1(n), KOi2(n), KOi3(n));
            n := n + 1;
            right := right XOR tmp;
            tmp := FO(right, KIi1(n), KIi2(n), KIi3(n), KOi1(n), KOi2(n), KOi3(n));
            tmp := FL(tmp, KLi1(n), KLi2(n));
            n := n + 1;
            left := left XOR tmp;
        END LOOP;
        out_reg <= left & right;
    END PROCESS;

    PROCESS (clk)
    BEGIN 
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                outp <= (OTHERS => '0');
            ELSE 
                outp <= out_reg;
            END IF;
        END IF;
    END PROCESS;
END kasumi;
