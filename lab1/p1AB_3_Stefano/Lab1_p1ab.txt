
library ieee;
use ieee.std_logic_1164.all;

entity Lab_1 is
port
(

	------------ KEY ------------
	KEY             	:in    	std_logic_vector(3 downto 0);

	------------ SW ------------
	SW              	:in    	std_logic_vector(9 downto 0);

	------------ LED ------------
	LEDR            	:out   	std_logic_vector(9 downto 0)

	
);

end entity;



---------------------------------------------------------
--  Structural coding
---------------------------------------------------------


architecture rtl of Lab_1 is

	component D_FlipFlop
	port (
		Clk, D, rst		: in std_logic;
		Q					: out std_logic
		);
		end component;
		
		signal w	  			: std_logic;
		signal notRestIn	: std_logic;
		signal clock 		: std_logic;
		signal restIn 		: std_logic;
		signal finalOut 	: std_logic;
		signal y_Q,y_D 	: std_logic_vector(8 downto 0);

begin

	clock <= KEY(0);
	restIn <= SW(0);
	w <= SW(1);
	
	-- y_D(1) <= (y_Q(0) OR y_Q(5) OR y_Q(6) OR y_Q(7) OR y_Q(8)) AND NOT (w); -- Lab p1a
	
	y_D(1) <= (NOT(y_Q(0)) OR y_Q(5) OR y_Q(6) OR y_Q(7) OR y_Q(8)) AND NOT (w); -- Lab p1b
	y_D(2) <= y_Q(1) AND NOT (w); 
	y_D(3) <= y_Q(2) AND NOT w;
	y_D(4) <= (y_Q(3) OR y_Q(4)) AND NOT w;
	y_D(5) <= (NOT(y_Q(0)) OR y_Q(1) OR y_Q(2) OR y_Q(3) OR y_Q(4)) AND w; 
	y_D(6) <= y_Q(5) AND w;
	y_D(7) <= y_Q(6) AND w; 
	y_D(8) <= (y_Q(7) OR y_Q(8)) AND w;
	
	notRestIn <= not(restIn);
	
	--A: D_FlipFlop PORT MAP(clock, notrestIn, notrestIn, y_Q(0)); -- Lab p1a
	A: D_FlipFlop PORT MAP(clock, '1', restIn, y_Q(0)); -- Lab p1b
	B: D_FlipFlop PORT MAP(clock, y_D(1), restIn, y_Q(1));
	C: D_FlipFlop PORT MAP(clock, y_D(2), restIn, y_Q(2));
	D: D_FlipFlop PORT MAP(clock, y_D(3), restIn, y_Q(3));
	E: D_FlipFlop PORT MAP(clock, y_D(4), restIn, y_Q(4));
	F: D_FlipFlop PORT MAP(clock, y_D(5), restIn, y_Q(5));
	G: D_FlipFlop PORT MAP(clock, y_D(6), restIn, y_Q(6));
	H: D_FlipFlop PORT MAP(clock, y_D(7), restIn, y_Q(7));
	I: D_FlipFlop PORT MAP(clock, y_D(8), restIn, y_Q(8));
	
	finalOut <= y_Q(4) OR y_Q(8);
	
	LEDR(8 downto 0) <= y_Q(8 downto 0);
	LEDR(9) <= finalOut;


end rtl;

