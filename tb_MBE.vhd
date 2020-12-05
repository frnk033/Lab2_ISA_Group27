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

A_i <= std_logic_vector(to_unsigned(1, A_i'length)), std_logic_vector(to_unsigned(3353, A_i'length)) after 5 ns, std_logic_vector(to_unsigned(2147483647, A_i'length)) after 10 ns, "11111111111111111111111111111111" after 25 ns, "11111111111111111111111111111111" after 30 ns, std_logic_vector(to_unsigned(2147483647, A_i'length)) after 35 ns, std_logic_vector(to_unsigned(2, A_i'length)) after 40 ns, "10000000000000000000000000000000" after 45 ns, "01000000000000000000000000000000" after 50 ns;
B_i <= std_logic_vector(to_unsigned(13, B_i'length)), "11111111111111111111111111111111" after 25 ns, std_logic_vector(to_unsigned(1, B_i'length)) after 30 ns, std_logic_vector(to_unsigned(255, B_i'length)) after 35 ns, "11111111111111111111111111111111" after 40 ns,  std_logic_vector(to_unsigned(2, A_i'length)) after 45 ns;
UUT: MBE port map (A => A_i, B => B_i, P=> P_i);

end architecture;