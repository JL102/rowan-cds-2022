library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tlc_tb is -- A testbench usually has no ports
end tlc_tb;

architecture tb of tlc_tb is
	signal clk : std_logic := '0'; -- Must initialize!
	-- One signal per port is typical
	signal reset, cars, short, long : std_logic;
	signal farm_red, start_timer : std_logic;
begin
	clk <= not clk after 34.92 ns; -- 14 MHz
	-- Apply stimulus and check the results
	process
		begin
		cars <= '0'; short <= '0'; long <= '0'; reset <= '1';
		wait for 100 ns;
		assert start_timer = '1' report "No timer" severity error;
		reset <= '0';
		wait for 100 ns;
		assert farm_red = '1' report "Farm not red" severity error;
		wait;
	end process;
	-- Instantiate the Unit Under Test
	uut : entity work.tlc
	port map(
		clk => clk, reset => reset,
		cars => cars, short => short,
		long => long, farm_red => farm_red,
		start_timer => start_timer
	);
end tb;
