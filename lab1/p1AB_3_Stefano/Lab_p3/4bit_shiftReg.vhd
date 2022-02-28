
library ieee;
use ieee.std_logic_1164.all;

entity 4bit_shiftReg is
port
(
	pClock, serialInput,reset  	:in		std_logic;

	outQ            				:out   	std_logic_vector(3 downto 0)

	
);

end entity;



---------------------------------------------------------
--  Structural coding
---------------------------------------------------------


architecture imp of 4bit_shiftReg is

	component D_FlipFlop
	port (
		Clk, D, rst		: in std_logic;
		Q					: out std_logic
		);
		end component;
		
		signal w	  			: std_logic;
		signal clock		: std_logic;
		signal restIn 		: std_logic;
		signal y_Q,y_D 	: std_logic_vector(3 downto 0);

begin

	clock <= qClock;
	restIn <= reset;
	w <= serialInput;
	
	--y_Q <= SW(2);
	
	y_D(0) <= w;
	y_D(1) <= y_Q(0);
	y_D(2) <= y_Q(1);
	y_D(3) <= y_Q(2);

	U0: D_FlipFlop PORT MAP(clock, y_D(0), restIn, y_Q(0));
	U1: D_FlipFlop PORT MAP(clock, y_D(1), restIn, y_Q(1));
	U2: D_FlipFlop PORT MAP(clock, y_D(2), restIn, y_Q(2));
	U3: D_FlipFlop PORT MAP(clock, y_D(3), restIn, y_Q(3));
	
	outQ(3 downto 0) <= y_Q(3 downto 0);


end imp;
