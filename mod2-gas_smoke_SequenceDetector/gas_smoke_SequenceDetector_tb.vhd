LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY gas_smoke_SequenceDetector_tb IS
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE test OF gas_smoke_SequenceDetector_tb IS

    COMPONENT gas_smoke_SequenceDetector IS
        PORT (
            din     : IN STD_LOGIC;
            clk     : IN STD_LOGIC;
            gas_mode: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL data_in , clock : STD_LOGIC := '0';
    SIGNAL gasMode : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
    uut : gas_smoke_SequenceDetector PORT MAP(data_in,clock,gasMode);
    clock <= NOT clock AFTER 10 NS;

               -- for co2 gas
    data_in <= '1' , '0' AFTER 10 NS , '1' AFTER 20 NS , '0' AFTER 30 NS , '0' AFTER 40 NS , '1' AFTER 50 NS,
               '0' AFTER 60 NS , '0' AFTER 70 NS , '1' AFTER 80 NS , '0' AFTER 90 NS , '0' AFTER 100 NS,
               -- for methane gas
               '1' AFTER 110 NS , '0' AFTER 120 NS , '1' AFTER 130 NS , '1' AFTER 140 NS , '1' AFTER 150 NS,
               '0' AFTER 160 NS , '1' AFTER 170 NS , '0' AFTER 180 NS , '1' AFTER 190 NS , '0' AFTER 200 NS,
               -- for co gas 
               '1' AFTER 210 NS , '0' AFTER 220 NS , '1' AFTER 230 NS , '0' AFTER 240 NS , '1' AFTER 250 NS,
               '0' AFTER 260 NS , '0' AFTER 270 NS , '1' AFTER 280 NS , '0' AFTER 290 NS , '0' AFTER 300 NS,
               '1' AFTER 310 NS , '1' AFTER 320 NS;

END ARCHITECTURE;