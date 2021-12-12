LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY miniproc IS 
    PORT (
        clk, nrst   : IN    std_logic;
        opcode      : IN    std_logic_vector(3 DOWNTO 0)
    );
END miniproc; 
ARCHITECTURE behavioral OF miniproc IS
    TYPE state IS (T0, T1, T2, T3);
	SIGNAL current_state, next_state : state;
	-- Control signals
	SIGNAL a_ld 	: std_logic;
	SIGNAL b_ld 	: std_logic;
	SIGNAL c_ld 	: std_logic;
	SIGNAL d_ld 	: std_logic;
	SIGNAL acc_ld 	: std_logic;
	SIGNAL cbus : std_logic_vector(31 DOWNTO 0);
	SIGNAL sel 	: std_logic_vector(1 DOWNTO 0);
	SIGNAL func : std_logic_vector(1 DOWNTO 0);

    -- memory out
    SIGNAL memOut;
	
    -- ALU out
	SIGNAL Z 	: std_logic_vector(31 DOWNTO 0);

	-- Registers
	SIGNAL A 	: std_logic_vector(5 DOWNTO 0);
	SIGNAL B 	: std_logic_vector(31 DOWNTO 0);
	SIGNAL C 	: std_logic_vector(31 DOWNTO 0);
	SIGNAL D 	: std_logic_vector(31 DOWNTO 0);
	SIGNAL ACC 	: std_logic_vector(31 DOWNTO 0);

    COMPONENT memory IS 
        PORT (
            clk     :    IN std_logic;
            din     :    IN std_logic_vector(31 downto 0);
            addr    :    IN std_logic_vector(5 downto 0);
            wr      :    IN std_logic;
            dout    :    OUT std_logic_vector(31 downto 0)
        );
    END COMPONENT;

BEGIN

    -- memory instance
    mem : memory PORT MAP(clk, cbus, A, wr, memOut);

    -- bus mux
	cbus <= B       WHEN sel = "00" ELSE
			ACC     WHEN sel = "01" ELSE
            memOut;
			
	z   <= 	X + Y WHEN func = "00" ELSE
			Y	  WHEN func = "01" ELSE
			Y;
			
    controlpath: PROCESS (cur_state, opcode)
    BEGIN
		a_ld <= '0';
		b_ld <= '0';
		x_ld <= '0';
		y_ld <= '0';
		acc_ld <= '0';
		CASE cur_state is
			WHEN T0 =>
				CASE opcode IS
					WHEN "00"	=>	sel <= "01"; a_ld <= '1'; nxt_state <= T0;
					WHEN "01"   =>	sel <= "00"; x_ld <= '1'; nxt_state <= T1;
					WHEN "10"   =>  sel <= "10"; b_ld <= '1'; nxt_state <= T0;
                    WHEN "00"	=>	sel <= "01"; a_ld <= '1'; nxt_state <= T0;
					WHEN "01"   =>	sel <= "00"; x_ld <= '1'; nxt_state <= T1;
					WHEN "10"   =>  sel <= "10"; b_ld <= '1'; nxt_state <= T0;
                    WHEN "00"	=>	sel <= "01"; a_ld <= '1'; nxt_state <= T0;
					WHEN "01"   =>	sel <= "00"; x_ld <= '1'; nxt_state <= T1;
					WHEN "10"   =>  sel <= "10"; b_ld <= '1'; nxt_state <= T0;
                    WHEN "10"   =>  sel <= "10"; b_ld <= '1'; nxt_state <= T0;
					WHEN OTHERS =>	sel <= "00"; x_ld <= '1'; nxt_state <= T1;
				END CASE;
			WHEN T1 =>
				CASE opcode IS
					WHEN "01"   =>	sel <= "01"; y_ld <= '1'; nxt_state <= T2;
					WHEN OTHERS =>	sel <= "01"; y_ld <= '1'; nxt_state <= T2;
				END CASE;
			WHEN T2 =>
				CASE opcode IS
					WHEN "01"   =>	func <= "00"; acc_ld <= '1'; nxt_state <= T0;
					WHEN OTHERS =>	func <= "00"; acc_ld <= '1'; nxt_state <= T2;
				END CASE;
				nxt_state <= T3;
			WHEN OTHERS =>
				sel <= "10"; a_ld <= '1'; nxt_state <= T0;
				nxt_state <= T0;
		END CASE;
    END PROCESS controlpath;


    datapath: PROCESS (clk)
    BEGIN
        IF clk = '1' THEN
			IF nrst = '0' THEN
				cur_state <= T0;
				B <= X"00000001";
			ELSE
				IF a_ld = '1' THEN
					A <= cbus;
				END IF;
				IF b_ld = '1' THEN
					B <= cbus;
				END IF;
				IF x_ld = '1' THEN
					X <= cbus;
				END IF;
				IF y_ld = '1' THEN
					Y <= cbus;
				END IF;
				IF acc_ld = '1' THEN
					ACC <= z;
				END IF;
				cur_state <= nxt_state;
			END IF;
        END IF;
    END PROCESS datapath;

END behavioral;
