transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
       

vlog     	../../src/ahb_slave_if.v
vlog     	../../src/ahb_sram_top.v
vlog     	../../src/sram.v
vlog     	../../sim/tb_src/tb_ahb_sram.v


set rnd_seed [clock seconds]

vsim -t 1ps -L rtl_work -L work +SEED=${rnd_seed} -voptargs="+acc"  tb_ahb_sram

do wave.do

run -all
