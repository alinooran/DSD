
---------------- Hamming Weight -------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY hw IS 
    PORT(
        a : IN std_logic_vector(31 downto 0);
        y : OUT std_logic_vector(31 downto 0)
    );
END hw;
ARCHITECTURE hw_func OF hw IS 

BEGIN
    PROCESS(a)
    VARIABLE h : std_logic_vector(31 downto 0);
    BEGIN
        h := (OTHERS => '0');
        FOR i IN a'RANGE LOOP
            IF a(i) = '1' THEN 
                h := h + x"00000001"; 
            END IF;
        END LOOP;
        y <= h;
    END PROCESS;
END hw_func;

--------------------------------- ALU -----------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
--USE work.HW.ALL;
ENTITY alu IS
    PORT(
        a,b : IN std_logic_vector(31 downto 0);
        cin : IN std_logic;
        func: IN std_logic_vector(3 downto 0);
        y   : OUT std_logic_vector(31 downto 0);
        cout: OUT std_logic
    );
END alu;

ARCHITECTURE concurrent OF alu IS
SIGNAL x1,x2,x3,hwAout,hwBout : std_logic_vector(31 downto 0);
SIGNAL add_res  : std_logic_vector(32 downto 0);
COMPONENT hw IS 
    PORT(
        a : IN std_logic_vector(31 downto 0);
        y : OUT std_logic_vector(31 downto 0)
    );
END COMPONENT;
BEGIN 

    hwA : hw PORT MAP(a,hwAout);
    hwB : hw PORT MAP(b,hwBout);

    x1 <= (0 => '1', OTHERS => '0') WHEN a > b ELSE (OTHERS => '0');
    x2 <= (0 => '1', OTHERS => '0') WHEN a < b ELSE (OTHERS => '0');
    x3 <= (0 => '1', OTHERS => '0') WHEN a = b ELSE (OTHERS => '0');
    add_res <= ('0' & a) + ('0' & b) + cin AFTER 3ns WHEN func = "1000" ELSE (OTHERS => '0');
    cout <= add_res(32);

    WITH func(3 downto 0) SELECT
               y <= NOT a AFTER 1 ns WHEN "0000",
                    a NAND b AFTER 2 ns WHEN "0001",
                    a NOR b AFTER 2 ns WHEN "0010",
                    a XOR b AFTER 2 ns WHEN "0011",
                    a AND b AFTER 1 ns WHEN "0100",
                    hwAout AFTER 6 ns WHEN "0101",
                    hwBout AFTER 6 ns WHEN "0110",
                    (0 - a) AFTER 3 ns WHEN "0111",
                    a + b + cin AFTER 3 ns WHEN "1000",
                    a - b AFTER 3 ns WHEN "1001",
                    x1 AFTER 2 ns WHEN "1010",
                    x2 AFTER 2 ns WHEN "1011",
                    x3 AFTER 2 ns WHEN "1100",
                    a(0) & a(31 downto 1) AFTER 1 ns WHEN "1101",
                    b(30 downto 0) & b(31) AFTER 1 ns WHEN "1110",
                    (OTHERS => '0') AFTER 1 ns WHEN OTHERS;
                    
END concurrent;

