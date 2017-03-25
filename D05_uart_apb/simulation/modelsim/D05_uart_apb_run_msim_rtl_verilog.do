transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/kjlee/study/soc/D05_uart_apb {/home/kjlee/study/soc/D05_uart_apb/D05_uart_apb.v}

vlog -vlog01compat -work work +incdir+/home/kjlee/study/soc/D05_uart_apb/rtl_sim/model {/home/kjlee/study/soc/D05_uart_apb/rtl_sim/model/sg_uart_tx.v}
vlog -vlog01compat -work work +incdir+/home/kjlee/study/soc/D05_uart_apb/verilog {/home/kjlee/study/soc/D05_uart_apb/verilog/cmsdk_apb_uart.v}
vlog -vlog01compat -work work +incdir+/home/kjlee/study/soc/D05_uart_apb/rtl_sim/model {/home/kjlee/study/soc/D05_uart_apb/rtl_sim/model/cmsdk_clkreset.v}
vlog -vlog01compat -work work +incdir+/home/kjlee/study/soc/D05_uart_apb/rtl_sim/model {/home/kjlee/study/soc/D05_uart_apb/rtl_sim/model/sg_uart_rx.v}
vlog -vlog01compat -work work +incdir+/home/kjlee/study/soc/D05_uart_apb/rtl_sim/model {/home/kjlee/study/soc/D05_uart_apb/rtl_sim/model/sg_uart_rx_check.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_uart_tx

add wave *
view structure
view signals
run -all
