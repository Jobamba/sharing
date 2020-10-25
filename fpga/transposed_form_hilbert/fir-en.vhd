-- --------------------------------------------------------------------
--   $Id$ 
--   $Log$
--   Dateiname   : fir-en.vhd
--   Titel       : Entity fir
--   Ersteller   : dmpa
--   Projekt     : digitalmpa
--   Datum       : 27/11/19 13:14:03
--   Bemerkungen :
--               : $Log$
-- --------------------------------------------------------------------
library ieee ;
use     ieee.std_logic_1164.all;
use     ieee.fixed_pkg.all;  -- uncomment for modelsim

library dmpa_rtl;
--use dmpa_rtl.fixed_pkg.all;
use dmpa_rtl.constants.all;
use dmpa_rtl.types.all;

  -- synopsys translate_off
--use     ieee.fixed_pkg.all;  -- uncomment for modelsim
  -- synopsys translate_on
-- create a library ieee_proposed which is empty so that the modelsim don't complain that it don't know it 
-- library ieee_proposed; 
-- use ieee_proposed.fixed_pkg.all;  -- we thougt it works with an old vhdl but the lib is not found

-- synopsys translate_off
use     std.textio.all;
-- synopsys translate_on
-- use dmpa_rtl.fixed_pkg.all;


entity fir is
generic (bitwidth : integer := 12  ; 
		order : integer := 5);
  port(
clk  : in STD_ULOGIC; -- clock 
rst  : in STD_ULOGIC; -- reset active low 
    		
--coeffs_bus : coeff_array(0 to order)(0 downto -bitwidth+1);
coeffs_bus : coeff_array(0 to order);
  -- data input
i_data       : in  std_ulogic_vector( bitwidth-1 downto 0);
  -- filtered data 
o_data       : out std_ulogic_vector( bitwidth-1 downto 0)
);
  constant VERSION_EN : string := "$Header$";

  -- synopsys translate_off
begin

  p_config_aus: process
    variable zeile  : line;
    file configfile : text open write_mode is "config.aus";
    variable ready  : boolean := false;
  begin
    if not ready then
      write (zeile,string'("ENTITY is: "));
      write (zeile, VERSION_EN);
      writeline(configfile,zeile);
      ready := true;
    else
      wait; -- forever
    end if;
  end process;
  -- synopsys translate_on

end fir;
