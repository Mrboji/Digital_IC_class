transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
       

vlog     	../../src/cnt.v
vlog     	../../sim/tb_src/tb_cnt.v


set rnd_seed [clock seconds]

vsim -t 1ps -L rtl_work -L work +SEED=${rnd_seed} -voptargs="+acc"  tb_cnt

do wave.do

run -all
