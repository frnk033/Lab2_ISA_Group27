library ieee;
use ieee.std_logic_1164.all;

entity  mux3to1 is 
	Generic(N: integer:= 33);
	Port(	A:	In	std_logic_vector(N-1 downto 0) ;
			B:	In	std_logic_vector(N-1 downto 0);
			C: In std_logic_vector(N-1 downto 0);
			S:	In	std_logic_vector(2 downto 0);
			Y:	Out	std_logic_vector(N-1 downto 0));
end entity;

architecture BEHAVIORAL of mux3to1 is
begin
	Y <= A when S = "001" else 
	     B when S = "010" else
		  C; 
end BEHAVIORAL;