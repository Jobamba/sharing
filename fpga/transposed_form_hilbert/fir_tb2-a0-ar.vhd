-- --------------------------------------------------------------------
--   $Id$ 
--   $Log$
--   Dateiname   : fir_tb2-a0-ar.vhd
--   Titel       : Architecture a0 of fir_tb2
--   Ersteller   : dmpa
--   Projekt     : digitalmpa
--   Datum       : 13/12/19 15:37:45
--   Bemerkungen : This should produce two inverted signals on the outpts
--               : A sinus wave goes through 2 cascaded hilbert firs, gets 180 deg phase shift,
--                 a reference goes through a delay 2 times. 
--				   The coefficients of a quantized filter are provided. 
--					The test signal frequency must be in the bandwidth of 0.05 fs - 0.45 fs
-- --------------------------------------------------------------------
library dmpa_rtl;
use 	dmpa_rtl.constants.all;
use 	dmpa_rtl.types.all;
--library dmpa_hgl;
--use 	dmpa_hgl.tbFunctions.all;
library ieee;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.math_real.all;

--library ieee_proposed;
--use ieee_proposed.fixed_pkg.all;



architecture a0 of fir_tb2 is
  constant VERSION_AR : string := "$Header$";
  constant tb_bitwidth : integer := 12;
  constant tb_order : integer := 30;
  
  

  -- constant coeff1 : signed(11 downto 0) := to_signed(-490, 12);
  -- constant coeff2 : signed(11 downto 0) := to_signed(0, 12);
  -- constant coeff3 : signed(11 downto 0) := to_signed(-1283, 12);
  -- constant coeff4 : signed(11 downto 0) := to_signed(0, 12);
  -- constant coeff5 : signed(11 downto 0) := to_signed(1283, 12);
  -- constant coeff6 : signed(11 downto 0) := to_signed(0, 12);
  -- constant coeff7 : signed(11 downto 0) := to_signed(490, 12);
  
  -- constant coeff1 : signed(tb_bitwidth-1 downto 0) := to_signed(2**(tb_bitwidth-1)-1, tb_bitwidth);
  -- constant coeff2 : signed(tb_bitwidth-1 downto 0) := to_signed(0, tb_bitwidth);
  -- constant coeff3 : signed(tb_bitwidth-1 downto 0) := to_signed(0, tb_bitwidth);
  -- constant coeff4 : signed(tb_bitwidth-1 downto 0) := to_signed(0, tb_bitwidth); --"011";
  -- constant coeff5 : signed(tb_bitwidth-1 downto 0) := to_signed(2**(tb_bitwidth-1)-1, tb_bitwidth); --"011";
  -- constant coeff6 : signed(tb_bitwidth-1 downto 0) := to_signed(0, tb_bitwidth);
  -- constant coeff7 : signed(tb_bitwidth-1 downto 0) := to_signed(0, tb_bitwidth);
  
  -- hilbert30 coeffs
  -- CONSTANT coeff1                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(-65, tb_bitwidth); -- sfix12_En11
  -- CONSTANT coeff2                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_En11
  -- CONSTANT coeff3                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(-53, tb_bitwidth); -- sfix12_En11
  -- CONSTANT coeff4                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_En11
  -- CONSTANT coeff5                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(-76, tb_bitwidth); -- sfix12_En11
  -- CONSTANT coeff6                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff7                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(-109, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff8                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff9                         : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(-157, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff10                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff11                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(-239, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff12                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff13                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(-421, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff14                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_En11
  -- CONSTANT coeff15                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(-1299, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff16                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff17                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(1299, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff18                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff19                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(421, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff20                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff21                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(239, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff22                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff23                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(157, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff24                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff25                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(109, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff26                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff27                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(76, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff28                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff29                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(53, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff30                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(0, tb_bitwidth); -- sfix12_Entb_bitwidth-1
  -- CONSTANT coeff31                        : signed(tb_bitwidth-1 DOWNTO 0) := to_signed(65, tb_bitwidth); -- sfix12_En11
  
  
  CONSTANT coeff1                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         -9, tb_bitwidth); 
  CONSTANT coeff2                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          0, tb_bitwidth); 
  CONSTANT coeff3                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(        -19, tb_bitwidth); 
  CONSTANT coeff4                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          0, tb_bitwidth); 
  CONSTANT coeff5                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(        -38, tb_bitwidth); 
  CONSTANT coeff6                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          0, tb_bitwidth); 
  CONSTANT coeff7                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(        -70, tb_bitwidth); 
  CONSTANT coeff8                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          0, tb_bitwidth); 
  CONSTANT coeff9                         : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(       -121, tb_bitwidth); 
  CONSTANT coeff10                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          0, tb_bitwidth); 
  CONSTANT coeff11                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(       -210, tb_bitwidth); 
  CONSTANT coeff12                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          0, tb_bitwidth); 
  CONSTANT coeff13                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(       -401, tb_bitwidth); 
  CONSTANT coeff14                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          0, tb_bitwidth); 
  CONSTANT coeff15                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(      -1288, tb_bitwidth); 
  CONSTANT coeff16                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          0, tb_bitwidth); 
  CONSTANT coeff17                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(       1288, tb_bitwidth); 
  CONSTANT coeff18                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         -0, tb_bitwidth); 
  CONSTANT coeff19                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(        401, tb_bitwidth); 
  CONSTANT coeff20                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         -0, tb_bitwidth); 
  CONSTANT coeff21                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(        210, tb_bitwidth); 
  CONSTANT coeff22                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         -0, tb_bitwidth); 
  CONSTANT coeff23                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(        121, tb_bitwidth); 
  CONSTANT coeff24                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         -0, tb_bitwidth); 
  CONSTANT coeff25                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         70, tb_bitwidth); 
  CONSTANT coeff26                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         -0, tb_bitwidth); 
  CONSTANT coeff27                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         38, tb_bitwidth); 
  CONSTANT coeff28                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         -0, tb_bitwidth); 
  CONSTANT coeff29                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         19, tb_bitwidth); 
  CONSTANT coeff30                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(         -0, tb_bitwidth); 
  CONSTANT coeff31                        : signed(tb_bitwidth-1 DOWNTO 0) :=  to_signed(          9, tb_bitwidth);

	COMPONENT fir
	generic(
		bitwidth : integer;
		order : integer
	);
	 port(
	  --	 coeffs_bus : IN coeff_array(0 to order)(0 downto -bitwidth+1);

	    coeffs_bus : IN coeff_array(0 to order);
	    clk : IN  STD_ULOGIC;
        rst : IN  STD_ULOGIC;
	  -- data input
		i_data       : in  std_ulogic_vector( bitwidth-1 downto 0);
	  -- filtered data 
		o_data       : out std_ulogic_vector( bitwidth-1 downto 0));
	END COMPONENT;
	
  component delay_line is
   generic(
		bitwidth : integer;
		order : integer
	);
    port(   clk : in STD_ULOGIC; 
		  rst : in STD_ULOGIC; 
		  i_data :in std_ulogic_vector(bitwidth-1 downto 0); 
		  o_data : out std_ulogic_vector(bitwidth-1 downto 0));
  end component;
	
	signal coeffs_bus_tb : coeff_array(0 to tb_order) ;
	--signal coeffs_bus_tb : coeff_array(0 to tb_order)(0 downto -tb_bitwidth+1) ;

	signal time_tb : std_ulogic_vector( 16 downto 0) := std_ulogic_vector(to_signed(0, 17)); -- 262144
	signal clk_tb : STD_ULOGIC := '0';
	signal rst_tb : STD_ULOGIC := '0';
	signal i_data_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);
	signal o_hilbert_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);
	signal o_delay_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);

    signal p_hilbert_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);
	signal p_delay_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);
	signal q_hilbert_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);
	signal q_delay_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);
    signal r_hilbert_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);
	signal r_delay_tb    : std_ulogic_vector( tb_bitwidth-1 downto 0);

	constant clk_period : time := 1 ns;

  
begin

fir1 : fir 
generic map (
		bitwidth => tb_bitwidth,
		order => tb_order
	)
	PORT MAP (
		 
		  coeffs_bus => coeffs_bus_tb,
          clk => clk_tb,
          rst => rst_tb,
		  i_data => i_data_tb,
		  o_data => q_hilbert_tb
	);
	
	--i_data => p_hilbert_tb;
	
fir2 : fir 
generic map (
		bitwidth => tb_bitwidth,
		order => tb_order
	)
	PORT MAP (
		 
		  coeffs_bus => coeffs_bus_tb,
          clk => clk_tb,
          rst => rst_tb,
		  i_data => q_hilbert_tb,
		  o_data => r_hilbert_tb
	);
	
delay1   : delay_line 
	generic map (
		bitwidth => tb_bitwidth,
		order => tb_order
	)
	port map (
		clk => clk_tb, 
		rst => rst_tb, 
		i_data =>  i_data_tb, --i_delay, 
		o_data =>  q_delay_tb --o_delay
		);
	
delay2   : delay_line 
	generic map (
		bitwidth => tb_bitwidth,
		order => tb_order
	)
	port map (
		clk => clk_tb, 
		rst => rst_tb, 
		i_data =>  q_delay_tb, --i_delay, 
		o_data =>  r_delay_tb --o_delay
		);
	
	clk_process : process
    begin
	  clk_tb <= '0';
	  wait for clk_period/2;
	  clk_tb <= '1';
	  wait for clk_period/2;
    end process;
   
    stim_proc: process 
      variable x, s1, s2 : real;
	  variable tact, tper1, tper2, f1, f2, freq , ts: real;
	  variable cosinus1, cosinus2 : std_ulogic_vector(tb_bitwidth-1 downto 0);
    begin    
	
	  rst_tb <= '0';
	  coeffs_bus_tb <= (others=>(others=>'0'));
	  i_data_tb <= (others=> std_ulogic ' ('0'));
	
	  f1 :=  0.15;
	  f2 := real(2.0)/real(5.0);
	  
	  tper1 := 1.0/f1;
	  tper2 := 1.0/f2;
	  
	  
	  
	  
	  
		wait for clk_period;
		  rst_tb <= '1'; 
		 
		 coeffs_bus_tb(0) <= std_ulogic_vector(coeff1);
		 coeffs_bus_tb(1) <= std_ulogic_vector(coeff2);
		 coeffs_bus_tb(2) <= std_ulogic_vector(coeff3);
		 coeffs_bus_tb(3) <= std_ulogic_vector(coeff4);
		 coeffs_bus_tb(4) <= std_ulogic_vector(coeff5);
		 coeffs_bus_tb(5) <= std_ulogic_vector(coeff6);
		 coeffs_bus_tb(6) <= std_ulogic_vector(coeff7);
		 coeffs_bus_tb(7) <= std_ulogic_vector(coeff8);
		 coeffs_bus_tb(8) <= std_ulogic_vector(coeff9);
		 coeffs_bus_tb(9) <= std_ulogic_vector(coeff10);
		 coeffs_bus_tb(10) <= std_ulogic_vector(coeff11);
		 coeffs_bus_tb(11) <= std_ulogic_vector(coeff12);
		 coeffs_bus_tb(12) <= std_ulogic_vector(coeff13);
		 coeffs_bus_tb(13) <= std_ulogic_vector(coeff14);
		 coeffs_bus_tb(14) <= std_ulogic_vector(coeff15);
		 coeffs_bus_tb(15) <= std_ulogic_vector(coeff16);
		 coeffs_bus_tb(16) <= std_ulogic_vector(coeff17);
		 coeffs_bus_tb(17) <= std_ulogic_vector(coeff18);
		 coeffs_bus_tb(18) <= std_ulogic_vector(coeff19);
		 coeffs_bus_tb(19) <= std_ulogic_vector(coeff20);
		 coeffs_bus_tb(20) <= std_ulogic_vector(coeff21);
		 coeffs_bus_tb(21) <= std_ulogic_vector(coeff22);
		 coeffs_bus_tb(22) <= std_ulogic_vector(coeff23);
		 coeffs_bus_tb(23) <= std_ulogic_vector(coeff24);
		 coeffs_bus_tb(24) <= std_ulogic_vector(coeff25);
		 coeffs_bus_tb(25) <= std_ulogic_vector(coeff26);
		 coeffs_bus_tb(26) <= std_ulogic_vector(coeff27);
		 coeffs_bus_tb(27) <= std_ulogic_vector(coeff28);
		 coeffs_bus_tb(28) <= std_ulogic_vector(coeff29);
		 coeffs_bus_tb(29) <= std_ulogic_vector(coeff30);
		 coeffs_bus_tb(30) <= std_ulogic_vector(coeff31);
		
		for k in 0 to 10000 loop
		    
			s1:= cos(2.0 * MATH_PI * ((real(k)/ tper1 mod 1.0 ))) ;
			s2 := cos(2.0 * MATH_PI *((real(k)/ tper2 mod 1.0 ))) ;
          
		cosinus1 := std_ulogic_vector( to_signed(integer(s1*(2**real(tb_bitwidth)/2.0-1.0) ), tb_bitwidth));			
		--cosinus2 := std_ulogic_vector( to_signed(integer(s2*(2**real(tb_bitwidth)/2.0-1.0) ), tb_bitwidth)); -- integer(s2*(2**real(tb_bitwidth)/2.0-1.0) ), tb_bitwidth
			--sinus := std_logic_vector( to_signed(integer(s*(2**real(tb_bitwidth)/2.0-1.0) ), tb_bitwidth));
			i_data_tb <= std_ulogic_vector( cosinus1);
			wait for clk_period;
			
		end loop;
		 
		 -- coeffs_bus_tb(4) <= std_ulogic_vector(coeff5);
		 -- coeffs_bus_tb(5) <= std_ulogic_vector(coeff6);
		 -- coeffs_bus_tb(6) <= std_logic_vector(coeff7);
		 
		 -- coeffs_bus_tb(0) <= "111111111111";
		 -- coeffs_bus_tb(1) <= "011111111111";
		 -- coeffs_bus_tb(2) <= "100000000000";
		 -- coeffs_bus_tb(3) <= "110000000000";
		 -- coeffs_bus_tb(4) <= "000000000001";
		 -- coeffs_bus_tb(5) <= "000000000011";
		 -- coeffs_bus_tb(6) <= "000000000000";
		 
		 wait for clk_period;
		 -- i_data_tb <= std_logic_vector( to_signed(2**(tb_bitwidth-1)-1, tb_bitwidth)) ;-- SLICE(X"07ff",tb_bitwidth); --x"01"; --signed(10) ); -- x"01";


		 -- coeffs_bus_tb(0) <= "111111111111";
		 -- coeffs_bus_tb(1) <= "011111111111";
		 -- coeffs_bus_tb(2) <= "100000000000";
		 -- coeffs_bus_tb(3) <= "110000000000";
		 -- coeffs_bus_tb(4) <= "000000000001";
		 -- coeffs_bus_tb(5) <= "000000000011";
		 -- coeffs_bus_tb(6) <= "000000000000";
		 
		 wait for clk_period;
		 i_data_tb <=(others=> std_ulogic ' ('0'));
		 -- coeffs_bus_tb(0) <= std_logic_vector(to_signed(-1,12));
		 -- coeffs_bus_tb(1) <= std_logic_vector(to_signed(2047,12));
		 -- coeffs_bus_tb(2) <= std_logic_vector(to_signed(-2048,12));
		 -- coeffs_bus_tb(3) <= std_logic_vector(to_signed(-1024,12));
		 -- coeffs_bus_tb(4) <= std_logic_vector(to_signed(1,12));
		 -- coeffs_bus_tb(5) <= std_logic_vector(to_signed(3,12));
		 -- coeffs_bus_tb(6) <= std_logic_vector(to_signed(0,12));
		 
		 wait for clk_period;
		 -- coeffs_bus_tb(0) <= std_logic_vector(to_signed(0,12));
		 -- coeffs_bus_tb(1) <= std_logic_vector(to_signed(0,12));
		 -- coeffs_bus_tb(2) <= std_logic_vector(to_signed(0,12));
		 -- coeffs_bus_tb(3) <= std_logic_vector(to_signed(0,12));
		 -- coeffs_bus_tb(4) <= std_logic_vector(to_signed(0,12));
		 -- coeffs_bus_tb(5) <= std_logic_vector(to_signed(0,12));
		 -- coeffs_bus_tb(6) <= std_logic_vector(to_signed(0,12));
			

	 
	  wait for clk_period;
	  i_data_tb <= (others=> std_ulogic ' ('0'));
	  wait;
   end process;
   

  -- synopsys translate_off
  p_config_aus: process
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
