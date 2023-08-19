LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CheckPassword_tb IS
END ENTITY;


-----------------------------------------------------------
-----------------------------------------------------------

ARCHITECTURE test OF CheckPassword_tb IS

    COMPONENT CheckPassword IS
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
    END COMPONENT;

    SIGNAL areset , clock , request  : STD_LOGIC := '0';
    SIGNAL main_pass , password : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL confirm : STD_LOGIC;
    SIGNAL din , dout : STD_LOGIC_VECTOR(34 DOWNTO 0) := (OTHERS => '0');

BEGIN
    uut : CheckPassword PORT MAP(areset,clock,request,main_pass,password,confirm,din,dout);

    areset    <= '1' , '0' AFTER 20 NS;
    clock     <= NOT clock AFTER 5 NS;
    request   <= '0' , '1' AFTER 40 NS , '0' AFTER 190 NS;
    main_pass <= "10" , "11" AFTER 80 NS;
    password  <= "01" , "00" AFTER 25 NS , "10" AFTER 50 NS , "11" AFTER 70 NS;
    confirm   <= '0', '1' AFTER 60 NS , '0' AFTER 70 NS , '1' AFTER 80 NS , '0' AFTER 105 NS , '1' AFTER 120 NS;

    din <= X"ABABAAAA"&"111" , X"11110000"&"111" AFTER 64 NS;

END ARCHITECTURE;