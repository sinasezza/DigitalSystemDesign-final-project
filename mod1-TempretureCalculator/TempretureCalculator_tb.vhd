LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY TemperatureCalculator_tb IS
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE test OF TemperatureCalculator_tb IS 

    COMPONENT TemperatureCalculator IS
        PORT (
            ref     : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
            base    : IN    STD_LOGIC_VECTOR(31 DOWNTO 0);
            abc_data: IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
            temp_c  : OUT   STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL ref      : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL base     : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL abc_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL temp_c   : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    uut : TemperatureCalculator PORT MAP(ref,base,abc_data,temp_c);

    ref       <= X"11" , X"12" AFTER 10 NS , X"55" AFTER 50 NS;
    base      <= X"123123AA" , X"AAAA0000" AFTER 70 NS;
    abc_data  <= X"FFFF" , X"0233" AFTER 30 NS;
END ARCHITECTURE;