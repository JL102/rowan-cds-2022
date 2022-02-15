library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- fourconseq: Detects either four consecutive zeros or ones (with rollover) as a state machine

entity fourconseq is
port(
	KEY : 	in std_logic_vector(3 downto 0);
	SW : 	in std_logic_vector(9 downto 0);
	LEDR : 	out std_logic_vector(8 downto 0));
end fourconseq;

architecture imp of fourconseq is
	component flipflop is
		port (Clk, D : in std_logic;
		Q : out std_logic);
	end component;
	
	signal Y : std_logic_vector(8 downto 0); -- next state
	signal X : std_logic_vector(8 downto 0); -- previous state
	signal Clk, Reset, W, Z : std_logic; -- W is "in", Z is "out"
begin
	Clk <= KEY(0); 	-- Key 0: Clock
	W <= SW(1); 	-- Switch 1: Input
	Reset <= SW(1); -- Switch 2: Reset
	LEDR(0) <= Z;	-- LED: Output
	
	-- tie the flip flops to the appropriate state thingys
	F0 : flipflop port map (Clk, Y(0), X(0));
	F1 : flipflop port map (Clk, Y(1), X(1));
	F2 : flipflop port map (Clk, Y(2), X(2));
	F3 : flipflop port map (Clk, Y(3), X(3));
	F4 : flipflop port map (Clk, Y(4), X(4));
	F5 : flipflop port map (Clk, Y(5), X(5));
	F6 : flipflop port map (Clk, Y(6), X(6));
	F7 : flipflop port map (Clk, Y(7), X(7));
	F8 : flipflop port map (Clk, Y(8), X(8));
	
	process (Clk)
	begin
		if rising_edge(Clk) then
			if Reset = '1' then
				Y <= "000000001";
			else
				-- Below: input/state logic
				Y(1) <= not(W) and not(X(2)) and not(X(3)) and not(X(4));
				Y(2) <= not(W) and X(1);
				Y(3) <= not(W) and X(2);
				Y(4) <= not(W) and (X(3) or X(4));
				Y(5) <= W and not(X(6)) and not(X(7)) and not(X(8));
				Y(6) <= W and X(5);
				Y(7) <= W and X(6);
				Y(8) <= W and (X(7) or X(8));
				
				-- Below: output logic
				Z <= X(4) or X(8);
			end if;
		end if;
	end process;
end imp;