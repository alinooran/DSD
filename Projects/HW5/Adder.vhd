LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Adder IS 
    GENERIC (n : integer := 8);
    PORT(
        a     : IN std_logic_vector(n-1 downto 0);
        b     : IN std_logic_vector(n-1 downto 0);
        start : IN std_logic;
        clk   : IN std_logic;
        rst   : IN std_logic;
        cout  : OUT std_logic;
        done  : OUT std_logic;
        sum   : OUT std_logic_vector(n-1 downto 0)
    );
END Adder;
ARCHITECTURE adder OF Adder IS    
BEGIN  
    PROCESS (clk)
        VARIABLE c           : std_logic_vector(n downto 0) := (OTHERS => '0');
        VARIABLE i           : integer RANGE 0 TO n := 0;
        VARIABLE isStarted   : BOOLEAN := false;
    BEGIN 
        IF (rst = '1') THEN
            sum <= (OTHERS => '0');
            cout <= '0';
            done <= '0';
            isStarted := false;
            i := 0;
            c := (OTHERS => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            if1:IF (start = '1') THEN
                isStarted := true;
            END IF if1;
            if2:IF (isStarted = true) THEN
                sum(i) <= a(i) XOR b(i) XOR c(i);
                c(i+1) := (a(i) AND b(i)) OR (c(i) AND a(i)) OR (c(i) AND b(i));
                i := i + 1;
                if3:IF (i = n) THEN
                    done <= '1';
                    cout <= c(n);
                    isStarted := false;
                END IF if3;
            END IF if2;
        END IF;
    END PROCESS;
END adder;