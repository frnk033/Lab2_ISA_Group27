library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RCA is
generic(nb: integer := 64);
port(A: in std_logic_vector(nb-1 downto 0);
	  B: in std_logic_vector(nb-1 downto 0);
	  Z: out std_logic_vector(nb-1 downto 0)
	  );
end entity;

architecture str of RCA is 

signal c_v: std_logic_vector(nb-1 downto 0);

component FA is 
	Port (	A :	In	std_logic;
		      B :	In	std_logic;
		      Ci:	In	std_logic;
		      S :	Out	std_logic;
		      Co:	Out	std_logic);
end component;

begin

FA_fisrt: FA port map (a => A(0), b => B(0), ci => '0', s => Z(0), co => c_v(0));

FA_generation: for i in 1 to 63 generate 
					Full_adders: FA port map (a =>A(i), b => B(i), ci => c_v(i-1), s =>z(i)  , co => c_v(i));
					end generate;
					
end architecture;