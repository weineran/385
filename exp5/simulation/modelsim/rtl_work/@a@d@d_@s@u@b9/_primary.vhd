library verilog;
use verilog.vl_types.all;
entity ADD_SUB9 is
    port(
        A               : in     vl_logic_vector(7 downto 0);
        B               : in     vl_logic_vector(7 downto 0);
        fn              : in     vl_logic;
        S               : out    vl_logic_vector(8 downto 0)
    );
end ADD_SUB9;
