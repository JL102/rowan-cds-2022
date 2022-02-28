library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use std.env.stop;

entity Lab_1_tb is
end entity;

architecture tb of Lab_1_tb is
signal clk : std_logic_vector(3 downto 0) := "0000";
signal sw : std_logic_vector(9 downto 0);-- := (others => '0');
signal outLEDs : std_logic_vector(9 downto 0); --:= (others => '0');

begin
	clk(0) <= not clk(0) after 20 ns;
	
	process
	begin
		wait for 100 ns;
		sw(0) <= '0';
		sw(1) <= '0';
		wait for 200 ns;
		sw(0) <= '1';
		sw(1) <= '1';
		wait for 200 ns;
		sw(0) <= '1';
		sw(1) <= '0';
		wait for 200 ns;
		
		assert false report "Test: OK" severity failure;
		--wait; -- this waits forever
	end process;
	
	uut : entity work.parrt_3
	port map(
		SW => sw, KEY => clk, 
		LEDR => outLEDs
		);

end tb;
		