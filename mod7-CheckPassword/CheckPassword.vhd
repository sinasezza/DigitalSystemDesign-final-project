LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY CheckPassword IS
    PORT (
        arst        : IN  STD_LOGIC;   
        clk         : IN  STD_LOGIC;
        request     : IN  STD_LOGIC;
        main_pass   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        password    : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        confirm     : IN  STD_LOGIC;
        data_in     : IN  STD_LOGIC_VECTOR(34 DOWNTO 0);
        data_out    : OUT STD_LOGIC_VECTOR(34 DOWNTO 0)
    );
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE behavioral OF CheckPassword IS
    TYPE STATES IS (A_idle,B_active,C_request,D_store,E_trap);
    SIGNAL curr_state , next_state : STATES := A_idle;
BEGIN

    PROCESS (clk,arst,request,confirm)

    BEGIN
        IF(arst = '1') THEN
            curr_state    <= A_idle;
            next_state    <= A_idle;
            data_out      <= (OTHERS => '0');
        END IF;

        IF(request'EVENT AND request = '0') THEN
            curr_state <= A_idle;
            next_state <= A_idle;
        END IF;

        IF(clk'EVENT AND clk = '1') THEN
            curr_state <= next_state;

            CASE curr_state IS
                -- ************************** --
                WHEN A_idle =>
                    IF(request = '1') THEN
                        next_state <= B_active;
                    END IF;
                -- ************************** --
                WHEN B_active =>
                    IF(confirm = '1') THEN
                        IF (unsigned(password) = unsigned(main_pass)) THEN
                            next_state <= C_request;
                        ELSE
                            next_state <= E_trap;
                        END IF;
                    END IF;
                -- ************************** --
                WHEN C_request =>
                    IF(confirm = '1') THEN
                        next_state <= D_store;
                    END IF;
                -- ************************** --
                WHEN D_store =>
                    data_out <= data_in;
                -- ************************** --
                WHEN OTHERS => NULL;
            END CASE;
        END IF;
    END PROCESS;

END ARCHITECTURE;