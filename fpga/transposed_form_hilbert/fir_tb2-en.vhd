-- --------------------------------------------------------------------
--   $Id$ 
--   $Log$
--   Dateiname   : fir_tb2-en.vhd
--   Titel       : Entity fir_tb2
--   Ersteller   : dmpa
--   Projekt     : digitalmpa
--   Datum       : 13/12/19 15:37:45
--   Bemerkungen :
--               : $Log$
-- --------------------------------------------------------------------
library ieee ;
use     ieee.std_logic_1164.all ;
--use ieee.numeric_std.all ;

-- synopsys translate_off
use     std.textio.all;
-- synopsys translate_on

entity fir_tb2 is

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

end fir_tb2;
