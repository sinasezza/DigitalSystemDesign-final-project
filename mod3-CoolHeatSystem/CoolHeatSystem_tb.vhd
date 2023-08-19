LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY CoolHeatSystem_tb IS
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE test OF CoolHeatSystem_tb IS

    COMPONENT CoolHeatSystem IS
        PORT (
            arst      : IN  STD_LOGIC;                      -- reset [asynch]  
            clk       : IN  STD_LOGIC;                      -- clock [posedge] 
            speed     : IN  STD_LOGIC_VECTOR(7 downto 0);   -- speed
            chs_conf  : IN  STD_LOGIC_VECTOR(7 downto 0);   -- degree [temperature] 
            chs_power : OUT STD_LOGIC_VECTOR(3 downto 0);   -- power  [cooler/heater] 
            chs_mode  : OUT STD_LOGIC;                      -- model  [heat=1/cool=0]
            pwd_data  : OUT STD_LOGIC                       -- data  [output]
        );
    END COMPONENT;

    SIGNAL reset , clock    : STD_LOGIC := '0';
    SIGNAL chs_conf         : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL chs_mode         : STD_LOGIC;
    SIGNAL chs_power        : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL speed            : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL pwd_data         : STD_LOGIC;

BEGIN
    uut : CoolHeatSystem PORT MAP(reset,clock,speed,chs_conf,chs_power,chs_mode,pwd_data);

    reset  <=  '1' , '0' AFTER 10 NS , '1' AFTER 30 NS , '0' AFTER 45 NS;
    clock <= NOT clock AFTER 10 NS;
    
    speed    <= "01000000" , "00100000" AFTER 200 NS;
    chs_conf <= "10101010" , "11111000" AFTER 200 NS;


END ARCHITECTURE;