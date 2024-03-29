LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.ALL;

ENTITY miniproc IS
	PORT (
		clk, nrst : IN STD_LOGIC;
		opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END miniproc;
ARCHITECTURE behavioral OF miniproc IS
	TYPE state IS (T0, T1, T2, T3, T4, T5);
	SIGNAL current_state, next_state : state;
	-- Control signals
	SIGNAL a_ld : STD_LOGIC;
	SIGNAL b_ld : STD_LOGIC;
	SIGNAL c_ld : STD_LOGIC;
	SIGNAL d_ld : STD_LOGIC;
	SIGNAL acc_ld : STD_LOGIC;
	SIGNAL wr : STD_LOGIC;
	SIGNAL cbus : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL func : STD_LOGIC_VECTOR(2 DOWNTO 0);

	-- memory out
	SIGNAL memOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- shifter result
	SIGNAL res : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- ALU out
	SIGNAL Z : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Registers
	SIGNAL A : STD_LOGIC_VECTOR(5 DOWNTO 0) := "001100";
	SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00010001";
	SIGNAL C : STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000003";
	SIGNAL D : STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000020";
	SIGNAL ACC : STD_LOGIC_VECTOR(31 DOWNTO 0);

	COMPONENT sram IS
		PORT (
			clk : IN STD_LOGIC;
			din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			addr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			wr : IN STD_LOGIC;
			dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT shifter IS
		PORT (
			a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			b : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			res : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

BEGIN

	-- memory instance
	mem : sram PORT MAP(clk, cbus, A, wr, memOut);

	-- shifter instance
	sh : shifter PORT MAP(D, C(4 DOWNTO 0), res);

	-- bus mux
	cbus <= B WHEN sel = "00" ELSE
		ACC WHEN sel = "01" ELSE
		memOut;

	Z <= C WHEN func = "000" ELSE
		D WHEN func = "001" ELSE
		C + D WHEN func = "010" ELSE
		C AND D WHEN func = "011" ELSE
		C XOR D WHEN func = "100" ELSE
		C - D WHEN func = "101" ELSE
		res;

	controlpath : PROCESS (current_state, opcode)
	BEGIN
		a_ld <= '0';
		b_ld <= '0';
		c_ld <= '0';
		d_ld <= '0';
		acc_ld <= '0';
		func <= "000";
		wr <= '0';
		CASE current_state IS
			WHEN T0 =>
				CASE opcode IS
					WHEN "0000" => func <= "000";
						acc_ld <= '1';
						next_state <= T0;
					WHEN "0001" => func <= "001";
						acc_ld <= '1';
						next_state <= T0;
					WHEN "0010" => func <= "010";
						acc_ld <= '1';
						next_state <= T0;
					WHEN "0011" => sel <= "00";
						d_ld <= '1';
						next_state <= T1;
					WHEN "0100" => sel <= "00";
						d_ld <= '1';
						next_state <= T1;
					WHEN "0101" => sel <= "10";
						c_ld <= '1';
						next_state <= T1;
					WHEN "0110" => sel <= "01";
						wr <= '1';
						next_state <= T0;
					WHEN "0111" => sel <= "00";
						a_ld <= '1';
						next_state <= T1;
					WHEN "1000" => func <= "000";
						acc_ld <= '1';
						next_state <= T1;
					WHEN "1001" => sel <= "00";
						d_ld <= '1';
						next_state <= T1;
					WHEN "1010" => sel <= "00";
						d_ld <= '1';
						next_state <= T1;
					WHEN OTHERS => next_state <= T0;
				END CASE;
			WHEN T1 =>
				CASE opcode IS
					WHEN "0011" => func <= "011";
						acc_ld <= '1';
						next_state <= T0;
					WHEN "0100" => func <= "100";
						acc_ld <= '1';
						next_state <= T0;
					WHEN "0101" => func <= "000";
						acc_ld <= '1';
						next_state <= T0;
					WHEN "0111" => sel <= "10";
						d_ld <= '1';
						next_state <= T2;
					WHEN "1000" => sel <= "01";
						a_ld <= '1';
						next_state <= T2;
					WHEN "1001" => func <= "100";
						acc_ld <= '1';
						next_state <= T2;
					WHEN "1010" => func <= "110";
						acc_ld <= '1';
						next_state <= T2;
					WHEN OTHERS => next_state <= T0;
				END CASE;
			WHEN T2 =>
				CASE opcode IS
					WHEN "0111" => func <= "000";
						acc_ld <= '1';
						next_state <= T3;
					WHEN "1000" => sel <= "10";
						d_ld <= '1';
						next_state <= T3;
					WHEN "1001" => sel <= "01";
						wr <= '1';
						next_state <= T0;
					WHEN "1010" => sel <= "01";
						wr <= '1';
						next_state <= T0;
					WHEN OTHERS => next_state <= T0;
				END CASE;
			WHEN T3 =>
				CASE opcode IS
					WHEN "0111" => sel <= "01";
						a_ld <= '1';
						next_state <= T4;
					WHEN "1000" => sel <= "00";
						a_ld <= '1';
						next_state <= T4;
					WHEN OTHERS => next_state <= T0;
				END CASE;
			WHEN T4 =>
				CASE opcode IS
					WHEN "0111" => sel <= "10";
						c_ld <= '1';
						next_state <= T5;
					WHEN "1000" => sel <= "10";
						c_ld <= '1';
						next_state <= T5;
					WHEN OTHERS => next_state <= T0;
				END CASE;
			WHEN T5 =>
				CASE opcode IS
					WHEN "0111" => func <= "010";
						acc_ld <= '1';
						next_state <= T0;
					WHEN "1000" => func <= "101";
						acc_ld <= '1';
						next_state <= T0;
					WHEN OTHERS => next_state <= T0;
				END CASE;
		END CASE;
	END PROCESS controlpath;
	datapath : PROCESS (clk)
	BEGIN
		IF clk = '1' THEN
			IF nrst = '1' THEN
				current_state <= T0;
			ELSE
				IF a_ld = '1' THEN
					A <= cbus(5 DOWNTO 0);
				END IF;
				IF b_ld = '1' THEN
					B <= cbus;
				END IF;
				IF c_ld = '1' THEN
					C <= cbus;
				END IF;
				IF d_ld = '1' THEN
					D <= cbus;
				END IF;
				IF acc_ld = '1' THEN
					ACC <= z;
				END IF;
				current_state <= next_state;
			END IF;
		END IF;
	END PROCESS datapath;

END behavioral;