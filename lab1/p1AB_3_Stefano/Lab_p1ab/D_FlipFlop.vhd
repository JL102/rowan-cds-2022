

library ieee;
use ieee.std_logic_1164.all;

entity D_FlipFlop is
port
(
	Clk, D, rst 	: in std_logic;
	Q					: out std_logic
	) ;
	
end entity;



---------------------------------------------------------
--  Structural coding
---------------------------------------------------------


architecture imp of D_FlipFlop is

begin

	process (Clk)
	begin
		if rising_edge(Clk) then 
			if rst = '1' then
				Q <= D;
			else
				Q <= '0';
			end if;
			
		end if;
	end process;

end imp;

