transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
       

vlog     	../../src/mat_scan.v
vlog     	../../src/sram.v
vlog     	../../sim/tb_src/tb_mat_scan.v


set rnd_seed [clock seconds]

vsim -t 1ps -L rtl_work -L work +SEED=${rnd_seed} -voptargs="+acc"  tb_mat_scan

do wave.do

run -all
