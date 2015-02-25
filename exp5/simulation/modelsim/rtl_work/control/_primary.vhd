library verilog;
use verilog.vl_types.all;
entity control is
    port(
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        Run             : in     vl_logic;
        ClearA_LoadB    : in     vl_logic;
        M               : in     vl_logic;
        AhexU           : out    vl_logic_vector(6 downto 0);
        AhexL           : out    vl_logic_vector(6 downto 0);
        BhexU           : out    vl_logic_vector(6 downto 0);
        Aval            : out    vl_logic_vector(7 downto 0);
        Bval            : out    vl_logic_vector(7 downto 0);
        X               : out    vl_logic;
        Clr_ld          : out    vl_logic;
        Shift           : out    vl_logic;
        Add             : out    vl_logic;
        Sub             : out    vl_logic
    );
end control;
