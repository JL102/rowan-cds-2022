
library ieee;
use ieee.std_logic_1164.all;

entity parrt_3 is
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


architecture rtl of parrt_3 is

		component fourbit_shiftReg
		port (
			pClock, serialInput,reset  	:in		std_logic;
			outQ            				:out   	std_logic_vector(3 downto 0)

			);
			end component;
		
		signal w	  			: std_logic;
		signal notW			: std_logic;
		signal notRestIn	: std_logic;
		signal clock 		: std_logic;
		signal restIn 		: std_logic;
		signal finalOut 	: std_logic;
		signal y_D,y_Q 	: std_logic_vector(8 downto 0);
		

begin

	clock <= KEY(0);
	restIn <= SW(0);
	w <= SW(1);
	
	notW <= not(w);
	
	ZeroShift: fourbit_shiftReg PORT MAP(clock, notW, restIn, y_D(4 downto 1));
	OneShift: fourbit_shiftReg PORT MAP(clock, w, restIn, y_D(8 downto 5));
	
	y_Q(0) <= NOT( y_D(1) OR y_D(2) OR y_D(3) OR y_D(4) OR y_D(5) OR y_D(6) OR y_D(7) OR y_D(8));
	y_Q(1) <= y_D(1) AND NOT(y_D(2) OR y_D(3) OR y_D(4));
	y_Q(2) <= y_D(1) AND y_D(2) AND NOT(y_D(3) OR y_D(4));
	y_Q(3) <= y_D(1) AND y_D(2) AND y_D(3) AND  NOT(y_D(4));
	y_Q(4) <= y_D(1) AND y_D(2) AND y_D(3) AND y_D(4);
	y_Q(5) <= y_D(5) AND NOT (y_D(6) OR y_D(7) OR y_D(8));
	y_Q(6) <= y_D(5) AND y_D(6) AND NOT (y_D(7) OR y_D(8));
	y_Q(7) <= y_D(5) AND y_D(6) AND y_D(7) AND NOT (y_D(8));
	y_Q(8) <= y_D(5) AND y_D(6) AND y_D(7) AND y_D(8);
	
	
	finalOut <= y_Q(4) OR y_Q(8);
	
	LEDR(8 downto 0) <= y_Q(8 downto 0);
	LEDR(9) <= finalOut;
	

end rtl;

