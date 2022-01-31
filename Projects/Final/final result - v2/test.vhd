LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY kasumi_tb IS
END kasumi_tb;

ARCHITECTURE test OF kasumi_tb IS 
    COMPONENT KASUMI IS 
        PORT(
            clk, rst :   IN std_logic;
            inp      :   IN   std_logic_vector(63 downto 0);
            key      :   IN   std_logic_vector(127 downto 0);
            outp     :   OUT std_logic_vector(63 downto 0)
        );
    END COMPONENT;

    SIGNAL clk : std_logic := '0';
    SIGNAL rst : std_logic;
    SIGNAL inp : std_logic_vector(63 downto 0);
    SIGNAL key : std_logic_vector(127 downto 0);
    SIGNAL outp: std_logic_vector(63 downto 0);   
BEGIN 
    clk <= NOT clk AFTER 5 ns;
    UUT: KASUMI PORT MAP (clk, rst, inp, key, outp);

    rst <= '1', '0' AFTER 20 ns;
    inp <= X"9f8115571e526dad";
    key <= X"4f1271c53d8e98504f1271c53d8e9850";
END test;