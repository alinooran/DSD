LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.my_pack.ALL;
ENTITY KS IS 
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
END KS;
ARCHITECTURE ks OF KS IS 
BEGIN 
    PROCESS (k)
        VARIABLE key, kprime    :   key_array;
        VARIABLE C              :   key_array   := (X"0123", X"4567", X"89AB", X"CDEF", X"FEDC", X"BA98", X"7654", X"3210");
    BEGIN 
        key(0) := k(127 DOWNTO 112);
        key(1) := k(111 DOWNTO 96);
        key(2) := k(95 DOWNTO 80);
        key(3) := k(79 DOWNTO 64);
        key(4) := k(63 DOWNTO 48);
        key(5) := k(47 DOWNTO 32);
        key(6) := k(31 DOWNTO 16);
        key(7) := k(15 DOWNTO 0);
        FOR i IN 0 TO 7 LOOP
            kprime(i) := key(i) XOR C(i);
        END LOOP;
        FOR i IN 0 TO 7 LOOP
            KLi1(i) <= key(i)(14 DOWNTO 0) & '0'; 
            IF (i + 2 > 7) THEN
                KLi2(i) <= kprime(i + 2 - 8);
            ELSE 
                KLi2(i) <= kprime(i + 2);
            END IF;
            IF (i + 1 > 7) THEN
                KOi1(i) <= (key(i + 1 - 8)(10 DOWNTO 0)) & (key(i + 1 - 8)(15 DOWNTO 11));
            ELSE 
                KOi1(i) <= (key(i + 1)(10 DOWNTO 0)) & (key(i + 1)(15 DOWNTO 11));
            END IF;
            IF (i + 5 > 7) THEN
                KOi2(i) <= (key(i + 5 - 8)(7 DOWNTO 0)) & (key(i + 5 - 8)(15 DOWNTO 8));
            ELSE 
                KOi2(i) <= (key(i + 5)(7 DOWNTO 0)) & (key(i + 5)(15 DOWNTO 8));
            END IF;
            IF (i + 6 > 7) THEN
                KOi3(i) <= (key(i + 6 - 8)(2 DOWNTO 0)) & (key(i + 6 - 8)(15 DOWNTO 3));
            ELSE 
                KOi3(i) <= (key(i + 6)(2 DOWNTO 0)) & (key(i + 6)(15 DOWNTO 3));
            END IF;
            IF (i + 4 > 7) THEN
                KIi1(i) <= kprime(i + 4 - 8);
            ELSE 
                KIi1(i) <= kprime(i + 4);
            END IF;
            IF (i + 3 > 7) THEN
                KIi2(i) <= kprime(i + 3 - 8);
            ELSE 
                KIi2(i) <= kprime(i + 3);
            END IF;
            IF (i + 7 > 7) THEN
                KIi3(i) <= kprime(i + 7 - 8);
            ELSE 
                KIi3(i) <= kprime(i + 7);
            END IF;
        END LOOP;
    END PROCESS;
END ks;