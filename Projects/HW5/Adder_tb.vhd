LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Adder_tb IS
END Adder_tb;

ARCHITECTURE test OF Adder_tb IS 
    COMPONENT Adder IS 
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
    END COMPONENT;

    signal a,b,sum : std_logic_vector(7 downto 0);
    signal start,rst,cout,done : std_logic;
    signal clk : std_logic := '0';
BEGIN 

    UUT: Adder GENERIC MAP (n 	=> 8)
    PORT MAP(a => a, b => b, start => start, clk => clk, rst => rst, cout => cout, done => done, sum => sum);

    PROCESS 
    BEGIN
        clk <= NOT clk;
        wait for 5 ns;
    END PROCESS;
    rst <= '1', '0' after 10 ns, '1' after 110 ns, '0' after 120 ns;
    a <= "01010011", "11100001" after 110 ns;
    b <= "00001110", "10100110" after 110 ns;
    start <= '1' after 20 ns, '0' after 30 ns, '1' after 110 ns;


END test;
