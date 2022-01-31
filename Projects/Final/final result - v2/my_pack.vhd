LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
PACKAGE my_pack IS 

    TYPE key_array IS ARRAY(0 TO 7) OF std_logic_vector(15 downto 0);

    -- FL() declaration
    FUNCTION FL (inp, KLi1, KLi2 : std_logic_vector) RETURN std_logic_vector;

    -- S7 declaration
    FUNCTION S7 (x : std_logic_vector) RETURN std_logic_vector;

    -- S9 declaration
    FUNCTION S9 (x : std_logic_vector) RETURN std_logic_vector;

    -- FI() declaration
    FUNCTION FI (inp, subkey : std_logic_vector) RETURN std_logic_vector;
    
    -- FO() declaration
    FUNCTION FO (inp, KIi1, KIi2, KIi3, KOi1, KOi2, KOi3 : std_logic_vector) RETURN std_logic_vector;

    -- keySchedule declaration
    PROCEDURE keySchedule (k : IN std_logic_vector(127 downto 0);
    KLi1    : OUT key_array;
    KLi2    : OUT key_array;
    KOi1    : OUT key_array;
    KOi2    : OUT key_array;
    KOi3    : OUT key_array;
    KIi1    : OUT key_array;
    KIi2    : OUT key_array;
    KIi3    : OUT key_array);
END my_pack;

PACKAGE BODY my_pack IS 

    -- FL() body
    FUNCTION FL (inp, KLi1, KLi2 : std_logic_vector) RETURN std_logic_vector IS 
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
        RETURN tmp;
    END FL;

     -- S7 body
    FUNCTION S7 (x : std_logic_vector) RETURN std_logic_vector IS 
       VARIABLE y  : std_logic_vector(6 downto 0);
    BEGIN 
        y(0) := (x(1) AND x(3)) XOR x(4) XOR (x(0) AND x(1) AND x(4)) XOR x(5) XOR (x(2) AND x(5)) XOR (x(3) AND x(4) AND x(5)) XOR x(6) XOR 
                (x(0) AND x(6)) XOR (x(1) AND x(6)) XOR (x(3) AND x(6)) XOR (x(2) AND x(4) AND x(6)) XOR (x(1) AND x(5) AND x(6)) XOR (x(4) AND x(5) AND x(6));
    
        y(1) := (x(0) AND x(1)) XOR (x(0) AND x(4)) XOR (x(2) AND x(4)) XOR x(5) XOR (x(1) AND x(2) AND x(5)) XOR (x(0) AND x(3) AND x(5)) XOR
                x(6) XOR (x(0) AND x(2) AND x(6)) XOR (x(3) AND x(6)) XOR (x(4) AND x(5) AND x(6)) XOR '1';
    
        y(2) := x(0) XOR (x(0) AND x(3)) XOR (x(2) AND x(3)) XOR (x(1) AND x(2) AND x(4)) XOR (x(0) AND x(3) AND x(4)) XOR (x(1) AND x(5)) XOR 
                (x(0) AND x(2) AND x(5)) XOR (x(0) AND x(6)) XOR (x(0) AND x(1) AND x(6)) XOR (x(2) AND x(6)) XOR (x(4) AND x(6)) XOR '1';
    
        y(3) := x(1) XOR (x(0) AND x(1) AND x(2)) XOR (x(1) AND x(4)) XOR (x(3) AND x(4)) XOR (x(0) AND x(5)) XOR (x(0) AND x(1) AND x(5)) XOR
                (x(2) AND x(3) AND x(5)) XOR (x(1) AND x(4) AND x(5)) XOR (x(2) AND x(6)) XOR (x(1) AND x(3) AND x(6));
    
        y(4) := (x(0) AND x(2)) XOR x(3) XOR (x(1) AND x(3)) XOR (x(1) AND x(4)) XOR (x(0) AND x(1) AND x(4)) XOR (x(2) AND x(3) AND x(4)) XOR
                (x(0) AND x(5)) XOR (x(1) AND x(3) AND x(5)) XOR (x(0) AND x(4) AND x(5)) XOR (x(1) AND x(6)) XOR (x(3) AND x(6)) XOR (x(0) AND 
                x(3) AND x(6)) XOR (x(5) AND x(6)) XOR '1';
    
        y(5) := x(2) XOR (x(0) AND x(2)) XOR (x(0) AND x(3)) XOR (x(1) AND x(2) AND x(3)) XOR (x(0) AND x(2) AND x(4)) XOR (x(0) AND x(5)) XOR 
                (x(2) AND x(5)) XOR (x(4) AND x(5)) XOR (x(1) AND x(6)) XOR (x(1) AND x(2) AND x(6)) XOR (x(0) AND x(3) AND x(6)) XOR (x(3) AND
                x(4) AND x(6)) XOR (x(2) AND x(5) AND x(6)) XOR '1';
   
        y(6) := (x(1) AND x(2)) XOR (x(0) AND x(1) AND x(3)) XOR (x(0) AND x(4)) XOR (x(1) AND x(5)) XOR (x(3) AND x(5)) XOR x(6) XOR (x(0) AND
                x(1) AND x(6)) XOR (x(2) AND x(3) AND x(6)) XOR (x(1) AND x(4) AND x(6)) XOR (x(0) AND x(5) AND x(6));

        RETURN y;
    END S7;

    -- S9 body
    FUNCTION S9 (x : std_logic_vector) RETURN std_logic_vector IS 
        VARIABLE y  : std_logic_vector(8 downto 0);
    BEGIN 
        y(0) := (x(0) AND x(2)) XOR x(3) XOR (x(2) AND x(5)) XOR (x(5) AND x(6)) XOR (x(0) AND x(7)) XOR (x(1) AND x(7)) XOR (x(2) AND x(7)) XOR
                (x(4) AND x(8)) XOR (x(5) AND x(8)) XOR (x(7) AND x(8)) XOR '1';
    
        y(1) := x(1) XOR (x(0) AND x(1)) XOR (x(2) AND x(3)) XOR (x(0) AND x(4)) XOR (x(1) AND x(4)) XOR (x(0) AND x(5)) XOR (x(3) AND x(5)) XOR
                x(6) XOR (x(1) AND x(7)) XOR (x(2) AND x(7)) XOR (x(5) AND x(8))  XOR '1';
    
        y(2) := x(1) XOR (x(0) AND x(3)) XOR (x(3) AND x(4)) XOR (x(0) AND x(5)) XOR (x(2) AND x(6)) XOR (x(3) AND x(6)) XOR (x(5) AND x(6)) XOR
                (x(4) AND x(7)) XOR (x(5) AND x(7)) XOR (x(6) AND x(7)) XOR x(8) XOR (x(0) AND x(8)) XOR '1';
    
        y(3) := x(0) XOR (x(1) AND x(2)) XOR (x(0) AND x(3)) XOR (x(2) AND x(4)) XOR x(5) XOR (x(0) AND x(6)) XOR (x(1) AND x(6)) XOR (x(4) AND
                x(7)) XOR (x(0) AND x(8)) XOR (x(1) AND x(8))  XOR (x(7) AND x(8));
    
        y(4) := (x(0) AND x(1)) XOR (x(1) AND x(3)) XOR x(4) XOR (x(0) AND x(5)) XOR (x(3) AND x(6)) XOR (x(0) AND x(7)) XOR (x(6) AND x(7)) XOR 
                (x(1) AND x(8)) XOR (x(2) AND x(8)) XOR (x(3) AND x(8));
    
        y(5) := x(2) XOR (x(1) AND x(4)) XOR (x(4) AND x(5)) XOR (x(0) AND x(6)) XOR (x(1) AND x(6)) XOR (x(3) AND x(7)) XOR (x(4) AND x(7)) XOR
                (x(6) AND x(7)) XOR (x(5) AND x(8)) XOR (x(6) AND x(8)) XOR (x(7) AND x(8)) XOR '1';
    
        y(6) := x(0) XOR (x(2) AND x(3)) XOR (x(1) AND x(5)) XOR (x(2) AND x(5)) XOR (x(4) AND x(5)) XOR (x(3) AND x(6)) XOR (x(4) AND x(6)) XOR
                (x(5) AND x(6)) XOR x(7) XOR (x(1) AND x(8)) XOR (x(3) AND x(8)) XOR (x(5) AND x(8)) XOR (x(7) AND x(8));
    
        y(7) := (x(0) AND x(1)) XOR (x(0) AND x(2)) XOR (x(1) AND x(2)) XOR x(3) XOR (x(0) AND x(3)) XOR (x(2) AND x(3)) XOR (x(4) AND x(5)) XOR
                (x(2) AND x(6)) XOR (x(3) AND x(6)) XOR (x(2) AND x(7)) XOR (x(5) AND x(7)) XOR x(8) XOR '1';
    
        y(8) := (x(0) AND x(1)) XOR x(2) XOR (x(1) AND x(2)) XOR (x(3) AND x(4)) XOR (x(1) AND x(5)) XOR (x(2) AND x(5))  XOR (x(1) AND x(6)) XOR
                (x(4) AND x(6)) XOR x(7) XOR (x(2) AND x(8))  XOR (x(3) AND x(8));

        RETURN y;
    END S9;

    -- FI() body
    FUNCTION FI (inp, subkey : std_logic_vector) RETURN std_logic_vector IS 
        VARIABLE l0, r1, l2, r3, r4,  KIij2   : std_logic_vector(8 downto 0);
        VARIABLE r0, l1, r2, l3, l4, KIij1  : std_logic_vector(6 downto 0);
        VARIABLE tmp : std_logic_vector(15 downto 0);
    BEGIN 
        l0 := inp(15 DOWNTO 7);
        r0 := inp(6 DOWNTO 0);
        KIij1 := subkey(15 DOWNTO 9);
        KIij2 := subkey(8 DOWNTO 0);
        l1 := r0;
        r1 := S9(l0) XOR ("00" & r0);
        l2 := r1 XOR KIij2;
        r2 := S7(l1) XOR r1(6 DOWNTO 0) XOR KIij1;
        l3 := r2;
        r3 := S9(l2) XOR ("00" & r2);
        l4 := S7(l3) XOR r3(6 DOWNTO 0);
        r4 := r3;
        tmp := l4 & r4;
        RETURN tmp;
    END FI;

    -- FO() body
    FUNCTION FO (inp, KIi1, KIi2, KIi3, KOi1, KOi2, KOi3 : std_logic_vector) RETURN std_logic_vector IS 
        VARIABLE left, right, left1, left2, left3, right1, right2, right3 :   std_logic_vector(15 downto 0);
        VARIABLE tmp         :   std_logic_vector(31 downto 0);
    BEGIN 
        left  := inp(31 DOWNTO 16);
        right := inp(15 DOWNTO 0);
        right1 := FI(left XOR KOi1, KIi1) XOR right;
        left1 := right;
        right2 := FI (left1 XOR KOi2, KIi2) XOR right1;
        left2 := right1;
        right3 := FI(left2 XOR KOi3, KIi3) XOR right2;
        left3 := right2;
        tmp := left3 & right3;
        RETURN tmp;
    END FO;

    -- keySchedule body
    PROCEDURE keySchedule (k : IN std_logic_vector(127 downto 0);
    KLi1    : OUT key_array;
    KLi2    : OUT key_array;
    KOi1    : OUT key_array;
    KOi2    : OUT key_array;
    KOi3    : OUT key_array;
    KIi1    : OUT key_array;
    KIi2    : OUT key_array;
    KIi3    : OUT key_array) IS 
    VARIABLE key, kprime    :   key_array;
    VARIABLE C              :   key_array;
    BEGIN 
    C := (X"0123", X"4567", X"89AB", X"CDEF", X"FEDC", X"BA98", X"7654", X"3210");
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
        KLi1(i) := key(i)(14 DOWNTO 0) & '0'; 
        IF (i + 2 > 7) THEN
            KLi2(i) := kprime(i + 2 - 8);
        ELSE 
            KLi2(i) := kprime(i + 2);
        END IF;
        IF (i + 1 > 7) THEN
            KOi1(i) := (key(i + 1 - 8)(10 DOWNTO 0)) & (key(i + 1 - 8)(15 DOWNTO 11));
        ELSE 
            KOi1(i) := (key(i + 1)(10 DOWNTO 0)) & (key(i + 1)(15 DOWNTO 11));
        END IF;
        IF (i + 5 > 7) THEN
            KOi2(i) := (key(i + 5 - 8)(7 DOWNTO 0)) & (key(i + 5 - 8)(15 DOWNTO 8));
        ELSE 
            KOi2(i) := (key(i + 5)(7 DOWNTO 0)) & (key(i + 5)(15 DOWNTO 8));
        END IF;
        IF (i + 6 > 7) THEN
            KOi3(i) := (key(i + 6 - 8)(2 DOWNTO 0)) & (key(i + 6 - 8)(15 DOWNTO 3));
        ELSE 
            KOi3(i) := (key(i + 6)(2 DOWNTO 0)) & (key(i + 6)(15 DOWNTO 3));
        END IF;
        IF (i + 4 > 7) THEN
            KIi1(i) := kprime(i + 4 - 8);
        ELSE 
            KIi1(i) := kprime(i + 4);
        END IF;
        IF (i + 3 > 7) THEN
            KIi2(i) := kprime(i + 3 - 8);
        ELSE 
            KIi2(i) := kprime(i + 3);
        END IF;
        IF (i + 7 > 7) THEN
            KIi3(i) := kprime(i + 7 - 8);
        ELSE 
            KIi3(i) := kprime(i + 7);
        END IF;
    END LOOP;
    END keySchedule;
END my_pack;