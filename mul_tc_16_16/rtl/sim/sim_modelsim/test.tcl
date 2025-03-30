transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
       

vlog     	../../src/mul_tc_16_16.v
vlog     	../../src/partial_prod_gen.v
vlog     	../../src/wallace_tree.v
vlog     	../../sim/tb_src/tb_mul_tc_16_16.v


set rnd_seed [clock seconds]

vsim -t 1ps -L rtl_work -L work +SEED=${rnd_seed} -voptargs="+acc"  tb_mul_tc_16_16

do wave.do

run -all
