onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /risac_soc_tb/clk
add wave -noupdate /risac_soc_tb/rstn
add wave -noupdate -radix hexadecimal /risac_soc_tb/ledr
add wave -noupdate -divider -height 20 RV32_AV_IBUS
add wave -noupdate -label avIB_readdata -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/avIB_readdata
add wave -noupdate -label avIB_address -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/avIB_address
add wave -noupdate -label avIB_waitrequest -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/avIB_waitrequest
add wave -noupdate -label avIB_read /risac_soc_tb/uut/soc_system/rv32i_core/avIB_read
add wave -noupdate -divider -height 20 RV32_AV_DBUS
add wave -noupdate -label avDB_address -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/avDB_address
add wave -noupdate -label avDB_readdata -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/avDB_readdata
add wave -noupdate -label avDB_read /risac_soc_tb/uut/soc_system/rv32i_core/avDB_read
add wave -noupdate -label avDB_writedata -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/avDB_writedata
add wave -noupdate -label avDB_byteenable -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/avDB_byteenable
add wave -noupdate -label avDB_write /risac_soc_tb/uut/soc_system/rv32i_core/avDB_write
add wave -noupdate -label avDB_waitrequest /risac_soc_tb/uut/soc_system/rv32i_core/avDB_waitrequest
add wave -noupdate -divider -height 20 RV32
add wave -noupdate -label pc -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/u_risac/pc
add wave -noupdate -label iIbusWait /risac_soc_tb/uut/soc_system/rv32i_core/u_risac/iIbusWait
add wave -noupdate -label stallPipe /risac_soc_tb/uut/soc_system/rv32i_core/u_risac/stallPipe
add wave -noupdate -label dataHazard /risac_soc_tb/uut/soc_system/rv32i_core/u_risac/dataHazard
add wave -noupdate -label lsuAddrOs -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/u_risac/lsuAddrOs
add wave -noupdate -label rs1Data -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/u_risac/rs1Data
add wave -noupdate -label rs2Data -radix hexadecimal /risac_soc_tb/uut/soc_system/rv32i_core/u_risac/rs2Data
add wave -noupdate -label pcChanged /risac_soc_tb/uut/soc_system/rv32i_core/u_risac/pcChanged
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {542771 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 192
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {471580 ps}
