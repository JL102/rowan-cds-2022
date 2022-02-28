library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
	
entity Part2_testbench is -- A testbench usually has no ports
end Part2_testbench;

architecture tb of Part2_testbench is
	signal clk : std_logic_vector(3 downto 0) := "0000";
	signal sw : std_logic_vector(9 downto 0);-- := (others => '0');
	signal outLEDs : std_logic_vector(9 downto 0); --:= (others => '0');
	signal W, Reset : std_logic;
	-- One signal per port is typical
begin
	clk(0) <= not clk(0) after 10 ns;
	sw(1) <= W; 	-- Switch 1: Input (second to last one)
	sw(0) <= Reset; -- Switch 0: Reset (last one)
	-- Apply stimulus and check the results
	process
	begin
		Reset <= '1';
		W     <= '0';
		wait for 100 ns;
		Reset <= '0';
		W		<= '1';
		wait for 100 ns;
		W		<= '0';
		wait for 33.3 ns;
		W		<= '1';
		wait for 33.3 ns;
		W		<= '0';
		wait for 33.3 ns;
		W 		<= '1';
		wait for 100 ns;
		W     <= '1';
		Reset	<= '1';
		wait for 100 ns;
		W     <= '0';
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
