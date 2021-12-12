LIBRARY ieee;
USE IEEE.std_logic_1164.ALL;
 ENTITY sram IS 
    PORT (
        clk     :    IN std_logic;
        din     :    IN std_logic_vector(31 downto 0);
        addr    :    IN std_logic_vector(5 downto 0);
        wr      :    IN std_logic;
        dout    :    OUT std_logic_vector(31 downto 0)
    );
 END sram;
 ARCHITECTURE sram OF sram IS 
    TYPE ram IS ARRAY (0 TO 63) OF std_logic_vector(31 downto 0);
    SIGNAL memory : ram := (OTHERS => (OTHERS => '0'));
 BEGIN 
    PROCESS (clk, wr)

    dout <= memory(addr);

    BEGIN 
        IF (wr = '1') THEN 
            IF (clk'EVENT AND clk = '1') THEN 
                memory(addr) <= din;
            END IF;
        END IF;
    END PROCESS:
 END sram;