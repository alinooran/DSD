LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.numeric_std.ALL;

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
        data_out   : OUT std_logic_vector(7 downto 0)
	);
END UART;
ARCHITECTURE uart OF UART IS
    SIGNAL baud_limit   : INTEGER RANGE 0 TO 255;
BEGIN

    baud_limit <= to_integer(unsigned(baud));
    
    --- P2S
    PROCESS(clk)
        VARIABLE baud_counter   : INTEGER;
        --VARIABLE baud_limit     : INTEGER := 0;
        VARIABLE counter        : INTEGER;
        VARIABLE start_reg      : std_logic;
        VARIABLE data_in_reg    : std_logic_vector(7 downto 0);
    BEGIN 
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                --baud_limit := to_integer(unsigned(baud));
                tx <= '1';
                start_reg := '0';
                data_in_reg := (OTHERS => '0');
                baud_counter := 0;
                counter := 0;
            ELSE
                IF (start = '1') THEN
                    start_reg := '1';
                    data_in_reg := data_in;
                END IF;
                IF (start_reg = '1') THEN
                    IF (baud_counter = 0) THEN
                        IF (counter = 0) THEN
                            tx <= '0';
                        ELSE
                            tx <= data_in_reg(counter - 1);
                        END IF;
                        counter := counter + 1;
                    END IF;
                    baud_counter := baud_counter + 1;
                    IF (baud_counter = baud_limit) THEN
                        IF (counter = 9) THEN
                            start_reg := '0';
                            counter := 0;
                            tx <= '1';
                            data_in_reg := (OTHERS => '0');
                        END IF;
                        baud_counter := 0;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    --- S2P
    PROCESS(clk)
        VARIABLE baud_counter   : INTEGER;
        VARIABLE counter        : INTEGER RANGE 0 TO 10;
        VARIABLE start_reg      : std_logic;
        VARIABLE data_out_reg    : std_logic_vector(7 downto 0);
    BEGIN 
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '1') THEN
                data_out <= (OTHERS => '0');
                start_reg := '0';
                data_out_reg := (OTHERS => '0');
                baud_counter := 0;
                counter := 0;
                data_ready <= '0';
            ELSE
                IF(start_reg = '0') THEN
                    IF (rx = '0') THEN
                        start_reg := '1';
                        baud_counter := 0;
                        counter := 0;
                        data_out_reg := (OTHERS => '0');
                        data_ready <= '0';
                        data_out <= (OTHERS => '0');
                    END IF;
                END IF;
                IF (start_reg = '1') THEN
                    baud_counter := baud_counter + 1;
                    IF (baud_counter = 1) THEN
                        counter := counter + 1;
                        IF (counter = 1) THEN
                        ELSIF (counter = 10) THEN
                            start_reg := '0';
                            data_ready <= '1';
                            data_out <= data_out_reg;
                        ELSE
                            data_out_reg(counter - 2) := rx;
                        END IF;
                    ELSIF (baud_counter = baud_limit) THEN
                        baud_counter := 0;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END uart;
		

