-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat Feb 22 05:21:55 2025
-- Host        : DESKTOP-37A9H0N running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               f:/A_my_project/FPGA/Digital_IC_class/fft_multimode/rtl/syn/syn_vivado/fft_multimode.srcs/sources_1/ip/mult_16x16bit/mult_16x16bit_stub.vhdl
-- Design      : mult_16x16bit
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mult_16x16bit is
  Port ( 
    A : in STD_LOGIC_VECTOR ( 15 downto 0 );
    B : in STD_LOGIC_VECTOR ( 15 downto 0 );
    P : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end mult_16x16bit;

architecture stub of mult_16x16bit is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "A[15:0],B[15:0],P[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "mult_gen_v12_0_14,Vivado 2018.3";
begin
end;
