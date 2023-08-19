LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY DFlop IS
    PORT (
        arst  : IN  STD_LOGIC;  -- async reset
        clk   : IN  STD_LOGIC;  -- clock posedge
        Pin   : IN  STD_LOGIC;  -- data load 
        din   : IN  STD_LOGIC;  -- data in
        load  : IN STD_LOGIC;   -- load in
        qout  : OUT STD_LOGIC   -- q out
    );
END DFlop;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE behavioral of DFlop IS 

BEGIN

    PROCESS(clk,arst)

    BEGIN
        IF(arst = '1') THEN
            qout <= '0';
        END IF;

        IF(clk'EVENT AND clk = '1') THEN
            IF(load = '1') THEN
                qout <= Pin;
            ELSIF(load = '0') THEN
                qout <= din;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;