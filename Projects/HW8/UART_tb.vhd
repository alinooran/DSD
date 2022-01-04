LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UART_tb IS
END UART_tb;

ARCHITECTURE test OF UART_tb IS 
    COMPONENT UART IS 
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
    END COMPONENT;

    SIGNAL start       : std_logic;
    SIGNAL clk         : std_logic := '0';
    SIGNAL rst         : std_logic;
    SIGNAL rx          : std_logic;
    SIGNAL data_in     : std_logic_vector(7 downto 0);
    SIGNAL baud        : std_logic_vector(7 downto 0);
    SIGNAL tx          : std_logic;
    SIGNAL data_ready  : std_logic;
    SIGNAL data_out    : std_logic_vector(7 downto 0);
    
BEGIN 

    clk <= NOT clk AFTER 5 ns;
    

    UUT: UART PORT MAP(start, clk, rst, rx, data_in, baud, tx, data_ready, data_out);
    
    rst <= '1', '0' after 10 ns;

    start <= '1' after 20 ns, '0' after 30 ns;

    data_in <= "00010101" after 20 ns, "00000000" after 30 ns;

    baud <= "00000010";

    rx <= '1', '0' after 20 ns, '0' after 40 ns, '1' after 60 ns, '0' after 80 ns, '1' after 100 ns,
     '0' after 120 ns, '0' after 140 ns, '0' after 160 ns, '0' after 180 ns, '1' after 200 ns;
    


END test;