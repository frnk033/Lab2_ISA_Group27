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
port(a:     in std_logic; 
     b:     in std_logic;
	  c_in:  in std_logic;
	  c_out: out std_logic;
	  s:     out std_logic
	  );
end component;

begin

FA_fisrt: FA port map (a => A(0), b => B(0), c_in => '0', c_out => c_v(0), s => Z(0));

FA_generation: for i in 1 to 63 generate 
					Full_adders: FA port map (a =>A(i), b => B(i), c_in => c_v(i-1), c_out => c_v(i), s =>z(i) );
					end generate;
					
end architecture;