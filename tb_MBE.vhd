library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_MBE is	
end entity;

architecture TEST of tb_MBE is 

signal A_i, B_i: std_logic_vector(31 downto 0);
signal P_i: std_logic_vector(63 downto 0);

component MBE is 
generic(	nb : integer := 32);
port ( A: in std_logic_vector(nb-1 downto 0);
		 B: in std_logic_vector(nb-1 downto 0);
		 P: out std_logic_vector(nb*2 - 1 downto 0)
     );
end component;

begin

A_i <= std_logic_vector(to_unsigned(1, A_i'length));
B_i <= std_logic_vector(to_unsigned(13, B_i'length));
UUT: MBE port map (A => A_i, B => B_i, P=> P_i);

end architecture;