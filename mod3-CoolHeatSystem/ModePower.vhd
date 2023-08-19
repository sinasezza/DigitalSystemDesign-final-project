LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY ModePower IS
    PORT (
        arst      : IN  STD_LOGIC;
        clk       : IN  STD_LOGIC;
        chs_conf  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- degree [temperature] 
        chs_power : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- power  [cooler/heater] 
        chs_mode  : buffer STD_LOGIC                     -- model  [heat=1/cool=0]
    );
END ENTITY;

-- =======================================================
-- =======================================================

ARCHITECTURE behavioral of ModePower IS

    FUNCTION count_ones(in_vec : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN INTEGER IS
        variable count : INTEGER := 0;
    BEGIN
        FOR i IN in_vec'RANGE LOOP
            IF(in_vec(i) = '1') THEN
                count := count + 1;
            END IF;
        END LOOP;

        RETURN count;
    END FUNCTION count_ones;

    -- ===================================

BEGIN

    PROCESS(clk,arst,chs_conf)
        VARIABLE no_of_ones : INTEGER;
    BEGIN
        IF(arst = '1') THEN
            chs_power <= (OTHERS => '0');
        END IF;

        IF(clk'EVENT AND clk = '1') THEN
            no_of_ones := count_ones(chs_conf);

            IF(no_of_ones MOD 2 = 0) THEN
                chs_mode <= '0';
            ELSE
                chs_mode <= '1';
            END IF;

            IF(chs_mode = '1') THEN
                chs_power <= std_logic_vector(to_unsigned(no_of_ones,4));
            ELSE
                chs_power <= (OTHERS => '0');
            END IF;
        END IF;
END PROCESS;

END behavioral;