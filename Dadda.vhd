library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dadda is 
PORT(P0  : IN    std_logic_vector (35 DOWNTO 0);
	  P1  : IN    std_logic_vector (36 DOWNTO 0);
	  P2  : IN    std_logic_vector (36 DOWNTO 0);
     P3  : IN    std_logic_vector (36 DOWNTO 0);
	  P4  : IN    std_logic_vector (36 DOWNTO 0);
	  P5  : IN    std_logic_vector (36 DOWNTO 0);
     P6  : IN    std_logic_vector (36 DOWNTO 0);
	  P7  : IN    std_logic_vector (36 DOWNTO 0);
	  P8  : IN    std_logic_vector (36 DOWNTO 0);
     P9  : IN    std_logic_vector (36 DOWNTO 0);
	  P10 : IN    std_logic_vector (36 DOWNTO 0);
	  P11 : IN    std_logic_vector (36 DOWNTO 0);
     P12 : IN    std_logic_vector (36 DOWNTO 0);
	  P13 : IN    std_logic_vector (36 DOWNTO 0);
	  P14 : IN    std_logic_vector (36 DOWNTO 0);
     P15 : IN    std_logic_vector (35 DOWNTO 0);
	  P16 : IN    std_logic_vector (33 DOWNTO 0);
	  OP1 : OUT   std_logic_vector (63 DOWNTO 0);
	  OP2 : OUT   std_logic_vector (63 DOWNTO 0)
   );
end entity;

architecture str of Dadda is 
begin
OP1 <= (others => '0');
OP2 <= (others => '0');
end architecture;