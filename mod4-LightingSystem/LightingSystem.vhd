LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY LightingSystem IS
    PORT (
        t_code      : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
        user_light  : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
        user_wshade : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
        length      : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);
        wshade      : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
        lights_num  : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
        light_state : OUT   STD_LOGIC_VECTOR(15 downto 0)
    );
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE behavioral OF LightingSystem IS

    FUNCTION SpecialDecoder(in_dec : STD_LOGIC_VECTOR(3 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS -- 15 DOWNTO 0
        VARIABLE in_dec_number : INTEGER ;
        VARIABLE out_dec : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    BEGIN
        in_dec_number := to_integer(unsigned(in_dec));
        
        IF(in_dec_number >= 1) THEN
            out_dec(in_dec_number-1 DOWNTO 0) := (OTHERS => '1');
        ELSE 
            out_dec := (OTHERS => '0');
        END IF;

        RETURN out_dec;
    END FUNCTION SpecialDecoder;

    ------------------------------

    FUNCTION area2perimeter(len : STD_LOGIC_VECTOR(3 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE len_int    : INTEGER;
        VARIABLE area       : INTEGER;
        VARIABLE perimeter  : INTEGER;
        VARIABLE a2p_int    : INTEGER;
    BEGIN
        len_int   := to_integer(unsigned(len));
        area      := len_int * len_int;
        perimeter := len_int * 4;
        a2p_int   := area / perimeter;
        return std_logic_vector(to_unsigned(a2p_int,len'LENGTH));
    END FUNCTION area2perimeter;

BEGIN

    PROCESS(t_code,user_light,user_wshade,length)
        VARIABLE numberOfLights : STD_LOGIC_VECTOR(3 DOWNTO 0);
    BEGIN
        CASE t_code IS
            WHEN "0001" =>
                wshade          <= "1111";
                lights_num      <= "0000";
                light_state     <= SpecialDecoder("0000");
            WHEN "0010" =>
                wshade          <= "1011";
                lights_num      <= "0000";
                light_state     <= specialDecoder("0000");
            WHEN "0100" =>
                wshade          <= user_wshade;
                numberOfLights  := area2perimeter(length);
                lights_num      <= numberOfLights;
                light_state     <= specialDecoder(numberOfLights);
            WHEN "1000" =>
                wshade          <= "0000";
                lights_num      <= user_light;
                light_state     <= SpecialDecoder(user_light);
            WHEN OTHERS =>
                wshade          <= "0000";
                lights_num      <= "0000";
                light_state     <= SpecialDecoder("0000");
        END CASE;
    END PROCESS;
END ARCHITECTURE;