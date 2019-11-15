transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/sources {/home/saad/trashcan/velox/risac_soc/sources/risac_soc.v}
vlib risac_soc_system
vmap risac_soc_system risac_soc_system
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/risac_soc_system.v}
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_uart_0.v}
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_LEDR.v}
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_Memory.v}
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac.v}
vlog -vlog01compat -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_avalon.v}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_rsp_xbar_mux_001.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_rsp_xbar_demux.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_cmd_xbar_mux.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_cmd_xbar_demux_001.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_cmd_xbar_demux.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_id_router_001.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_id_router.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_addr_router_001.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_addr_router.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work risac_soc_system +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_master_translator.sv}

vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/risac_soc_system.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_avalon_st_handshake_clock_crosser.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_avalon_st_pipeline_base.v}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_master_translator.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_avalon.v}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_addr_router.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_addr_router_001.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_cmd_xbar_demux.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_cmd_xbar_demux_001.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_cmd_xbar_mux.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_id_router.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_id_router_001.sv}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_LEDR.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_Memory.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_PLL.v}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_rsp_xbar_demux.sv}
vlog -sv -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_rsp_xbar_mux_001.sv}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules {/home/saad/trashcan/velox/risac_soc/risac_soc_system/synthesis/submodules/risac_soc_system_uart_0.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/velox/risac_soc/sources {/home/saad/trashcan/velox/risac_soc/sources/risac_soc.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -L risac_soc_system -voptargs="+acc"  risac_soc_tb

add wave *
view structure
view signals
run -all
