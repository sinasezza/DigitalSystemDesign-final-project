LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Memory_tb IS 
END ENTITY;

-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE test OF Memory_tb IS

    COMPONENT Memory IS
        PORT (
            arst    : IN    STD_LOGIC;
            clk     : IN    STD_LOGIC;
            mem_in  : IN    STD_LOGIC_VECTOR(34 DOWNTO 0);
            mem_out : OUT   STD_LOGIC_VECTOR(34 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL areset , clock : STD_LOGIC := '0';
    signal memory_in , memory_out : STD_LOGIC_VECTOR(34 DOWNTO 0);
BEGIN

    uut : Memory PORT MAP(areset,clock,memory_in,memory_out);

    areset      <= '1' , '0' AFTER 10 NS;
    clock       <= NOT clock AFTER 10 NS;
    memory_in   <= X"AAABBBCC"&"111" , X"CDCDAAAA"&"000" AFTER 40 NS;
END ARCHITECTURE;