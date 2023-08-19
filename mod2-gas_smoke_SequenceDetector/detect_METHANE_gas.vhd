LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY detect_METHANE_gas IS
    PORT(
        clk : IN STD_LOGIC;
        data_in : IN STD_LOGIC; 
        detect_flag : OUT STD_LOGIC
    );
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE behavioral OF detect_METHANE_gas IS
    
    TYPE MethaneStates  IS (start,got1,got10,got101,got1011,got10111,got101110,got1011101,got10111010,got101110101,got1011101010);
    
BEGIN

    PROCESS(clk,data_in)
        VARIABLE methaneState , nextState  : MethaneStates := start ;
    BEGIN
        CASE methaneState IS
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
                    nextState := got101;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got101 =>
                IF (data_in = '1') THEN
                    nextState := got1011;
                ELSIF (data_in = '0') THEN
                    nextState := got10;
                END IF;
            WHEN got1011 =>
                IF (data_in = '1') THEN
                    nextState := got10111;
                ELSIF (data_in = '0') THEN
                    nextState := got10;
                END IF;
            WHEN got10111 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got101110;
                END IF;
            WHEN got101110 =>
                IF (data_in = '1') THEN
                    nextState := got1011101;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got1011101 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got10111010;
                END IF;
            WHEN got10111010 =>
                IF (data_in = '1') THEN
                    nextState := got101110101;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got101110101 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got1011101010;
                END IF;            
            WHEN got1011101010 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
        END CASE;

        methaneState := nextState;

        if (methaneState = got1011101010) THEN
            detect_flag <= '1';
        ELSE
            detect_flag <= '0';
        END IF;
    END PROCESS;

END ARCHITECTURE;