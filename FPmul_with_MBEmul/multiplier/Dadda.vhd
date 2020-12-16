library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

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
	  OP2 : OUT   std_logic_vector (63 DOWNTO 0);
	  OV	 :	OUT	std_logic -- needed???
   );
end entity;

architecture beh of dadda is


  component HA
	Port ( A :	In	std_logic;
		    B :	In	std_logic;		
		    S :	Out	std_logic;
		    Co:	Out	std_logic);
  end component; 

  component FA
	Port (	A :	In	std_logic;
		      B :	In	std_logic;
		      Ci:	In	std_logic;
		      S :	Out	std_logic;
		      Co:	Out	std_logic);
  end component; 


type level_0 is array (16 downto 0)	of std_logic_vector(63 downto 0);
signal L0: level_0;
type level_1 is array (12 downto 0) of std_logic_vector(63 downto 0);
signal L1: level_1;
type level_2 is array (8 downto 0) of std_logic_vector(63 downto 0);
signal L2: level_2;
type level_3 is array (5 downto 0) of std_logic_vector (63 downto 0);
signal L3: level_3;
type level_4 is array (3 downto 0) of std_logic_vector(63 downto 0);
signal L4: level_4;
type level_5 is array (2 downto 0) of std_logic_vector(63 downto 0);
signal L5: level_5;

	
begin

-- bit layout
-- disposition is not important provided that the column remain the same
-- bits are reduced vertically
-- MSBs of lower PPs are mirrored in a triangular shape for conceptual ease
---------------------------------------------------------------------
-- level 0
L0(0)(63 downto 0)	<= P16(33 downto  6)&P0(35 downto 0);
L0(1)(63 downto 0)	<= P15(35 downto  9)&P1(36 downto 0);
L0(2)(62 downto 2)	<= P14(36 downto 13)&P2;
L0(3)(60 downto 4)	<= P13(36 downto 17)&P3;
L0(4)(58 downto 6)	<= P12(36 downto 21)&P4;
L0(5)(56 downto 8)	<= P11(36 downto 25)&P5;
L0(6)(54 downto 10)	<= P10(36 downto 29)&P6;
L0(7)(52 downto 12)	<= P9 (36 downto 33)&P7;
L0(8)(50 downto 14)	<= P8;
L0(9)(48 downto 16)	<= P9(32 downto 0);
L0(10)(46 downto 18)	<= P10(28 downto 0);
L0(11)(44 downto 20)	<= P11(24 downto 0);
L0(12)(42 downto 22)	<= P12(20 downto 0);
L0(13)(40 downto 24)	<= P13(16 downto 0);
L0(14)(38 downto 26)	<= P14(12 downto 0);
L0(15)(36 downto 28)	<= P15(8 downto 0);
L0(16)(35 downto 30)	<= P16(5 downto 0);	
		
ha01r: HA port map (L0(0)(24), L0(1)(24), L1(0)(24), L1(1)(25));
ha01l: HA port map (L0(0)(42), L0(1)(42), L1(0)(42), L1(12)(43));

ha02r: HA port map (L0(3)(26), L0(4)(26), L1(2)(26), L1(3)(27));
ha02l: HA port map (L0(3)(40), L0(4)(40), L1(2)(40), L1(2)(41));

ha03r: HA port map (L0(6)(28), L0(7)(28), L1(4)(28), L1(5)(29));
ha03l: HA port map (L0(6)(38), L0(7)(38), L1(4)(38), L1(4)(39));

ha04r: HA port map (L0(9)(30), L0(10)(30), L1(6)(30), L1(7)(31));
ha04l: HA port map (L0(9)(36), L0(10)(36), L1(6)(36), L1(6)(37));

fa01: for i in 25 to 41 generate
	FA_01:	FA port map (L0(0)(i), L0(1)(i), L0(2)(i), L1(0)(i), L1(1)(i+1));
		end generate;

fa02: for i in 27 to 39 generate
	FA_02:	FA port map (L0(3)(i), L0(4)(i), L0(5)(i), L1(2)(i), L1(3)(i+1));
		end generate;

fa03: for i in 29 to 37 generate
	FA_03:	FA port map (L0(6)(i), L0(7)(i), L0(8)(i), L1(4)(i), L1(5)(i+1));
		end generate;

fa04: for i in 31 to 35 generate
	FA_04:	FA port map (L0(9)(i), L0(10)(i), L0(11)(i), L1(6)(i), L1(7)(i+1));
		end generate;
		
-- completing scheme
L1(0)(63 downto 43) <= L0(0)(63 downto 43);
L1(0)(23 downto 0) <= L0(0)(23 downto 0);

L1(1)(63 downto 43) <= L0(1)(63 downto 43);
L1(1)(24 downto 0) <= L0(13)(24) & L0(1)(23 downto 0);

L1(2)(62 downto 42) <= L0(2)(62 downto 42);
L1(2)(25 downto 2) <= L0(13)(25) & L0(2)(24 downto 2);

L1(3)(60 downto 41) <= L0(3)(60 downto 41);
L1(3)(26 downto 4) <= L0(13)(26) & L0(3)(25 downto 4);

L1(4)(58 downto 40) <= L0(4)(58 downto 41) & L0(13)(40);
L1(4)(27 downto 6) <= L0(14)(27 downto 26) & L0(4)(25 downto 6);

L1(5)(56 downto 39) <= L0(5)(56 downto 40) & L0(13)(39);
L1(5)(28 downto 8) <= L0(13)(28 downto 27) & L0(5)(26 downto 8);

L1(6)(54 downto 38) <= L0(6)(54 downto 39) & L0(13)(38);
L1(6)(29 downto 10) <= L0(14)(29 downto 28) & L0(6)(27 downto 10);

L1(7)(52 downto 37) <= L0(7)(52 downto 39) & L0(14)(38 downto 37);
L1(7)(30 downto 12) <= L0(15)(30 downto 28) & L0(7)(27 downto 12);

L1(8)(50 downto 14) <= L0(8)(50 downto 38) & L0(13)(37 downto 29) & L0(8)(28 downto 14);

L1(9)(48 downto 16) <= L0(9)(48 downto 37)& L0(14)(36 downto 30) & L0(9)(29 downto 16);

L1(10)(46 downto 18) <= L0(10)(46 downto 37) & L0(15)(36 downto 31) & L0(16)(30) & L0(10)(29 downto 18);

L1(11)(44 downto 20) <= L0(11)(44 downto 36) & L0(16)(35 downto 31) & L0(11)(30 downto 20);

L1(12)(42 downto 22) <= L0(12)(42 downto 22);

--------------------------------------------------------
-- second level

ha11r: HA port map (L1(0)(16), L1(1)(16), L2(0)(16), L2(1)(17));
ha11l: HA port map (L1(0)(50), L1(1)(50), L2(0)(50), L2(8)(51));

ha12r: HA port map (L1(3)(18), L1(4)(18), L2(2)(18), L2(3)(19));
ha12l: HA port map (L1(3)(48), L1(4)(48), L2(2)(48), L2(2)(49));

ha13r: HA port map (L1(6)(20), L1(7)(20), L2(4)(20), L2(5)(21));
ha13l: HA port map (L1(6)(46), L1(7)(46), L2(4)(46), L2(4)(47));

ha14r: HA port map (L1(9)(22), L1(10)(22), L2(6)(22), L2(7)(23));
ha14l: HA port map (L1(9)(44), L1(10)(44), L2(6)(44), L2(6)(45));

fa11: for i in 17 to 49 generate
	FA_11:	FA port map (L1(0)(i), L1(1)(i), L1(2)(i), L2(0)(i), L2(1)(i+1));
		end generate;

fa12: for i in 19 to 47 generate
	FA_12:	FA port map (L1(3)(i), L1(4)(i), L1(5)(i), L2(2)(i), L2(3)(i+1));
		end generate;

fa13: for i in 21 to 45 generate
	FA_13:	FA port map (L1(6)(i), L1(7)(i), L1(8)(i), L2(4)(i), L2(5)(i+1));
		end generate;	

fa14: for i in 23 to 43 generate
	FA_14:	FA port map (L1(9)(i), L1(10)(i), L1(11)(i), L2(6)(i), L2(7)(i+1));
		end generate;	
	
-- completing scheme
L2(0)(63 downto 51) <= L1(0)(63 downto 51);
L2(0)(15 downto 0) <= L1(0)(15 downto 0);

L2(1)(63 downto 51) <= L1(1)(63 downto 51);
L2(1)(16 downto 0) <= L1(9)(16) & L1(1)(15 downto 0);

L2(2)(62 downto 50) <= L1(2)(62 downto 50);
L2(2)(17 downto 2) <= L1(9)(17) & L1(2)(16 downto 2);

L2(3)(60 downto 49) <= L1(3)(60 downto 49);
L2(3)(18 downto 4) <= L1(9)(18) & L1(3)(17 downto 4);

L2(4)(58 downto 48) <= L1(4)(58 downto 49) & L1(9)(48);
L2(4)(19 downto 6) <= L1(10)(19 downto 18) & L1(4)(17 downto 6);

L2(5)(56 downto 47) <= L1(5)(56 downto 48) & L1(9)(47);
L2(5)(20 downto 8) <= L1(9)(20 downto 19) & L1(5)(18 downto 8);

L2(6)(54 downto 46) <= L1(6)(54 downto 47) & L1(9)(46);
L2(6)(21 downto 10) <= L1(10)(21 downto 20) & L1(6)(19 downto 10);

L2(7)(52 downto 45) <= L1(7)(52 downto 47) & L1(10)(46 downto 45);
L2(7)(22 downto 12) <= L1(11)(22 downto 20) & L1(7)(19 downto 12);

L2(8)(50 downto 14) <= 	L1(8)(50 downto 46) & L1(9)(45) & L1(11)(44) &
								L1(12)(43 downto 22) & L1(9)(21) & L1(8)(20 downto 14);

								
------------------------------------------------------------------------------
-- third level

ha21r: HA port map (L2(0)(10), L2(1)(10), L3(0)(10), L3(1)(11));
ha21l: HA port map (L2(0)(56), L2(1)(56), L3(0)(56), L3(5)(57));

ha22r: HA port map (L2(3)(12), L2(4)(12), L3(2)(12), L3(3)(13));
ha22l: HA port map (L2(3)(54), L2(4)(54), L3(2)(54), L3(2)(55));

ha23r: HA port map (L2(6)(14), L2(7)(14), L3(4)(14), L3(5)(15));
ha23l: HA port map (L2(6)(52), L2(7)(52), L3(4)(52), L3(4)(53));

fa21: for i in 11 to 55 generate
	FA_21:	FA port map (L2(0)(i), L2(1)(i), L2(2)(i), L3(0)(i), L3(1)(i+1));
		end generate;

fa22: for i in 13 to 53 generate
	FA_22:	FA port map (L2(3)(i), L2(4)(i), L2(5)(i), L3(2)(i), L3(3)(i+1));
		end generate;

fa23: for i in 15 to 51 generate
	FA_23:	FA port map (L2(6)(i), L2(7)(i), L2(8)(i), L3(4)(i), L3(5)(i+1));
		end generate;

-- completing scheme
L3(0)(63 downto 57) <= L2(0)(63 downto 57);
L3(0)(9 downto 0) <= L2(0)(9 downto 0);

L3(1)(63 downto 57) <= L2(1)(63 downto 57);
L3(1)(10 downto 0) <= L2(6)(10) & L2(1)(9 downto 0);

L3(2)(62 downto 56) <= L2(2)(62 downto 56);
L3(2)(11 downto 2) <= L2(6)(11) & L2(2)(10 downto 2);

L3(3)(60 downto 55) <= L2(3)(60 downto 55);
L3(3)(12 downto 4) <= L2(6)(12) & L2(3)(11 downto 4);

L3(4)(58 downto 54) <= L2(4)(58 downto 55) & L2(6)(54);
L3(4)(13 downto 6) <= L2(7)(13 downto 12) & L2(4)(11 downto 6);

L3(5)(56 downto 53) <= L2(5)(56 downto 54) & L2(6)(53);
L3(5)(14 downto 8) <= L2(8)(14) & L2(6)(13) & L2(5)(12 downto 8);


------------------------------------------------------------------------------
-- fourth level

ha31r: HA port map (L3(0)(6), L3(1)(6), L4(0)(6), L4(1)(7));
ha31l: HA port map (L3(0)(60), L3(1)(60), L4(0)(60), L4(3)(61));

ha32r: HA port map (L3(3)(8), L3(4)(8), L4(2)(8), L4(3)(9));
ha32l: HA port map (L3(3)(58), L3(4)(58), L4(2)(58), L4(2)(59));

fa31: for i in 7 to 59 generate
	FA_31:	FA port map (L3(0)(i), L3(1)(i), L3(2)(i), L4(0)(i), L4(1)(i+1));
		end generate;

fa32: for i in 9 to 57 generate
	FA_32:	FA port map (L3(3)(i), L3(4)(i), L3(5)(i), L4(2)(i), L4(3)(i+1));
		end generate;

-- completing scheme
L4(0)(63 downto 61) <= L3(0)(63 downto 61);
L4(0)(5 downto 0) <= L3(0)(5 downto 0);

L4(1)(63 downto 61) <= L3(1)(63 downto 61);
L4(1)(6 downto 0) <= L3(4)(6) & L3(1)(5 downto 0);

L4(2)(62 downto 60) <= L3(2)(62 downto 60);
L4(2)(7 downto 2) <= L3(4)(7) & L3(2)(6 downto 2);

L4(3)(60 downto 59) <= L3(3)(60 downto 59);
L4(3)(8 downto 4) <= L3(5)(8) & L3(3)(7 downto 4);


------------------------------------------------------------------------------
-- fifth level

ha41r: HA port map (L4(0)(4), L4(1)(4), L5(0)(4), L5(1)(5));
ha41l: HA port map (L4(0)(62), L4(1)(62), L5(0)(62), L5(2)(63));

fa41: for i in 5 to 61 generate
	FA_41:	FA port map (L4(0)(i), L4(1)(i), L4(2)(i), L5(0)(i), L5(1)(i+1));
		end generate;

-- completing scheme
L5(0)(63) <= L4(0)(63);
L5(0)(3 downto 0) <= L4(0)(3 downto 0);

L5(1)(63) <= L4(1)(63);
L5(1)(4 downto 0) <= L4(3)(4) & L4(1)(3 downto 0);

L5(2)(62 downto 2) <= L4(2)(62) & L4(3)(61 downto 5) & L4(2)(4 downto 2);


------------------------------------------------------------------------------
-- sixth level - FINAL ONE - direct assignment to outputs

ha51r: HA port map (L5(0)(2), L5(1)(2), OP1(2), OP2(3));

fa51: for i in 3 to 62 generate
	FA_51:	FA port map (L5(0)(i), L5(1)(i), L5(2)(i), OP1(i), OP2(i+1));
		end generate;

-- overflow: NEEDED???
FA_OF:	FA port map (L5(0)(63), L5(1)(63), L5(2)(63), OP1(63), OV);

-- completing scheme
OP1(1 downto 0) <= L5(0)(1 downto 0);
OP2(2 downto 0) <= L5(2)(2) & L5(1)(1 downto 0);

			
end beh;
