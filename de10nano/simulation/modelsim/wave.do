onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb/clk
add wave -noupdate -radix hexadecimal /tb/rstn
add wave -noupdate -radix hexadecimal /tb/leds
add wave -noupdate -radix ascii /tb/str
add wave -noupdate -divider {Inst Bus}
add wave -noupdate -label readdata -radix hexadecimal /tb/uut/rV_system/rv32i_core/avIB_readdata
add wave -noupdate -label address -radix hexadecimal /tb/uut/rV_system/rv32i_core/avIB_address
add wave -noupdate -label waitrequest -radix hexadecimal /tb/uut/rV_system/rv32i_core/avIB_waitrequest
add wave -noupdate -label read -radix hexadecimal /tb/uut/rV_system/rv32i_core/avIB_read
add wave -noupdate -divider {Data Bus}
add wave -noupdate -label address -radix hexadecimal /tb/uut/rV_system/rv32i_core/avDB_address
add wave -noupdate -label readdata -radix hexadecimal /tb/uut/rV_system/rv32i_core/avDB_readdata
add wave -noupdate -label read -radix hexadecimal /tb/uut/rV_system/rv32i_core/avDB_read
add wave -noupdate -label writedata -radix hexadecimal /tb/uut/rV_system/rv32i_core/avDB_writedata
add wave -noupdate -label byteenable -radix hexadecimal /tb/uut/rV_system/rv32i_core/avDB_byteenable
add wave -noupdate -label write -radix hexadecimal /tb/uut/rV_system/rv32i_core/avDB_write
add wave -noupdate -label waitrequest -radix hexadecimal /tb/uut/rV_system/rv32i_core/avDB_waitrequest
add wave -noupdate -divider WriteBack
add wave -noupdate -label rd -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/rdEx
add wave -noupdate -label valid -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/validEx
add wave -noupdate -label We -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/rdWeEx
add wave -noupdate -label Res -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/exRes
add wave -noupdate -label lEx /tb/uut/rV_system/rv32i_core/u_risac/lEx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1401188 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {719518 ps}
