LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY UART IS
  PORT(
        start       : IN std_logic;
        clk         : IN std_logic;
        rst         : IN std_logic;
        rx          : IN std_logic;
        data_in     : IN std_logic_vector(7 downto 0);
        baud        : IN std_logic_vector(7 downto 0);
        tx          : OUT std_logic;
        data_ready  : OUT std_logic;
        data_outt   : OUT std_logic_vector(7 downto 0)
	);
END UART;
ARCHITECTURE uart OF UART IS
    --SIGNAL new_clk     :   std_logic   := '0';
    --SIGNAL start_reg   :   std_logic   := '0';
    --SIGNAL data_in_reg : std_logic_vector(7 downto 0)   := (OTHERS => '0');
BEGIN

    --PROCESS (clk)
    --    VARIABLE counter : INTEGER RANGE 0 TO 256 := 0;
    --    VARIABLE limit : INTEGER := to_integer(unsigned(baud));
    --BEGIN
    --    IF (clk = '1' AND clk'EVENT) THEN
    --        IF (counter = limit) THEN
    --            new_clk <= '1';
    --            counter := 0;
    --        ELSE
    --            counter := counter + 1;
    --            new_clk <= '0';
    --        END IF;
    --    END IF;
    --END PROCESS;


    --- P2S
    PROCESS(clk, rst)
        VARIABLE baud_counter   : INTEGER := 0;
        VARIABLE baud_limit     : INTEGER := to_integer(unsigned(baud));
        VARIABLE counter        : INTEGER := 0;
        VARIABLE start_reg      : std_logic;
        VARIABLE data_in_reg    : std_logic_vector(7 downto 0);
    BEGIN 
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                tx <= '1';
            ELSE
                IF (start = '1') THEN
                    start_reg := '1';
                    data_in_reg := data_in;
                END IF;
                IF (start_reg = '1') THEN
                    IF (baud_counter = 0) THEN
                        IF (counter = 0) THEN
                            tx <= '0';
                        ELSIF (counter = 8) THEN
                            counter := 0;
                        END IF;
                        tx <= data_in_reg(counter);
                        counter := counter + 1;
                    END IF;
                    IF (baud_counter = baud_limit) THEN
                        baud_counter := 0;
                    END IF;
                    IF (baud_counter = 0 AND counter = 0) THEN
                        start_reg := '0';
                        tx <= '1';
                    END IF;
                    baud_counter := baud_counter + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END uart;
		

