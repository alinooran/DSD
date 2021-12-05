LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE work.my_pack.ALL;

ENTITY elevator_tb IS
END elevator_tb;

ARCHITECTURE test OF elevator_tb IS 
    COMPONENT Elevator IS 
    PORT(
        clk             : IN std_logic;
        rst             : IN std_logic;
        come            : IN std_logic_vector(3 downto 0);
        cf              : IN std_logic_vector(3 downto 0);
        switch          : IN std_logic_vector(3 downto 0);
        motor_up        : OUT std_logic;
        motor_down      : OUT std_logic;
        elevator_state  : OUT std_logic;
        current_floor   : OUT std_logic_vector(3 downto 0)
    );
    END COMPONENT;

    SIGNAL rst, motor_up, motor_down, elevator_state : std_logic;
    SIGNAL come, cf, switch, current_floor : std_logic_vector(3 downto 0);
    SIGNAL clk : std_logic := '0';
    SIGNAL PERIOD  : TIME := 10 ns;
BEGIN 

    clk <= NOT clk AFTER 5 ns;
    read_test_vector_from_file(PERIOD, rst, cf, come, switch);
    UUT: Elevator PORT MAP(clk, rst, come, cf, switch, motor_up, motor_down, elevator_state, current_floor);

END test;
