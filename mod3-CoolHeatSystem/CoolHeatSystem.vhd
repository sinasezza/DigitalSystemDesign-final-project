LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY CoolHeatSystem IS
    PORT (
        arst      : IN  STD_LOGIC;     -- reset [asynch]  
        clk       : IN  STD_LOGIC;     -- clock [posedge] 
        speed     : IN  STD_LOGIC_VECTOR(7 downto 0); -- speed
        chs_conf  : IN  STD_LOGIC_VECTOR(7 downto 0); -- degree [temperature] 
        chs_power : OUT STD_LOGIC_VECTOR(3 downto 0); -- power  [cooler/heater] 
        chs_mode  : OUT STD_LOGIC;                  -- model  [heat=1/cool=0]
        pwd_data  : OUT STD_LOGIC                   -- data  [output]
    );
END CoolHeatSystem;


-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE behavioral OF CoolHeatSystem IS

    COMPONENT ModePower IS
        PORT (
            arst      : IN  STD_LOGIC;
            clk       : IN  STD_LOGIC;
            chs_conf  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- degree [temperature] 
            chs_power : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- power  [cooler/heater] 
            chs_mode  : OUT STD_LOGIC                     -- model  [heat=1/cool=0]
        );
    END COMPONENT;

    COMPONENT FanSpeed IS
        PORT (
            arst     : IN  STD_LOGIC;      -- reset [asynch]  
            clk      : IN  STD_LOGIC;      -- clock [posedge] 
            speed    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- speed  
            chs_mode : IN STD_LOGIC;
            pwd_data : OUT STD_LOGIC       -- data  [output]
        );
    END COMPONENT;

    SIGNAL mode : STD_LOGIC;
BEGIN
    modeProbe : ModePower PORT MAP(arst,clk,chs_conf,chs_power,mode);
    fan       : FanSpeed  PORT MAP(arst,clk,speed,mode,pwd_data);
    
    chs_mode <= mode;

END ARCHITECTURE;