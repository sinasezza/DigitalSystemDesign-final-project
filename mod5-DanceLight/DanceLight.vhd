LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY DanceLight IS
    PORT (
        arst    : IN    STD_LOGIC;
        clk     : IN    STD_LOGIC;
        load    : IN    STD_LOGIC; 
        din     : IN    STD_LOGIC;
        p       : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
        q       : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;


-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE structural OF DanceLight IS

    COMPONENT DFlop IS
        PORT (
            arst  : IN  STD_LOGIC;  -- async reset
            clk   : IN  STD_LOGIC;  -- clock posedge
            Pin   : IN  STD_LOGIC;  -- data load 
            din   : IN  STD_LOGIC;  -- data in
            load  : IN STD_LOGIC;   -- load in
            qout  : OUT STD_LOGIC   -- q out
        );
    END COMPONENT;

    SIGNAL p_in  : STD_LOGIC_VECTOR(7 DOWNTO 0) := p;
    SIGNAL q_out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL d_out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

    --------------------------------

BEGIN
    p_in  <= p;

    generator0 : FOR i IN 0 TO 7 GENERATE
        generator1 : IF (i=0 OR i=1 OR i=4 OR i=5) GENERATE
            middleGen : DFlop PORT MAP(arst,clk,p_in(i),(q_out(0) XOR q_out(i+1)), load ,q_out(i));
        END GENERATE;

        generator2 : IF (i=2 OR i=3 OR i=6) GENERATE
            genDFlop : DFlop  PORT MAP(arst,clk,p_in(i),q_out(i+1), load ,q_out(i));
        END GENERATE;

        generator3 : IF (i=7) GENERATE
            lastGent : DFlop  PORT MAP(arst,clk,p_in(i),(q_out(0) XOR din), load ,q_out(i));
        END GENERATE;
    END GENERATE;

    q  <= q_out;

END ARCHITECTURE;