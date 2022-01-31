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
    SIGNAL out_reg  : std_logic_vector(63 downto 0);
BEGIN 


    PROCESS (inp, key)
        VARIABLE l0, r0, l1, r1, l2, r2, l3, r3, l4, r4, l5, r5, l6, r6, l7, r7, l8, r8, tmp   :   std_logic_vector(31 downto 0);
        VARIABLE n  : INTEGER;
        VARIABLE KLi1, KLi2, KOi1, KOi2, KOi3, KIi1, KIi2, KIi3   :   key_array;
    BEGIN 
        keySchedule(key, KLi1, KLi2, KOi1, KOi2, KOi3, KIi1, KIi2, KIi3);
        l0 := inp(63 DOWNTO 32);
        r0 := inp(31 DOWNTO 0);

        r1 := l0;
        tmp := FL(l0, KLi1(0), KLi2(0));
        l1 := r0 XOR FO(tmp, KIi1(0), KIi2(0), KIi3(0), KOi1(0), KOi2(0), KOi3(0));

        r2 := l1;
        tmp := FO(l1, KIi1(1), KIi2(1), KIi3(1), KOi1(1), KOi2(1), KOi3(1));
        l2 := r1 XOR FL(tmp, KLi1(1), KLi2(1));

        r3 := l2;
        tmp := FL(l2, KLi1(2), KLi2(2));
        l3 := r2 XOR FO(tmp, KIi1(2), KIi2(2), KIi3(2), KOi1(2), KOi2(2), KOi3(2));

        r4 := l3;
        tmp := FO(l3, KIi1(3), KIi2(3), KIi3(3), KOi1(3), KOi2(3), KOi3(3));
        l4 := r3 XOR FL(tmp, KLi1(3), KLi2(3));

        r5 := l4;
        tmp := FL(l4, KLi1(4), KLi2(4));
        l5 := r4 XOR FO(tmp, KIi1(4), KIi2(4), KIi3(4), KOi1(4), KOi2(4), KOi3(4));

        r6 := l5;
        tmp := FO(l5, KIi1(5), KIi2(5), KIi3(5), KOi1(5), KOi2(5), KOi3(5));
        l6 := r5 XOR FL(tmp, KLi1(5), KLi2(5));

        r7 := l6;
        tmp := FL(l6, KLi1(6), KLi2(6));
        l7 := r6 XOR FO(tmp, KIi1(6), KIi2(6), KIi3(6), KOi1(6), KOi2(6), KOi3(6));

        r8 := l7;
        tmp := FO(l7, KIi1(7), KIi2(7), KIi3(7), KOi1(7), KOi2(7), KOi3(7));
        l8 := r7 XOR FL(tmp, KLi1(7), KLi2(7));

        out_reg <= l8 & r8;
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
