



library ieee, UNISIM;
use ieee.numeric_std.all;
use UNISIM.VCOMPONENTS.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

entity si5324_init is
  port (
    Din      : out    std_logic_vector(7 downto 0);
    Dout     : in     std_logic_vector(7 downto 0);
    LOL_READ : out    std_logic_vector(7 downto 0);
    LOS_READ : out    std_logic_vector(7 downto 0);
    RST      : in     std_logic;
    ack_in   : out    std_logic;
    ack_out  : in     std_logic;
    clk      : out    std_logic;
    clk40    : in     std_logic;
    cmd_ack  : in     std_logic;
    ena      : out    std_logic;
    nReset   : out    std_logic;
    read     : out    std_logic;
    start    : out    std_logic;
    stop     : out    std_logic;
    write    : out    std_logic);
end entity si5324_init;


architecture rtl of si5324_init is

  COMPONENT I2C_WRFifo
    PORT (
      rst : IN std_logic;
      wr_clk : IN std_logic;
      rd_clk : IN std_logic;
      din : IN std_logic_vector(24 DOWNTO 0);
      wr_en : IN std_logic;
      rd_en : IN std_logic;
      dout : OUT std_logic_vector(24 DOWNTO 0);
      full : OUT std_logic;
      empty : OUT std_logic
    );
  END COMPONENT;

  signal reset : std_logic;

  signal i2c_din       : std_logic_vector(24 downto 0);
  signal rdfifo_din    : std_logic_vector(7 downto 0);
  signal wrfifo_dout   : std_logic_vector(24 downto 0);
  
  signal rdfifo_wren   : std_logic;
  signal rdfifo_full   : std_logic;
  signal wrfifo_rden   : std_logic;
  signal wrfifo_empty, wrfifo_full  : std_logic;
  
  type i2c_wr_state_type is(IDLE, DLY, ADDR, ADDRACK, WRITE2B1, WRITE2B1ACK, WRITE2B2, WRITE2B2ACK,WRITE1B, WRITE1BACK, READADDR, READADDRACK, READDATA, READDATAACK );
  signal i2c_wr_state: i2c_wr_state_type := IDLE;
  signal wrfifo_wren_pipe: std_logic;
  signal wrfifo_wren     : std_logic;
  
  signal rdfifo_rden_pipe: std_logic;
  signal rdfifo_rden     : std_logic;
  constant WATCHDOG_PERIOD: integer := 65535;
  signal watchdog: integer range 0 to WATCHDOG_PERIOD;
  
  signal twobytes: std_logic;
  signal RnW:    std_logic;
  signal cmd_ack_pipe: std_logic;
  
  signal start_s    : std_logic;
  signal stop_s     : std_logic;
  signal ack_in_s   : std_logic;
  type array43x2_slv8 is array(0 to 42, 0 to 1) of std_logic_vector(7 downto 0);
  
  --160 MHz in, 240MHz out, free running disabled
  --constant si5324_240_regs : array43x2_slv8 := 
  --(
  --  (x"00", x"14"), (x"01", x"E4"), (x"02", x"A2"), (x"03", x"15"), (x"04", x"12"), (x"05", x"ED"), (x"06", x"3F"), (x"07", x"29"),
  --  (x"08", x"00"), (x"09", x"C0"), (x"0A", x"08"), (x"0B", x"42"), (x"13", x"09"), (x"14", x"3E"), (x"15", x"FF"), (x"16", x"DF"),
  --  (x"17", x"1F"), (x"18", x"3F"), (x"19", x"E0"), (x"1F", x"00"), (x"20", x"00"), (x"21", x"01"), (x"22", x"00"), (x"23", x"00"),
  --  (x"24", x"01"), (x"28", x"E0"), (x"29", x"00"), (x"2A", x"F5"), (x"2B", x"00"), (x"2C", x"00"), (x"2D", x"51"), (x"2E", x"00"),
  --  (x"2F", x"00"), (x"30", x"51"), (x"37", x"1B"), (x"83", x"1F"), (x"84", x"02"), (x"89", x"01"), (x"8A", x"0F"), (x"8B", x"FF"),
  --  (x"8E", x"00"), (x"8F", x"00"), (x"88", x"40")
  --);
  
  --244.79 in, 244.79 out, free running enabled.
  constant si5324_240_regs : array43x2_slv8 := 
  (
    (x"00", x"54"),
    (x"01", x"E4"),
    (x"02", x"32"),
    (x"03", x"15"),
    (x"04", x"92"),
    (x"05", x"ED"),
    (x"06", x"2D"),
    (x"07", x"2A"),
    (x"08", x"00"),
    (x"09", x"C0"),
    (x"0A", x"08"),
    (x"0B", x"40"),
    (x"13", x"29"),
    (x"14", x"36"),
    (x"15", x"FE"),
    (x"16", x"DF"),
    (x"17", x"1B"),
    (x"18", x"3B"),
    (x"19", x"E0"),
    (x"1F", x"00"),
    (x"20", x"00"),
    (x"21", x"01"),
    (x"22", x"00"),
    (x"23", x"00"),
    (x"24", x"01"),
    (x"28", x"E0"),
    (x"29", x"71"),
    (x"2A", x"C9"),
    (x"2B", x"00"),
    (x"2C", x"38"),
    (x"2D", x"E4"),
    (x"2E", x"00"),
    (x"2F", x"1B"),
    (x"30", x"09"),
    (x"37", x"00"),
    (x"83", x"1F"),
    (x"84", x"02"),
    (x"89", x"01"),
    (x"8A", x"0F"),
    (x"8B", x"FD"),
    (x"8E", x"00"),
    (x"8F", x"00"),
    (x"88", x"40")
  );
  
  constant SI5324_ADDR              : std_logic_vector(7 downto 0) := x"68";
  constant I2C_ADDR_SWITCH1_FLX_709 : std_logic_vector(7 downto 0) := x"74";
  constant I2C_ADDR_SWITCH2_FLX_709 : std_logic_vector(7 downto 0) := x"75";
  signal cnt : integer range 0 to 63;
  signal startup_delay: integer range 0 to 65535;
begin


  
  nReset <= not reset;
  reset <= RST;
  clk <= clk40;
  
  
  start <= start_s;
  stop <= stop_s;
  ack_in <= ack_in_s;
  
  
--process(i2c_wr_state)
--begin
--    case(i2c_wr_state) is
--        when IDLE        => i2c_wr_state_o <= x"0";
--        when DLY         => i2c_wr_state_o <= x"1"; 
--        when ADDR        => i2c_wr_state_o <= x"2";
--        when ADDRACK     => i2c_wr_state_o <= x"3";
--        when WRITE2B1    => i2c_wr_state_o <= x"4"; 
--        when WRITE2B1ACK => i2c_wr_state_o <= x"5";    
--        when WRITE2B2    => i2c_wr_state_o <= x"6";    
--        when WRITE2B2ACK => i2c_wr_state_o <= x"7";    
--        when WRITE1B     => i2c_wr_state_o <= x"8";
--        when WRITE1BACK  => i2c_wr_state_o <= x"9";
--        when READADDR    => i2c_wr_state_o <= x"A";
--        when READADDRACK => i2c_wr_state_o <= x"B";
--        when READDATA    => i2c_wr_state_o <= x"C";
--        when READDATAACK => i2c_wr_state_o <= x"D";
--        when others      => i2c_wr_state_o <= x"F";
--    end case;
--end process;
  
  i2c_rdwr: process(clk40, reset)
    
  begin
      if(reset = '1') then
          wrfifo_rden <= '0';
          i2c_wr_state <= IDLE;
          watchdog <= 0;
          LOS_READ <= x"AB";
          LOL_READ <= x"AB";
          cnt <= 0;
          startup_delay <= 6000;
          
      elsif(rising_edge(clk40)) then
          wrfifo_rden <= '0';
          rdfifo_wren <= '0';
          
          
          RnW <= RnW;
          twoBytes <= twoBytes;
          write <= '0';
          read <= '0';
          
          start_s <= start_s;
          stop_s <= stop_s;
          ack_in_s <= ack_in_s;
          cmd_ack_pipe <= cmd_ack;
          
          case(i2c_wr_state) is
              when IDLE =>
                  if(startup_delay > 0) then
                    i2c_wr_state <= IDLE;
                    startup_delay <= startup_delay - 1; --wait for the I2C module to reset first.
                    ena <= '1';
                  else
                    ena <= '1';
                    if(cnt = 0) then
                        --write only one byte to the first data switch
                        wrfifo_dout <= "0" & x"00" & x"80" & I2C_ADDR_SWITCH1_FLX_709(6 downto 0) & "0";
                    --elsif(cnt = 1) then
                    --    --write only one byte to the second data switch
                    --    wrfifo_dout <= "0" & x"00" & x"00" & I2C_ADDR_SWITCH2_FLX_709(6 downto 0) & "0";
                    elsif(cnt >= 1 and cnt <= 43) then 
                        --write Address and Data byte to Si5324
                        wrfifo_dout <= "1" & si5324_240_regs(cnt-1,1) & si5324_240_regs(cnt-1,0) & SI5324_ADDR(6 downto 0) & "0";  
                    elsif(cnt = 44) then --Finished initializing Si5324, read LOS 0x81
                        wrfifo_dout <= "1" & x"00" & x"81" & SI5324_ADDR(6 downto 0) & "1"; --keep reading LOS register 129
                    else --(cnt = 46) then--Read LOL 0x82
                        wrfifo_dout <= "1" & x"00" & x"82" & SI5324_ADDR(6 downto 0) & "1"; --keep reading LOL register 130
                    end if;
            
                    if(cnt >= 45) then
                        cnt <= 44;
                    else
                        cnt<= cnt + 1;
                    end if;
                    i2c_wr_state <= DLY;
                    startup_delay <= 6000;
                  end if;
              when DLY => 
                  i2c_wr_state <= ADDR;
              when ADDR =>
                  if(wrfifo_dout(24) = '1') then
                    Din <= wrfifo_dout(7 downto 1)&'0'; --always write first, read will occur later
                  else
                    Din <= wrfifo_dout(7 downto 0); --read if read bit selected.
                  end if;
                  ack_in_s <= '1';
                  write <= '1';
                  start_s <= '1';
                  stop_s <= '0';
                  RnW <= wrfifo_dout(0);
                  twoBytes <= wrfifo_dout(24);
                  i2c_wr_state <= ADDRACK;
                  
              when ADDRACK =>
                  if(cmd_ack = '1') then
                    if(twoBytes = '1') then
                      if(RnW = '1') then --Write one byte, then repeated start, address and read
                        i2c_wr_state <= WRITE1B; --first write one byte, then read
                      else               --Write two bytes, then stop
                        i2c_wr_state <= WRITE2B1; --write two bytes.
                      end if;
                    else
                      if(RnW = '1') then --Read one byte, then stop
                        i2c_wr_state <= READDATA;
                      else               --Write one byte then stop.
                        i2c_wr_state <= WRITE1B;
                      end if;
                    end if;
                  else
                    i2c_wr_state <= ADDRACK;
                  end if;
                  
              when WRITE2B1 => 
                  ack_in_s <= '1';
                  stop_s <= '0';
                  start_s <= '0';
                  Din <= wrfifo_dout(15 downto 8);
                  write <= '1';
                  i2c_wr_state <= WRITE2B1ACK;
              when WRITE2B1ACK =>    
                  if(cmd_ack = '1') then
                    i2c_wr_state <= WRITE2B2;
                  else
                    i2c_wr_state <= WRITE2B1ACK;
                  end if;
              when WRITE2B2 =>    
                  Din <= wrfifo_dout(23 downto 16);
                  write <= '1';
                  stop_s <= '1';
                  start_s <= '0';
                  ack_in_s <= '1';
                  i2c_wr_state <= WRITE2B2ACK;
              when WRITE2B2ACK =>    
                  if(cmd_ack = '1') then
                    i2c_wr_state <= IDLE;
                  else
                    i2c_wr_state <= WRITE2B2ACK;
                  end if;
              when WRITE1B =>
                  Din <= wrfifo_dout(15 downto 8);
                  write <= '1';
                  start_s <= '0';
                  ack_in_s <= '1';
                  if(RnW = '1') then
                    stop_s <= '0'; --don't stop, do a repeated start.
                  else
                    stop_s <= '1';
                  end if;
                  i2c_wr_state <= WRITE1BACK;
              when WRITE1BACK =>
                  if(cmd_ack = '1') then
                    if(RnW = '1') then
                      i2c_wr_state <= READADDR;
                    else
                      i2c_wr_state <= IDLE;
                    end if;
                  else
                    i2c_wr_state <= WRITE1BACK;
                  end if;
              when READADDR =>
                  Din <= wrfifo_dout(7 downto 1) & '1';
                  write <= '1';
                  start_s <= '1';
                  stop_s <= '0';
                  ack_in_s <= '1';
                  i2c_wr_state <= READADDRACK;
              when READADDRACK =>
                  if(cmd_ack = '1') then
                    i2c_wr_state <= READDATA;
                  else
                    i2c_wr_state <= READADDRACK;
                  end if;
              when READDATA =>
                  Din <= x"00";
                  read <= '1';
                  start_s <= '0';
                  stop_s <= '1';
                  ack_in_s <= '1';
                  i2c_wr_state <= READDATAACK;
              when READDATAACK =>
                  if(cmd_ack_pipe = '1') then
                    rdfifo_wren <= not rdfifo_full;
                    i2c_wr_state <= IDLE;
                    rdfifo_din(7 downto 0) <= Dout;
                    if(cnt= 44) then
                        LOS_READ <= Dout;
                    elsif(cnt=45) then
                        LOL_READ <= Dout;
                    end if;
                  else
                    i2c_wr_state <= READDATAACK;
                  end if;
              when others =>
                  i2c_wr_state <= IDLE;
                  
          end case;
          
          --if(watchdog = WATCHDOG_PERIOD) then
          --    i2c_wr_state <= IDLE;
          --    watchdog <= 0;
          --    cnt <= cnt - 1;
          --else
          --    watchdog <= watchdog + 1;
          --end if;
          --if( i2c_wr_state = IDLE) then
          --  watchdog <= 0;
          --end if;
      end if;
  end process;
  
  


end architecture rtl ; -- of si5324_init

