LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE work.ALL;

ENTITY P7_tb IS
END P7_tb;

ARCHITECTURE test OF P7_tb IS 
    COMPONENT miniproc IS 
        PORT (
	    	clk, nrst : IN STD_LOGIC;
	    	opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	    );
    END COMPONENT;

    --SIGNAL rst, motor_up, motor_down, elevator_state : std_logic;
    --SIGNAL come, cf, switch, current_floor : std_logic_vector(3 downto 0);
    SIGNAL opcode : std_logic_vector(3 downto 0);
    SIGNAL clk : std_logic := '0';
    SIGNAL nrst : std_logic;
    SIGNAL PERIOD  : TIME := 10 ns;
BEGIN 

    clk <= NOT clk AFTER 5 ns;
    --read_test_vector_from_file(PERIOD, rst, cf, come, switch);
    UUT: miniproc PORT MAP(clk, nrst, opcode);
    nrst <= '1', '0' after 10 ns;
    opcode <= "0010" after 20 ns, "0110" after 30 ns, "0111" after 40 ns;

END test;