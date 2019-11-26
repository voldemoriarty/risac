transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib soc_simple
vmap soc_simple soc_simple
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/soc_simple.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_2.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_1.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/risac.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/risac_avalon.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_on_chip_memory.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_leds.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_avalon_mm_bridge.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_jtag_uart.v}
vlog -vlog01compat -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_PLL_50_150.v}
vlog -vlog01compat -work work +incdir+/home/saad/trashcan/risac/de10nano/verilog {/home/saad/trashcan/risac/de10nano/verilog/de10nanoTop.v}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_merlin_master_translator.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_rsp_mux_001.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_rsp_demux_002.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_cmd_mux_002.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_cmd_demux_001.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_router_004.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_router_002.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_router_001.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/soc_simple_mm_interconnect_0_router.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work soc_simple +incdir+/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules {/home/saad/trashcan/risac/qsys_systems/soc_simple/synthesis/submodules/altera_merlin_master_agent.sv}

