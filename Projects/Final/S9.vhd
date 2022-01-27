LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY S9 IS
    PORT (
    x  : IN  std_logic_vector(8 DOWNTO 0);
    y  : OUT std_logic_vector(8 DOWNTO 0)
    );
END S9;

ARCHITECTURE s9 OF S9 IS 
BEGIN

    y(0) <= (x(0) and x(2)) xor x(3) xor (x(2) and x(5)) xor (x(5) and x(6)) xor (x(0) and x(7)) xor (x(1) and x(7)) xor (x(2) and x(7)) xor
            (x(4) and x(8)) xor (x(5) and x(8)) xor (x(7) and x(8)) xor '1';
    
    y(1) <= x(1) xor (x(0) and x(1)) xor (x(2) and x(3)) xor (x(0) and x(4)) xor (x(1) and x(4)) xor (x(0) and x(5)) xor (x(3) and x(5)) xor
            x(6) xor (x(1) and x(7)) xor (x(2) and x(7)) xor (x(5) and x(8))  xor '1';
    
    y(2) <= x(1) xor (x(0) and x(3)) xor (x(3) and x(4)) xor (x(0) and x(5)) xor (x(2) and x(6)) xor (x(3) and x(6)) xor (x(5) and x(6)) xor
            (x(4) and x(7)) xor (x(5) and x(7)) xor (x(6) and x(7)) xor x(8) xor (x(0) and x(8)) xor '1';
    
    y(3) <= x(0) xor (x(1) and x(2)) xor (x(0) and x(3)) xor (x(2) and x(4)) xor x(5) xor (x(0) and x(6)) xor (x(1) and x(6)) xor (x(4) and
            x(7)) xor (x(0) and x(8)) xor (x(1) and x(8))  xor (x(7) and x(8));
    
    y(4) <= (x(0) and x(1)) xor (x(1) and x(3)) xor x(4) xor (x(0) and x(5)) xor (x(3) and x(6)) xor (x(0) and x(7)) xor (x(6) and x(7)) xor 
            (x(1) and x(8)) xor (x(2) and x(8)) xor (x(3) and x(8));
    
    y(5) <= x(2) xor (x(1) and x(4)) xor (x(4) and x(5)) xor (x(0) and x(6)) xor (x(1) and x(6)) xor (x(3) and x(7)) xor (x(4) and x(7)) xor
            (x(6) and x(7)) xor (x(5) and x(8)) xor (x(6) and x(8)) xor (x(7) and x(8)) xor '1';
    
    y(6) <= x(0) xor (x(2) and x(3)) xor (x(1) and x(5)) xor (x(2) and x(5)) xor (x(4) and x(5)) xor (x(3) and x(6)) xor (x(4) and x(6)) xor
            (x(5) and x(6)) xor x(7) xor (x(1) and x(8)) xor (x(3) and x(8)) xor (x(5) and x(8)) xor (x(7) and x(8));
    
    y(7) <= (x(0) and x(1)) xor (x(0) and x(2)) xor (x(1) and x(2)) xor x(3) xor (x(0) and x(3)) xor (x(2) and x(3)) xor (x(4) and x(5)) xor
            (x(2) and x(6)) xor (x(3) and x(6)) xor (x(2) and x(7)) xor (x(5) and x(7)) xor x(8) xor '1';
    
    y(8) <= (x(0) and x(1)) xor x(2) xor (x(1) and x(2)) xor (x(3) and x(4)) xor (x(1) and x(5)) xor (x(2) and x(5))  xor (x(1) and x(6)) xor
            (x(4) and x(6)) xor x(7) xor (x(2) and x(8))  xor (x(3) and x(8));
END s9;