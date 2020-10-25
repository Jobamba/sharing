-- --------------------------------------------------------------------
--   $Id$ 
--   $Log$
--   Dateiname   : fir_tb2-a0-c0-cf.vhd
--   Titel       : Configuration fir_tb2_a0_c0 of fir_tb2 ( a0 )
--   Ersteller   : dmpa
--   Projekt     : digitalmpa
--   Datum       : 13/12/19 15:37:45
--   Bemerkungen :
--               : $Log$
-- --------------------------------------------------------------------
-- library XXX ;


LIBRARY dmpa_rtl;

configuration fir_tb2_a0_c0 of fir_tb2 is
  for a0

	for all : fir 
		use configuration dmpa_rtl.fir_a1_c0 ;
    end for ;
	
	for all : delay_line 
		use configuration dmpa_rtl.delay_line_a1_c0 ;
    end for ;

    -- Entity-Architecture Pairs Configurations
    -- for instance : component use entity work.entity(architecture) ;
    --    generic map(...) ;
    --    port map(...) ;
    -- end for ;

    -- Lower-Level Configurations
    -- for instance : component use configuration work.unit_con ;
    --    generic map(...) ;
    --    port map(...) ;
    -- end for ;

  end for ;
end fir_tb2_a0_c0;
