onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/rstn
add wave -noupdate /tb/ledg
add wave -noupdate -radix ascii /tb/str
add wave -noupdate -divider -height 18 AV_IB
add wave -noupdate -label data -radix hexadecimal /tb/uut/u0/rv32i_core/avIB_readdata
add wave -noupdate -label address -radix hexadecimal /tb/uut/u0/rv32i_core/avIB_address
add wave -noupdate -label waitrequest -radix hexadecimal /tb/uut/u0/rv32i_core/avIB_waitrequest
add wave -noupdate -label read -radix hexadecimal /tb/uut/u0/rv32i_core/avIB_read
add wave -noupdate -label wr_negedge /tb/uut/u0/rv32i_core/wr_negedge
add wave -noupdate -divider -height 18 IBUS
add wave -noupdate -label addr -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/oIbusAddr
add wave -noupdate -label data -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/iIbusData
add wave -noupdate -label iaddr -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/iIbusIAddr
add wave -noupdate -label wait -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/iIbusWait
add wave -noupdate -label read -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/oIbusRead
add wave -noupdate -divider -height 18 DBUS
add wave -noupdate -label addr -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/oDbusAddr
add wave -noupdate -label we -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/oDbusWe
add wave -noupdate -label data -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/oDbusData
add wave -noupdate -label read -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/oDbusRead
add wave -noupdate -label byteen -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/oDbusByteEn
add wave -noupdate -label data -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/iDbusData
add wave -noupdate -label wait -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/iDbusWait
add wave -noupdate -divider -height 18 WB
add wave -noupdate -label we -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/rdWeEx
add wave -noupdate -label valid -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/validEx
add wave -noupdate -label rd -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/rdEx
add wave -noupdate -label data -radix hexadecimal /tb/uut/u0/rv32i_core/u_risac/exRes
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199990 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {128820 ps} {384820 ps}
