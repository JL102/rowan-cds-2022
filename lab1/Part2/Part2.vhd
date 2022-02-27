library ieee; 
use ieee.std_logic_1164.all; 
entity part2 is 
port(
	KEY : 	in std_logic_vector(3 downto 0);
	SW : 	in std_logic_vector(9 downto 0);
	LEDR : 	out std_logic_vector(9 downto 0)
);
end part2; 
architecture rtl of part2 is 
	-- signal Y_Q, Y_D : std_logic_vector(8 downto 0);
	signal Clk, Reset, W, Z : std_logic; -- W is "in", Z is "out"
	
	type State_type is (A, B, C, D, E, F, G, H, I); 
	-- Attribute to declare a specific encoding for the states 
	attribute syn_encoding : string; 
	attribute syn_encoding of State_type : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000";
	-- y_Q is present state, y_D is next state 
	signal Y_Q, Y_D : State_type;
begin 
	Clk <= KEY(0); 	-- Key 0: Clock
	W <= SW(1); 	-- Switch 1: Input (second to last one)
	Reset <= SW(0); -- Switch 0: Reset (last one)
	LEDR(0) <= Z;	-- LED: Output
	
    process (W, Y_Q) -- state table 
    begin 
        case Y_Q is 
            when A  =>
				if (W = '0') then Y_D <= B; else Y_D <= F; end if;
			when B =>
				if (W = '0') then Y_D <= C; else Y_D <= F; end if;
			when C =>
				if (W = '0') then Y_D <= D; else Y_D <= F; end if;
			when D =>
				if (W = '0') then Y_D <= E; else Y_D <= F; end if;
			when E =>
				if (W = '0') then Y_D <= E; else Y_D <= F; end if;
			when F => 
				if (W = '1') then Y_D <= G; else Y_D <= B; end if;
			when G =>
				if (W = '1') then Y_D <= H; else Y_D <= B; end if;
			when H =>
				if (W = '1') then Y_D <= I; else Y_D <= B; end if;
			when I =>
				if (W = '1') then Y_D <= I; else Y_D <= B; end if;
        end case; 
        case Y_Q is 
            when A  =>
				LEDR(9 downto 1) <= "100000000";
			when B =>
				LEDR(9 downto 1) <= "010000000";
			when C =>
				LEDR(9 downto 1) <= "001000000";
			when D =>
				LEDR(9 downto 1) <= "000100000";
			when E =>
				LEDR(9 downto 1) <= "000010000";
			when F => 
				LEDR(9 downto 1) <= "000001000";
			when G =>
				LEDR(9 downto 1) <= "000000100";
			when H =>
				LEDR(9 downto 1) <= "000000010";
			when I =>
				LEDR(9 downto 1) <= "000000001";
        end case; 
    end process;  
    process (Clk, Reset) -- state flip-flops 
    begin 
		if rising_edge(Clk) then
			if Reset = '1' then
				Y_Q <= A; -- reset state
			else 
				Y_Q <= Y_D; -- instructing it to act like a D flip flop
			end if;
		end if;
    end process; 
    -- assignments for output z and the leds 
	Z <= '1' when (Y_Q = E or Y_Q = I) else '0';
end rtl; 