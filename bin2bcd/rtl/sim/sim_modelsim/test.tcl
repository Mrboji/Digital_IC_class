transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
       

vlog     	../../src/bin2bcd.v
vlog     	../../sim/tb_src/tb_bin2bcd.v



set rnd_seed [clock seconds]

vsim -t 1ps -L rtl_work -L work +SEED=${rnd_seed} -voptargs="+acc" tb_bin2bcd

do wave.do

run -all
