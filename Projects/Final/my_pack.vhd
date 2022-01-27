LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
PACKAGE my_pack IS 

    -- FL() declaration
    FUNCTION FL (SIGNAL inp, KLi1, KLi2 : std_logic_vector) RETURN std_logic_vector;
END my_pack;

PACKAGE BODY my_pack IS 

    -- FL() body
    FUNCTION FL (SIGNAL inp, KLi1, KLi2 : std_logic_vector) RETURN std_logic_vector IS 
        VARIABLE l, r, a, b :   std_logic_vector(15 downto 0);
        SIGNAL tmp        :   std_logic_vector(31 downto 0);
    BEGIN 
        l := inp(31 DOWNTO 16);
        r := inp(15 DOWNTO 0);
        a := l AND KLi1;
        r := r XOR (a(14 DOWNTO 0) & a(15));
        b := r OR KLi2;
        l := l XOR (b(14 DOWNTO 0) & b(15));
        tmp <= l & r;
        RETURN tmp;
    END FL;
END my_pack;