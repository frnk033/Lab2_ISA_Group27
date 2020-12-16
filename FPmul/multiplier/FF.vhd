library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FF is 
	port(
		clk  		: in std_logic; 
		Din  		: in std_logic;
		Dout 		: out std_logic
		);
end FF;

architecture beh of FF is 
begin

FF_P: process (Clk)
begin  -- process IR_P
	if Clk'event and Clk = '1' then  -- rising clock edge
			Dout <= Din  ;
	end if;
end process FF_P;

end architecture; 
