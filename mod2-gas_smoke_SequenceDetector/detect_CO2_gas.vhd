LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY detect_CO2_gas IS
    PORT(
        clk : IN STD_LOGIC;
        data_in : IN STD_LOGIC; 
        detect_flag : OUT STD_LOGIC
    );
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE behavioral OF detect_CO2_gas IS
    
    TYPE Co2States      IS (start,got1,got10,got100,got1001,got10010,got100100,got1001001,got10010010,got100100100);
    
BEGIN

    PROCESS(clk,data_in)
        VARIABLE co2State , nextState  : Co2States := start ;
    BEGIN
        CASE co2State IS
            WHEN start =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got1 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got10;
                END IF;
            WHEN got10 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got100;
                END IF;
            WHEN got100 =>
                IF (data_in = '1') THEN
                    nextState := got1001;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got1001 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got10010;
                END IF;
            WHEN got10010 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got100100;
                END IF;
            WHEN got100100 =>
                IF (data_in = '1') THEN
                    nextState := got1001001;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got1001001 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got10010010;
                END IF;
            WHEN got10010010 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got100100100;
                END IF;
            WHEN got100100100 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
        END CASE;

        co2State := nextState;

        if (co2State = got100100100) THEN
            detect_flag <= '1';
        ELSE
            detect_flag <= '0';
        END IF;
    END PROCESS;

END ARCHITECTURE;