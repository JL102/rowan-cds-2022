library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- fourconseq: Detects either four consecutive zeros or ones (with rollover) as a state machine

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
	signal state : std_logic_vector(8 downto 0);
begin
	process (Clk)
	begin
		if rising_edge(Clk) then
			if Reset = '1' then
				state <= "000000001";
			else
				-- Below: input/state logic
				state(1) <= not(W) and not(state(2)) and not(state(3)) and not(state(4));
				state(2) <= not(W) and state(1);
				state(3) <= not(W) and state(2);
				state(4) <= not(W) and (state(3) or state(4));
				state(5) <= W and not(state(6)) and not(state(7)) and not(state(8));
				state(6) <= W and state(5);
				state(7) <= W and state(6);
				state(8) <= W and (state(7) or state(8));
				-- Below: output logic
				Z <= state(4) or state(8);
			end if;
		end if;
	end process;
	Q <= count; -- copy count to output
end imp;