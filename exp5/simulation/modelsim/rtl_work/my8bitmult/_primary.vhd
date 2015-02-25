library verilog;
use verilog.vl_types.all;
entity my8bitmult is
    port(
        CLR_LDB         : in     vl_logic;
        Reset           : in     vl_logic;
        Run             : in     vl_logic;
        Clk             : in     vl_logic;
        Reset2          : in     vl_logic;
        Switches        : in     vl_logic_vector(7 downto 0)
    );
end my8bitmult;
