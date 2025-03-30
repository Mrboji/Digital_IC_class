transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
       

vlog     	../../src/bsh_32.v
vlog     	../../sim/tb_src/tb_bsh_32.v


set rnd_seed [clock seconds]

vsim -t 1ps -L rtl_work -L work +SEED=${rnd_seed} -voptargs="+acc"  tb_bsh_32

do wave.do

run -all
