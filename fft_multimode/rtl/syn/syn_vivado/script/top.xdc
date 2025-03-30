create_clock -period 10 -name clk [get_ports hclk]
set_false_path -from [get_ports hresetn]


