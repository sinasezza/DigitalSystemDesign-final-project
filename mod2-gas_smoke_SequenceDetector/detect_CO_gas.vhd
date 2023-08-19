LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY detect_CO_gas IS
    PORT(
        clk : IN STD_LOGIC;
        data_in : IN STD_LOGIC; 
        detect_flag : OUT STD_LOGIC
    );
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE behavioral OF detect_CO_gas IS
    
    TYPE CoStates       IS (start,got1,got10,got101,got1010,got10101,got101010,got1010100,got10101001,got101010010,got1010100100,got10101001001,got101010010011);
    
BEGIN

    PROCESS(clk,data_in)
        VARIABLE coState , nextState  : CoStates := start ;
    BEGIN
        CASE coState IS
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
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got1010;
                END IF;
            WHEN got1010 =>
                IF (data_in = '1') THEN
                    nextState := got10101;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got10101 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got101010;
                END IF;
            WHEN got101010 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got1010100;
                END IF;
            WHEN got1010100 =>
                IF (data_in = '1') THEN
                    nextState := got10101001;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got10101001 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got101010010;
                END IF;
            WHEN got101010010 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got1010100100;
                END IF;
            WHEN got1010100100 =>
                IF (data_in = '1') THEN
                    nextState := got10101001001;
                ELSIF (data_in = '0') THEN
                    nextState := start;
                END IF;
            WHEN got10101001001 =>
                IF (data_in = '1') THEN
                    nextState := got101010010011;
                ELSIF (data_in = '0') THEN
                    nextState := got10;
                END IF;
            WHEN got101010010011 =>
                IF (data_in = '1') THEN
                    nextState := got1;
                ELSIF (data_in = '0') THEN
                    nextState := got10;
                END IF;
        END CASE;

        coState := nextState;

        if (coState = got101010010011) THEN
            detect_flag <= '1';
        ELSE
            detect_flag <= '0';
        END IF;
    END PROCESS;

END ARCHITECTURE;