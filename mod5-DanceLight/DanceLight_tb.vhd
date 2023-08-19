LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY DanceLight_tb IS
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE test OF DanceLight_tb IS

    COMPONENT DanceLight IS
        PORT (
            arst    : IN    STD_LOGIC;
            clk     : IN    STD_LOGIC;
            load    : IN    STD_LOGIC; 
            din     : IN    STD_LOGIC;
            p       : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
            q       : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL areset, clock , data_in , load : STD_LOGIC  := '0';
    SIGNAL P , Q : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    uut : DanceLight PORT MAP(areset,clock,load,data_in,P,Q);

    areset <= '1' , '0' AFTER 20 NS;
    load   <= '1' , '0' AFTER 35 NS;
    clock  <= NOT clock AFTER 10 NS;

    data_in <= '1' , '0' AFTER 60 NS;
    P <= "10101011","10101010" AFTER 10 NS;
END ARCHITECTURE;