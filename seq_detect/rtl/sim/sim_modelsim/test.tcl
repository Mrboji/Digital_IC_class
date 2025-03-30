transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
       

vlog     	../../src/seq_detect.v
vlog     	../../sim/tb_src/tb_seq_detect.v



set rnd_seed [clock seconds]

vsim -t 1ps -L rtl_work -L work +SEED=${rnd_seed} -voptargs="+acc" tb_seq_detect

do wave.do

run -all
