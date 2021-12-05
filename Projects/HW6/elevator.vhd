LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Elevator IS 
    PORT(
        clk             : IN std_logic;
        rst             : IN std_logic;
        come            : IN std_logic_vector(3 downto 0);
        cf              : IN std_logic_vector(3 downto 0);
        switch          : IN std_logic_vector(3 downto 0);
        motor_up        : OUT std_logic;
        motor_down      : OUT std_logic;
        elevator_state  : OUT std_logic;
        -- current floor = "0000" vaghti ke bein tabaghate
        current_floor   : OUT std_logic_vector(3 downto 0)
    );
END Elevator;
ARCHITECTURE elevator OF Elevator IS  
    TYPE state IS (F1, F2, F3, F4, DOWN, UP);
    SIGNAL current_state, next_state : state;

    -- outputs = motorUp_motorDown_elevatorState_currentFloor
    -- elevator state : 0 = sabet   1 = dar hal harekat
    SIGNAL outputs : std_logic_vector(6 downto 0);
BEGIN  

    -- meghdar dehiye current_state
    PROCESS (clk)
    BEGIN
        IF (clk = '1' AND clk'EVENT) THEN
            IF (rst = '1') THEN
                current_state <= F1;
            ELSE
                current_state <= next_state;
            END IF;
        END IF;
    END PROCESS;

    -- meghdar dehiye next_state
    PROCESS (come, cf, switch)
    BEGIN 
        CASE current_state IS 
            WHEN F1 =>
                IF (come = "0010" OR come = "0100" OR come = "1000" OR cf = "0010" OR cf = "0100" OR cf = "1000") THEN
                    next_state <= UP;
                ELSE
                    next_state <= F1;
                END IF;
            WHEN F2 =>
                IF (come = "0100" OR come = "1000" OR cf = "0100" OR cf = "1000") THEN
                    next_state <= UP;
                ELSIF (come = "0001" OR cf = "0001") THEN
                    next_state <= DOWN;
                ELSE
                    next_state <= F2;
                END IF;
            WHEN F3 =>
                IF (come = "1000" OR cf = "1000") THEN
                    next_state <= UP;
                ELSIF (come = "0010" OR come = "0001" OR cf = "0010" OR cf = "0001") THEN
                    next_state <= DOWN;
                ELSE
                    next_state <= F3;
                END IF;
            WHEN F4 =>
                IF (come = "0001" OR come = "0010" OR come = "0100" OR cf = "0001" OR cf = "0010" OR cf = "0100") THEN
                    next_state <= DOWN;
                ELSE
                    next_state <= F4;
                END IF;
            WHEN UP =>
                IF (switch = "0010" AND (come = "0010" OR cf = "0010")) THEN
                    next_state <= F2;
                ELSIF (switch = "0100" AND (come = "0100" OR cf = "0100")) THEN
                    next_state <= F3;
                ELSIF (switch = "1000" AND (come = "1000" OR cf = "1000")) THEN
                    next_state <= F4;
                ELSE
                    next_state <= UP;
                END IF;
            WHEN DOWN =>
                IF (switch = "0001" AND (come = "0001" OR cf = "0001")) THEN
                    next_state <= F1;
                ELSIF (switch = "0010" AND (come = "0010" OR cf = "0010")) THEN
                    next_state <= F2;
                ELSIF (switch = "0100" AND (come = "0100" OR cf = "0100")) THEN
                    next_state <= F3;
                ELSE
                    next_state <= DOWN;
                END IF;
        END CASE;
    END PROCESS;


    -- khorooji har state
    PROCESS (come, cf, switch, clk)
    BEGIN 
        CASE current_state IS 
            WHEN F1 =>
                outputs <= "0000001";
            WHEN F2 =>
                outputs <= "0000010";
            WHEN F3 =>
                outputs <= "0000100";
            WHEN F4 =>
                outputs <= "0001000";
            WHEN UP =>
                IF (switch = "0010") THEN
                    outputs <= "1010010";
                ELSIF (switch = "0100") THEN
                    outputs <= "1010100";
                ELSIF (switch = "1000") THEN
                    outputs <= "1011000";
                ELSE
                    outputs <= "1010000";
                END IF;
            WHEN DOWN =>
                IF (switch = "0001") THEN
                    outputs <= "0110001";
                ELSIF (switch = "0010") THEN
                    outputs <= "0110010";
                ELSIF (switch = "0100") THEN
                    outputs <= "0110100";
                ELSE
                    outputs <= "0110000";
                END IF;
        END CASE;
    END PROCESS;

    motor_up <= outputs(6);
    motor_down <= outputs(5);
    elevator_state <= outputs(4);
    current_floor <= outputs(3 DOWNTO 0);
    
END elevator;