library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is 
	generic(
		data_size 	: integer := 8
		);
	port(
		clk  		: in std_logic;
		Din  		: in std_logic_vector(data_size-1 downto 0);
		Dout 		: out std_logic_vector(data_size-1 downto 0) 
		);
end reg;

architecture beh of reg is 
begin

reg_P: process (Clk)
begin  -- process IR_P
		
	if Clk'event and Clk = '1' then  -- rising clock edge
			Dout <= Din  ;--after 0.01 ns;
	end if;
end process reg_P;

end architecture; 
