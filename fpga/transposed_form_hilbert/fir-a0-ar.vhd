-- --------------------------------------------------------------------
--   $Id$ 
--   $Log$
--   Dateiname   : fir-a0-ar.vhd
--   Titel       : Architecture a0 of fir
--   Ersteller   : dmpa
--   Projekt     : digitalmpa
--   Datum       : 27/11/19 13:14:03
--   Bemerkungen :
--               : $Log$
-- --------------------------------------------------------------------
--library dmpa_rtl;
--use dmpa_rtl.fixed_pkg.all;

architecture a0 of fir is
  constant VERSION_AR : string := "$Header$";
  
  type t_coeffs 		is array (natural range<>) of Sfixed (0 downto -bitwidth+1);
  type t_taps 		    is array (natural range<>) of Sfixed (order downto -2*bitwidth+2);
--- new 
 type t_mult 		is array (natural range<>) of Sfixed (order downto -2*bitwidth+2);


  signal coeffs              : t_coeffs(0 to order);
  signal mult2              : t_mult(0 to order-2);

  signal taps                : t_taps(0 to order-1); -- one less then coeffs
  signal xin :  Sfixed(0 downto -bitwidth+1);
--  signal yout : Sfixed(order downto -2*bitwidth+1);
  signal yout : Sfixed(order downto -2*bitwidth+2);
  -- new
  signal mult1 : Sfixed(order downto -2*bitwidth+2);

begin


 	p_input : process (rst,clk)

	begin
	
	
	
	  if(rst=RESET_ACTIVE) then
		xin       <= (others=>'0');
		coeffs      <= (others=>(others=>'0'));
		taps       <= (others=>(others=>'0'));
		yout      <= (others=>'0');
		o_data  <= (others=>'0');
        
		-- new
		mult1  <= (others=>'0');
		mult2  <= (others=>(others=>'0'));


	  elsif (rising_edge(clk)) then
	  	xin <= Sfixed(i_data) after PD;

	  	for k in 0 to order loop
			coeffs(k)  <= Sfixed(coeffs_bus(k)) after PD;
		end loop;
		
		--- new mult1 <= resize(coeffs(0) * xin, order, -2*bitwidth+2);
		--  very old yout <=  resize(coeffs(0) * xin + taps(0), order, -2*bitwidth+1)  after PD;
		-- old 
		yout <=  resize(resize(coeffs(0) * xin, order, -2*bitwidth+2) + taps(0), order, -2*bitwidth+2); -- + resize(taps(0), order, -2*bitwidth+2)  after PD;
		-- new yout <=  resize(mult1 + taps(0), order, -2*bitwidth+2); -- + resize(taps(0), order, -2*bitwidth+2)  after PD;


		for k in 0 to order - 2 loop
		--new - pipelining
			--mult2(k) <= resize(coeffs(k+1) * xin, order, -2*bitwidth+2);
			-- very old taps(k) <= resize(coeffs(k+1) * xin + taps(k+1), order, -2*bitwidth+1) after PD;
			-- old 
			taps(k) <=  resize(resize(coeffs(k+1) * xin, order, -2*bitwidth+2)  + taps(k+1), order, -2*bitwidth+2) after PD;
			-- new
			--taps(k) <=  resize(mult2(k)  + taps(k+1), order, -2*bitwidth+2) after PD;

		end loop;
		
		
		--taps(order-1) <= resize(coeffs(order)*xin , order, -2*bitwidth+1) after PD;
		taps(order-1) <= resize(coeffs(order)*xin , order, -2*bitwidth+2) after PD;

		o_data <= to_sulv(yout(0 downto -bitwidth+1));
      end if;


 end process p_input;






 -- synopsys translate_off
  p_config_aus_a0: process
    variable zeile  : line;
    file configfile : text open write_mode is "config.aus";
    variable ready  : boolean := false;
  begin
    if not ready then
      write (zeile,string'("ARCHITECTURE is: "));
      write (zeile, VERSION_AR);
      writeline(configfile,zeile);
      ready := true;
    else
      wait; -- forever
    end if;
  end process;
  -- synopsys translate_on

end a0;
