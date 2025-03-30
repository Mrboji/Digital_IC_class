transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
       

vlog     	../../src/sqrt_u32.v
vlog     	../../sim/tb_src/tb_sqrt_u32.v


set rnd_seed [clock seconds]

vsim -t 1ps -L rtl_work -L work +SEED=${rnd_seed} -voptargs="+acc"  tb_sqrt_u32

do wave.do

run -all
