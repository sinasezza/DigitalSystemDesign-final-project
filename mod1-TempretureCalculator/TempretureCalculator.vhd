LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


ENTITY TemperatureCalculator IS
    PORT (
        ref     : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
        base    : IN    STD_LOGIC_VECTOR(31 DOWNTO 0);
        abc_data: IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
        temp_c  : OUT   STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE dataFlow OF TemperatureCalculator IS 

    FUNCTION make_ref_squared(ref_in : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE ref_signed_in  : SIGNED(7 DOWNTO 0);
        VARIABLE ref_signed_out : SIGNED(15 DOWNTO 0);
        VARIABLE ref_squared    : STD_LOGIC_VECTOR(15 DOWNTO 0);
    BEGIN
        ref_signed_in   := to_signed(to_integer(signed(ref_in)), 8);
        ref_signed_out  := ref_signed_in * ref_signed_in;
        ref_squared     := std_logic_vector(ref_signed_out);

        RETURN ref_squared;
    END FUNCTION make_ref_squared;

    ---------------------------

    FUNCTION multiply_abcData_in_ref_squared(ref_squared , abcData : STD_LOGIC_VECTOR(15 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE signed_ref , signed_abcData : SIGNED(15 DOWNTO 0);
        VARIABLE multiply_out   : STD_LOGIC_VECTOR(31 DOWNTO 0);
    BEGIN
        signed_ref := signed(ref_squared);

        IF(abcData(15) = '1') THEN
            signed_abcData := signed(NOT abcData) + 1;
        ELSE
            signed_abcData := signed(abcData);
        END IF;

        multiply_out := std_logic_vector(signed_ref * signed_abcData);

        return multiply_out;
    END FUNCTION multiply_abcData_in_ref_squared;

    ---------------------------

    FUNCTION add_sub_32bit(base_in , ref2XabcData : STD_LOGIC_VECTOR(31 DOWNTO 0);mode : STD_LOGIC_VECTOR(15 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE signed_base  : SIGNED(31 DOWNTO 0) := signed(base_in);
        VARIABLE signedMult32 : SIGNED(31 DOWNTO 0) := signed(unsigned(ref2XabcData)/64);
        VARIABLE result       : STD_LOGIC_VECTOR(31 DOWNTO 0);
    BEGIN
        IF(mode(15) = '0') THEN
                result := std_logic_vector(signed_base + signedMult32);
        ELSE
                result := std_logic_vector(signed_base - signedMult32);
        END IF;

        RETURN result;
    END FUNCTION add_sub_32bit;

    ---------------------------

    SIGNAL mult_8x8_out     : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL mult_16x16_out   : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    mult_8x8_out    <= make_ref_squared(ref);
    mult_16x16_out  <= multiply_abcData_in_ref_squared(mult_8x8_out,abc_data);
    temp_c          <= add_sub_32bit(base,mult_16x16_out,abc_data);

END ARCHITECTURE;