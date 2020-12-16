library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 
use std.textio.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is  
  port (
    CLK     : in  std_logic;
    RST_n   : in  std_logic;
    FP_A, FP_B: out signed(31 downto 0);
    END_SIM : out std_logic);
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns;

  signal sEndSim : std_logic;
  signal END_SIM_i : std_logic_vector(0 to 4);  

begin  -- beh


  process (CLK, RST_n)
    file fp_in : text open READ_MODE is "fp_samples.hex";
    variable line_in : line;
    variable x : std_logic_vector(31 downto 0);
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      FP_A <= (others => '0');
      FP_B <= (others => '0');
      sEndSim <= '0' after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if not endfile(fp_in) then
        readline(fp_in, line_in);
        hread(line_in, x);
        FP_A <= signed(x) after tco;
		FP_B <= signed(x) after tco;
        sEndSim <= '0' after tco;
      else        
        sEndSim <= '1' after tco;
      end if;
    end if;
  end process;


process (CLK, RST_n)
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      END_SIM_i(0) <= sEndSim after tco;
      END_SIM_i(1 to 4) <= END_SIM_i(0 to 3) after tco;
    end if;
  end process;

  END_SIM <= END_SIM_i(4);  

end beh;
