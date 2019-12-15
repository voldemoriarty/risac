onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb/clk
add wave -noupdate -radix hexadecimal /tb/rstn
add wave -noupdate -radix ascii /tb/str
add wave -noupdate -divider CSR_Dec
add wave -noupdate -label csrReadDec -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/csrReadDec
add wave -noupdate -label csrWriteDec -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/csrWriteDec
add wave -noupdate -label csrSetDec -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/csrSetDec
add wave -noupdate -label csrClrDec -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/csrClrDec
add wave -noupdate -label csrImmSel -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/csrImmSelDec
add wave -noupdate -label csrAddrDec -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/csrAddrDec
add wave -noupdate -label csrRs1Need -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/csrRs1Need
add wave -noupdate -label csrDec -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/csrDec
add wave -noupdate -divider CSR_Unit
add wave -noupdate -label addr -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/addr
add wave -noupdate -label write -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/write
add wave -noupdate -label clr -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/clr
add wave -noupdate -label read /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/read
add wave -noupdate -label set -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/set
add wave -noupdate -label wdata -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/wdata
add wave -noupdate -label rdata -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/rdata
add wave -noupdate -divider CSR
add wave -noupdate -label mepc -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/_mepc
add wave -noupdate -label mcause -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/_mcause
add wave -noupdate -label mtvec -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/_mtvec
add wave -noupdate -label mie -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/_mie
add wave -noupdate -label mip -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/u_csr_unit/_mip
add wave -noupdate -divider {Inst Bus}
add wave -noupdate -label readdata -radix hexadecimal /tb/uut/rV_system/rv32i_core/avIB_readdata
add wave -noupdate -label address -radix hexadecimal /tb/uut/rV_system/rv32i_core/avIB_address
add wave -noupdate -label waitrequest -radix hexadecimal /tb/uut/rV_system/rv32i_core/avIB_waitrequest
add wave -noupdate -label read -radix hexadecimal /tb/uut/rV_system/rv32i_core/avIB_read
add wave -noupdate -label bT2 -radix hexadecimal /tb/uut/rV_system/rv32i_core/u_risac/branchTarget2
add wave -noupdate -label u2 /tb/uut/rV_system/rv32i_core/u_risac/use2
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
add wave -noupdate -divider Dec
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9590000 ps} 0}
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
WaveRestoreZoom {29316458 ps} {30035976 ps}
