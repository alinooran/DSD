LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
PACKAGE my_pack IS 

    -- FL() declaration
    FUNCTION FL (inp, KLi1, KLi2 : std_logic_vector) RETURN std_logic_vector;

    -- S7 declaration
    FUNCTION S7 (x : std_logic_vector) RETURN std_logic_vector;

    -- S9 declaration
    FUNCTION S9 (x : std_logic_vector) RETURN std_logic_vector;
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
END my_pack;