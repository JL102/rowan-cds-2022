library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
	
entity Part2_testbench is -- A testbench usually has no ports
end Part2_testbench;

architecture tb of Part2_testbench is
	signal clk : std_logic_vector(3 downto 0) := "0000";
	signal sw : std_logic_vector(9 downto 0);-- := (others => '0');
	signal outLEDs : std_logic_vector(9 downto 0); --:= (others => '0');
	-- One signal per port is typical
begin
	clk(0) <= not clk(0) after 20 ns;
	-- Apply stimulus and check the results
	process
	begin
		wait for 100 ns;
		sw(0) <= '0';
		sw(1) <= '0';
		wait for 100 ns;
		sw(0) <= '1';
		sw(1) <= '1';
		wait for 100 ns;
		sw(0) <= '1';
		sw(1) <= '0';
		wait for 100 ns;
		
		assert false report "Test: OK" severity failure;
		--wait; -- this waits forever
	end process;
	-- Instantiate the Unit Under Test
	uut : entity work.part2
	port map(
		SW => sw, KEY => clk, 
		LEDR => outLEDs
	);
end tb;
