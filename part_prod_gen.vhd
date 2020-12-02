library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part_prod_gen is 
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
end entity;


architecture str of part_prod_gen is 

type control_array is array (integer range 0 to 16) of std_logic_vector(2 downto 0);
signal c: control_array;

type pp_array is array (integer range 0 to 16) of std_logic_vector(nb downto 0);
signal q, p: pp_array;

signal B_new: std_logic_vector(34 downto 0);
signal s: std_logic_vector(16 downto 0);

component mux3to1 is 
	Generic(N: integer:= 33);
	Port(	A:	In	std_logic_vector(N-1 downto 0) ;
			B:	In	std_logic_vector(N-1 downto 0);
			C: In std_logic_vector(N-1 downto 0);
			S:	In	std_logic_vector(2 downto 0);
			Y:	Out	std_logic_vector(N-1 downto 0));
end component; 


begin
B_new <= "00" & B & '0';
pp_generator:for i in 0 to 16 generate 
						--combinational logic for control signal generation
						c(i)(0) <= NOT(B_new(2*i+1) XOR B_new(2*i)) AND NOT(B_new(2*i+2) XOR B_new(2*i+1));
						c(i)(1) <= B_new(2*i+1) XOR B_new(2*i);
				 		c(i)(2) <= NOT(B_new(2*i+1) XOR B_new(2*i)) AND (B_new(2*i+1) XOR B_new(2*i+1));
						--multiplexer
						muxes: mux3to1 port map (A=> (others => '0'), B=>A(nb-1)&A, C=>A & '0', S => c(i), Y => q(i) );
						--partial product generation
						pp: for j in 0 to nb generate
									p(i)(j) <= (B_new(2*i+2) XOR q(i)(j));-- OR B_new(2*i+2);
							 end generate;
						--s signal preparation for signal extension
						s(i) <= B_new(2*i+2);
				  end generate;

P0 <= NOT(s(0)) & s(0) & s(0) & p(0);
P1 <= '1' & NOT(s(1)) & p(1) & '0' & s(0);
P2 <= '1' & NOT(s(2)) & p(2) & '0' & s(1);
P3 <= '1' & NOT(s(3)) & p(3) & '0' & s(2);
P4 <= '1' & NOT(s(4)) & p(4) & '0' & s(3);
P5 <= '1' & NOT(s(5)) & p(5) & '0' & s(4);
P6 <= '1' & NOT(s(6)) & p(6) & '0' & s(5);
P7 <= '1' & NOT(s(7)) & p(7) & '0' & s(6);
P8 <= '1' & NOT(s(8)) & p(8) & '0' & s(7);
P9 <= '1' & NOT(s(9)) & p(9) & '0' & s(8);
P10 <= '1' & NOT(s(10)) & p(10) & '0' & s(9);
P11 <= '1' & NOT(s(11)) & p(11) & '0' & s(10);
P12 <= '1' & NOT(s(12)) & p(12) & '0' & s(11);
P13 <= '1' & NOT(s(13)) & p(13) & '0' & s(12);
P14 <= '1' & NOT(s(14)) & p(14) & '0' & s(13);
P15 <=  NOT(s(15)) & p(15) & '0' & s(14);
P16 <= p(16)(nb-1 downto 0) & '0' & s(15);

end architecture;