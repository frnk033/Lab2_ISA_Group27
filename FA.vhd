library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FA is
port(a:     in std_logic; 
     b:     in std_logic;
	  c_in:  in std_logic;
	  c_out: out std_logic;
	  s:     out std_logic
	  );
end entity; 

architecture str of FA is 
begin 
 s <= a XOR b XOR c_in;
 c_out <= (a AND b) XOR (a AND c_in) XOR (b AND c_in);
end architecture;