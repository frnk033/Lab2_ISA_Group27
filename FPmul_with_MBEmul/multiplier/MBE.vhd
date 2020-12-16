library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MBE is 
generic(	nb : integer := 32);
port ( A: in std_logic_vector(nb-1 downto 0);
		 B: in std_logic_vector(nb-1 downto 0);
		 P: out std_logic_vector(nb*2 - 1 downto 0)
     );
end entity; 

architecture str of MBE is 

-- signal
signal P1_i, P2_i, P3_i, P4_i, P5_i, P6_i, P7_i, P8_i, 
		 P9_i, P10_i, P11_i, P12_i, P13_i, P14_i        : std_logic_vector(36 downto 0);
signal P0_i, P15_i : std_logic_vector(35 downto 0);
signal P16_i : std_logic_vector(33 downto 0);
signal op1_i, op2_i: std_logic_vector(63 downto 0);
signal ov_i: std_logic;

-- components
component part_prod_gen is 
generic(
		nb : integer := 32
		);
port (A :  in std_logic_vector(nb-1 downto 0);
		B :  in std_logic_vector(nb-1 downto 0);
		P0:  out std_logic_vector(nb + 3 downto 0);
		P1:  out std_logic_vector(nb + 4 downto 0);
		P2:  out std_logic_vector(nb + 4 downto 0);
		P3:  out std_logic_vector(nb + 4 downto 0);
		P4:  out std_logic_vector(nb + 4 downto 0);
		P5:  out std_logic_vector(nb + 4 downto 0);
		P6:  out std_logic_vector(nb + 4 downto 0);
		P7:  out std_logic_vector(nb + 4 downto 0);
		P8:  out std_logic_vector(nb + 4 downto 0);
		P9:  out std_logic_vector(nb + 4 downto 0);
		P10: out std_logic_vector(nb + 4 downto 0);
		P11: out std_logic_vector(nb + 4 downto 0);
		P12: out std_logic_vector(nb + 4 downto 0);
		P13: out std_logic_vector(nb + 4 downto 0);
		P14: out std_logic_vector(nb + 4 downto 0);
		P15: out std_logic_vector(nb + 3 downto 0);
		P16: out std_logic_vector(nb + 1 downto 0)		
		);
end component;

component Dadda is 
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
	  OP2 : OUT   std_logic_vector (63 DOWNTO 0);
	  OV	 :	OUT	std_logic -- needed???
   );
end component;

component RCA is
generic(nb: integer := 64);
port(A: in std_logic_vector(nb-1 downto 0);
	  B: in std_logic_vector(nb-1 downto 0);
	  Z: out std_logic_vector(nb-1 downto 0)
	  );
end component; 

begin

PP_generator: part_prod_gen port map (A => A, B => B, 
																  P0 => P0_i, P1 => P1_i, P2 => P2_i, P3 => P3_i, 
																  P4 => P4_i, P5 => P5_i, P6 => P6_i, P7 => P7_i, 
																  P8 => P8_i, P9 => P9_i, P10 => P10_i, P11 => P11_i,
																  P12 => P12_i, P13 => P13_i, P14 => P14_i, P15 => P15_i, P16 => P16_i);  

Dadda_computation: Dadda port map (P0 => P0_i, P1 => P1_i, P2 => P2_i, P3 => P3_i, 
											  P4 => P4_i, P5 => P5_i, P6 => P6_i, P7 => P7_i, 
											  P8 => P8_i, P9 => P9_i, P10 => P10_i, P11 => P11_i,
											  P12 => P12_i, P13 => P13_i, P14 => P14_i, P15 => P15_i, P16 => P16_i, 
											  op1 => op1_i, op2 => op2_i, ov => ov_i);  

RCA_addition: RCA port map (A => op1_i, B => op2_i, Z => P);

end architecture; 