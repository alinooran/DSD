LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE work.ALL;
USE work.my_pack.ALL;

ENTITY P7_tb IS
END P7_tb;

ARCHITECTURE test OF P7_tb IS 
    COMPONENT miniproc IS 
        PORT (
	    	clk, nrst : IN STD_LOGIC;
	    	opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	    );
    END COMPONENT;

    SIGNAL opcode : std_logic_vector(3 downto 0);
    SIGNAL clk : std_logic := '0';
    SIGNAL nrst : std_logic;
    SIGNAL PERIOD  : TIME := 10 ns;
BEGIN 

    clk <= NOT clk AFTER 5 ns;
    
    read_test_vector_from_file(PERIOD, opcode, nrst);

    UUT: miniproc PORT MAP(clk, nrst, opcode);
    


END test;