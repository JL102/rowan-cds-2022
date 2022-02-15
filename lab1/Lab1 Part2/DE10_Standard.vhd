
---------------------------------------------------------
--  This code is generated by Terasic System Builder
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity DE10_Standard is
port
(

	------------ CLOCK ------------
	CLOCK2_50       	:in    	std_logic;
	CLOCK3_50       	:in    	std_logic;
	CLOCK4_50       	:in    	std_logic;
	CLOCK_50        	:in    	std_logic;

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


architecture rtl of DE10_Standard is

-- declare --

begin

-- body --

end rtl;
