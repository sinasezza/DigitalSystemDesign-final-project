LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY FanSpeed IS
    PORT (
        arst     : IN  STD_LOGIC;      -- reset [asynch]  
        clk      : IN  STD_LOGIC;      -- clock [posedge] 
        speed    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- speed  
        chs_mode : IN STD_LOGIC;
        pwd_data : OUT STD_LOGIC       -- data  [output]
    );
END ENTITY;

-- =======================================================
-- =======================================================

ARCHITECTURE behavioral of FanSpeed IS
    CONSTANT cycle    : NATURAL := 8;
    -- SIGNAL dutyCycle  : REAL;
    SIGNAL onesCycle  : INTEGER;
    SIGNAL iterator   : NATURAL    :=  1;
    SIGNAL gen_val    : STD_LOGIC  :=  '1';

BEGIN

    -- dutyCycle <=  real(to_integer(unsigned(speed)))/256.0;
    onesCycle <=  integer((real(to_integer(unsigned(speed)))/256.0) * real(cycle));

    PROCESS(clk,arst) 
    BEGIN
        IF(arst='1') THEN   
            pwd_data <= '0';
            iterator <= 0;
            gen_val  <= '0';
        END IF;

        IF(clk'EVENT AND clk='1') THEN

            IF(chs_mode = '1') THEN 
                pwd_data <= '0';
            ELSE
                IF (iterator <= onesCycle) THEN
                    gen_val <= '1';
                ELSE
                    gen_val <= '0';
                END IF;

                --------------------------------------

                IF(iterator <= cycle) THEN 
                    iterator <= iterator + 1;
                ELSE 
                    iterator <= 0;
                END IF;

                --------------------------------------

                pwd_data <= gen_val;

            END IF;
        END IF;
    END PROCESS;
END behavioral;