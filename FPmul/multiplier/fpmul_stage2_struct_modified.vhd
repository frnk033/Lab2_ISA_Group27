-- VHDL Entity HAVOC.FPmul_stage2.interface
--
-- Created by
-- Guillermo Marcus, gmarcus@ieee.org
-- using Mentor Graphics FPGA Advantage tools.
--
-- Visit "http://fpga.mty.itesm.mx" for more info.
--
-- 2003-2004. V1.0
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY FPmul_stage2 IS
   PORT( 
      A_EXP           : IN     std_logic_vector (7 DOWNTO 0);
      A_SIG           : IN     std_logic_vector (31 DOWNTO 0);
      B_EXP           : IN     std_logic_vector (7 DOWNTO 0);
      B_SIG           : IN     std_logic_vector (31 DOWNTO 0);
      SIGN_out_stage1 : IN     std_logic;
      clk             : IN     std_logic;
      isINF_stage1    : IN     std_logic;
      isNaN_stage1    : IN     std_logic;
      isZ_tab_stage1  : IN     std_logic;
      EXP_in          : OUT    std_logic_vector (7 DOWNTO 0);
      EXP_neg_stage2  : OUT    std_logic;
      EXP_pos_stage2  : OUT    std_logic;
      SIGN_out_stage2 : OUT    std_logic;
      SIG_in          : OUT    std_logic_vector (27 DOWNTO 0);
      isINF_stage2    : OUT    std_logic;
      isNaN_stage2    : OUT    std_logic;
      isZ_tab_stage2  : OUT    std_logic
   );

-- Declarations

END FPmul_stage2 ;

--
-- VHDL Architecture HAVOC.FPmul_stage2.struct
--
-- Created by
-- Guillermo Marcus, gmarcus@ieee.org
-- using Mentor Graphics FPGA Advantage tools.
--
-- Visit "http://fpga.mty.itesm.mx" for more info.
--
-- Copyright 2003-2004. V1.0
--


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ARCHITECTURE struct OF FPmul_stage2 IS

   -- Architecture declarations

    component FF is 
	port(
		clk  		: in std_logic; 
		Din  		: in std_logic;
		Dout 		: out std_logic
		);
    end component;

    component reg is 
	 generic(
		data_size 	: integer := 8
		);
	 port(
		clk  		: in std_logic;
		Din  		: in std_logic_vector(data_size-1 downto 0);
		Dout 		: out std_logic_vector(data_size-1 downto 0) 
		);
   end component;
   -- Internal signal declarations
   SIGNAL EXP_in_int  : std_logic_vector(7 DOWNTO 0);
   SIGNAL EXP_neg_int : std_logic;
   SIGNAL EXP_pos_int : std_logic;
   SIGNAL SIG_in_int  : std_logic_vector(27 DOWNTO 0);
   SIGNAL dout        : std_logic;
   SIGNAL dout1       : std_logic_vector(7 DOWNTO 0);
   SIGNAL prod        : std_logic_vector(63 DOWNTO 0);

   SIGNAL EXP_in_int_next : std_logic_vector(7 DOWNTO 0);
   SIGNAL EXP_neg_int_next : std_logic;
   SIGNAL EXP_pos_int_next : std_logic;
   SIGNAL prod_next       : std_logic_vector(63 DOWNTO 0);
   SIGNAL SIGN_out_stage1_next : std_logic;
   SIGNAL isINF_stage1_next    : std_logic;
   SIGNAL isNaN_stage1_next   : std_logic;
   SIGNAL isZ_tab_stage1_next  : std_logic;


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 sig
   -- eb1 1
   SIG_in_int <= prod_next(47 DOWNTO 20);

   -- HDL Embedded Text Block 2 inv
   -- eb5 5
   EXP_in_int <= (NOT dout1(7)) & dout1(6 DOWNTO 0);

   -- HDL Embedded Text Block 3 latch
   -- eb2 2

  --Synchronization register & FFs

 reg0: reg generic map (data_size => 8) port map (clk => clk, Din => EXP_in_int, Dout => EXP_in_int_next); 
 ff0: FF port map (clk => clk, Din => EXP_neg_int, Dout => EXP_neg_int_next); 
 ff1: FF port map (clk => clk, Din => EXP_pos_int, Dout => EXP_pos_int_next); 
 ff2: FF port map (clk => clk, Din => SIGN_out_stage1, Dout => SIGN_out_stage1_next ); 
 ff3: FF port map (clk => clk, Din => isINF_stage1, Dout => isINF_stage1_next); 
 ff4: FF port map (clk => clk, Din => isNaN_stage1, Dout => isNaN_stage1_next); 
 ff5: FF port map (clk => clk, Din => isZ_tab_stage1, Dout => isZ_tab_stage1_next); 

   
   PROCESS(clk)
   BEGIN
      IF RISING_EDGE(clk) THEN
         EXP_in <= EXP_in_int_next;
         SIG_in <= SIG_in_int;
         EXP_pos_stage2 <= EXP_pos_int_next;
         EXP_neg_stage2 <= EXP_neg_int_next;
      END IF;
   END PROCESS;

   -- HDL Embedded Text Block 4 latch2
   -- latch2 4
   PROCESS(clk)
   BEGIN
      IF RISING_EDGE(clk) THEN
         isINF_stage2 <= isINF_stage1_next;
         isNaN_stage2 <= isNaN_stage1_next;
         isZ_tab_stage2 <= isZ_tab_stage1_next;
         SIGN_out_stage2 <= SIGN_out_stage1_next;
      END IF;
   END PROCESS;

   -- HDL Embedded Text Block 5 eb1
   -- exp_pos 5
   EXP_pos_int <= A_EXP(7) AND B_EXP(7);
--   EXP_neg_int <= NOT(A_EXP(7) OR B_EXP(7));
   EXP_neg_int <= '1' WHEN ( (A_EXP(7)='0' AND NOT (A_EXP=X"7F")) AND (B_EXP(7)='0' AND NOT (B_EXP=X"7F")) ) ELSE '0';


   -- ModuleWare code(v1.1) for instance 'I4' of 'add'
   I4combo: PROCESS (A_EXP, B_EXP, dout)
   VARIABLE mw_I4t0 : std_logic_vector(8 DOWNTO 0);
   VARIABLE mw_I4t1 : std_logic_vector(8 DOWNTO 0);
   VARIABLE mw_I4sum : unsigned(8 DOWNTO 0);
   VARIABLE mw_I4carry : std_logic;
   BEGIN
      mw_I4t0 := '0' & A_EXP;
      mw_I4t1 := '0' & B_EXP;
      mw_I4carry := dout;
      mw_I4sum := unsigned(mw_I4t0) + unsigned(mw_I4t1) + mw_I4carry;
      dout1 <= conv_std_logic_vector(mw_I4sum(7 DOWNTO 0),8);
   END PROCESS I4combo;

   -- ModuleWare code(v1.1) for instance 'I2' of 'mult'
   I2combo : PROCESS (A_SIG, B_SIG)
   VARIABLE dtemp : unsigned(63 DOWNTO 0);
   BEGIN
      dtemp := (unsigned(A_SIG) * unsigned(B_SIG));
      prod <= std_logic_vector(dtemp);
   END PROCESS I2combo;

   reg1: reg generic map (data_size => 64)  port map (clk => clk, Din => prod , Dout => prod_next); 


   -- ModuleWare code(v1.1) for instance 'I6' of 'vdd'
   dout <= '1';

   -- Instance port mappings.

END struct;
