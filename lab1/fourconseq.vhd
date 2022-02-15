library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- fourconseq: Detects either four consecutive zeros or ones (with rollover) as a x machine

-- component flipflop
-- 	port ()

COMPONENT flipflop_a --flipflop_a component is pulled from flipflop_a.vhd

        PORT ( D, Clock, Reset, Set : IN STD_LOGIC; --inputs
                 Q                          : OUT STD_LOGIC); --outputs
    END COMPONENT;

entity fourconseq is
port(
	Clk, Reset, W : in std_logic; -- W is in
	Z : out std_logic); -- Z is out
end fourconseq;

architecture imp of fourconseq is
	signal X : std_logic_vector(8 downto 0); -- previous state
	signal Y : std_logic_vector(8 downto 0); -- next state
begin
	process (Clk)
	begin
		if rising_edge(Clk) then
			if Reset = '1' then
				X <= "000000001";
			else
				-- Below: input/x logic
				Y(1) <= not(W) and not(X(2)) and not(X(3)) and not(X(4));
				x(2) <= not(W) and x(1);
				x(3) <= not(W) and x(2);
				x(4) <= not(W) and (x(3) or x(4));
				x(5) <= W and not(x(6)) and not(x(7)) and not(x(8));
				x(6) <= W and x(5);
				x(7) <= W and x(6);
				x(8) <= W and (x(7) or x(8));
				-- Below: output logic
				Z <= x(4) or x(8);
			end if;
		end if;
	end process;
	Q <= count; -- copy count to output
end imp;