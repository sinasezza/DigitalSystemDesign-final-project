LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY gas_smoke_SequenceDetector IS
    PORT (
        din     : IN STD_LOGIC;
        clk     : IN STD_LOGIC;
        gas_mode: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE structural OF gas_smoke_SequenceDetector IS
    
    COMPONENT detect_METHANE_gas IS
        PORT(
            clk : IN STD_LOGIC;
            data_in : IN STD_LOGIC; 
            detect_flag : OUT STD_LOGIC
        );
    END COMPONENT;

    ------------------------------------

    COMPONENT detect_CO_gas IS
        PORT(
            clk : IN STD_LOGIC;
            data_in : IN STD_LOGIC; 
            detect_flag : OUT STD_LOGIC
        );
    END COMPONENT;

    ------------------------------------

    COMPONENT detect_CO2_gas IS
        PORT(
            clk : IN STD_LOGIC;
            data_in : IN STD_LOGIC; 
            detect_flag : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    methane : detect_METHANE_gas  PORT MAP(clk,din,gas_mode(0));
    co      : detect_CO_gas       PORT MAP(clk,din,gas_mode(1));
    co2     : detect_CO2_gas      PORT MAP(clk,din,gas_mode(2));
END ARCHITECTURE;