LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY alu_test IS
END alu_test;

ARCHITECTURE test OF alu_test IS 
    signal a,b : std_logic_vector(31 downto 0);
    signal cin : std_logic;
    signal func: std_logic_vector(3 downto 0);
    signal y   : std_logic_vector(31 downto 0);
    signal cout: std_logic;
BEGIN 
    UUT : entity work.alu port map(a => a, b => b, cin => cin, func => func, y => y, cout => cout);
    a <= X"ffffffff", X"00001001" after 10 ns;
    b <= X"00000000", X"0000000e" after 10 ns;
    cin <= '1';
    func <= "1000", "0011" after 20 ns, "0101" after 30 ns, "0111" after 40 ns, "1001" after 50 ns,
            "1011" after 60 ns, "1101" after 70 ns;
    -- 0 ns : add with carry out
    -- 10 ns : add without carry out
    -- 20 ns : a XOR b
    -- 30 ns : hw(a)
    -- 40 ns : -a
    -- 50 ns : a-b
    -- 60 ns : 1 if a<b else 0
    -- 70 ns : ror(a)
END test;
