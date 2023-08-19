LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY LightingSystem_tb IS
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE test OF LightingSystem_tb IS

    COMPONENT LightingSystem IS
        PORT (
            t_code      : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
            user_light  : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
            user_wshade : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
            length      : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
            wshade      : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
            lights_num  : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
            light_state : OUT   STD_LOGIC_VECTOR(15 downto 0)
        );
    END COMPONENT;

    SIGNAL t_code, user_light, user_wshade, length, wshade, lights_num : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL light_state : STD_LOGIC_VECTOR(15 downto 0);

BEGIN
    uut : LightingSystem PORT MAP (t_code, user_light, user_wshade, length, wshade, lights_num, light_state);

    t_code      <= "0001" , "0010" AFTER 050 NS , "0100" AFTER 100 NS , "1000" AFTER 150 NS , "1111" AFTER 200 NS;
    user_light  <= "1010" , "1110" AFTER 150 NS , "0111" AFTER 170 NS;
    user_wshade <= "1101" , "0100" AFTER 100 NS , "0011" AFTER 125 NS;
    length      <= "1100" , "0100" AFTER 100 NS , "0101" AFTER 115 NS;

END ARCHITECTURE;