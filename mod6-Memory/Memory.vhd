LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY Memory IS
    PORT (
        arst    : IN    STD_LOGIC;
        clk     : IN    STD_LOGIC;
        mem_in  : IN    STD_LOGIC_VECTOR(34 DOWNTO 0);
        mem_out : OUT   STD_LOGIC_VECTOR(34 DOWNTO 0)
    );
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE behavioral OF Memory IS

BEGIN
    PROCESS(clk,arst)
    BEGIN
        IF(arst = '1') THEN 
            mem_out <= (OTHERS => '0');
        END IF;

        IF(clk'EVENT AND clk = '1') THEN
            mem_out <= mem_in;
        END IF;
    END PROCESS;
END ARCHITECTURE;