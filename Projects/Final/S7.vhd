LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY S7 IS
    PORT (
    x  : IN  std_logic_vector(6 DOWNTO 0);
    y  : OUT std_logic_vector(6 DOWNTO 0)
    );
END S7;

ARCHITECTURE s7 OF S7 IS 
BEGIN

    y(0) <= (x(1) AND x(3)) XOR x(4) XOR (x(0) AND x(1) AND x(4)) XOR x(5) XOR (x(2) AND x(5)) XOR (x(3) AND x(4) AND x(5)) XOR x(6) XOR 
             (x(0) AND x(6)) XOR (x(1) AND x(6)) XOR (x(3) AND x(6)) XOR (x(2) AND x(4) AND x(6)) XOR (x(1) AND x(5) AND x(6)) XOR (x(4) AND x(5) AND x(6));
    
    y(1) <= (x(0) AND x(1)) XOR (x(0) AND x(4)) XOR (x(2) AND x(4)) XOR x(5) XOR (x(1) AND x(2) AND x(5)) XOR (x(0) AND x(3) AND x(5)) XOR
             x(6) XOR (x(0) AND x(2) AND x(6)) XOR (x(3) AND x(6)) XOR (x(4) AND x(5) AND x(6)) XOR '1';
    
    y(2) <= x(0) XOR (x(0) AND x(3)) XOR (x(2) AND x(3)) XOR (x(1) AND x(2) AND x(4)) XOR (x(0) AND x(3) AND x(4)) XOR (x(1) AND x(5)) XOR 
             (x(0) AND x(2) AND x(5)) XOR (x(0) AND x(6)) XOR (x(0) AND x(1) AND x(6)) XOR (x(2) AND x(6)) XOR (x(4) AND x(6)) XOR '1';
    
    y(3) <= x(1) XOR (x(0) AND x(1) AND x(2)) XOR (x(1) AND x(4)) XOR (x(3) AND x(4)) XOR (x(0) AND x(5)) XOR (x(0) AND x(1) AND x(5)) XOR
             (x(2) AND x(3) AND x(5)) XOR (x(1) AND x(4) AND x(5)) XOR (x(2) AND x(6)) XOR (x(1) AND x(3) AND x(6));
    
    y(4) <= (x(0) AND x(2)) XOR x(3) XOR (x(1) AND x(3)) XOR (x(1) AND x(4)) XOR (x(0) AND x(1) AND x(4)) XOR (x(2) AND x(3) AND x(4)) XOR
             (x(0) AND x(5)) XOR (x(1) AND x(3) AND x(5)) XOR (x(0) AND x(4) AND x(5)) XOR (x(1) AND x(6)) XOR (x(3) AND x(6)) XOR (x(0) AND 
             x(3) AND x(6)) XOR (x(5) AND x(6)) XOR '1';
    
    y(5) <= x(2) XOR (x(0) AND x(2)) XOR (x(0) AND x(3)) XOR (x(1) AND x(2) AND x(3)) XOR (x(0) AND x(2) AND x(4)) XOR (x(0) AND x(5)) XOR 
             (x(2) AND x(5)) XOR (x(4) AND x(5)) XOR (x(1) AND x(6)) XOR (x(1) AND x(2) AND x(6)) XOR (x(0) AND x(3) AND x(6)) XOR (x(3) AND
             x(4) AND x(6)) XOR (x(2) AND x(5) AND x(6)) XOR '1';
   
    y(6) <= (x(1) AND x(2)) XOR (x(0) AND x(1) AND x(3)) XOR (x(0) AND x(4)) XOR (x(1) AND x(5)) XOR (x(3) AND x(5)) XOR x(6) XOR (x(0) AND
             x(1) AND x(6)) XOR (x(2) AND x(3) AND x(6)) XOR (x(1) AND x(4) AND x(6)) XOR (x(0) AND x(5) AND x(6));      
END s7;