onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/MASTER/HCLK
add wave -noupdate /top/MASTER/HRESETn
add wave -noupdate /top/MASTER/HREADYout
add wave -noupdate /top/MASTER/HRESP
add wave -noupdate /top/MASTER/HRDATA
add wave -noupdate /top/MASTER/HREADYin
add wave -noupdate /top/MASTER/HWRITE
add wave -noupdate /top/MASTER/HWDATA
add wave -noupdate /top/MASTER/HADDR
add wave -noupdate /top/MASTER/PRDATA
add wave -noupdate /top/MASTER/HADDRreg
add wave -noupdate /top/MASTER/HSIZE
add wave -noupdate /top/MASTER/HTRANS
add wave -noupdate /top/MASTER/HBURST
add wave -noupdate /top/SLAVE/PENABLE
add wave -noupdate /top/SLAVE/PWRITE
add wave -noupdate /top/SLAVE/PSEL
add wave -noupdate /top/SLAVE/PADDR
add wave -noupdate /top/SLAVE/PRDATA
add wave -noupdate /top/SLAVE/HWDATA
add wave -noupdate /top/SLAVE/PWDATA
add wave -noupdate /top/SLAVE/HRDATA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {160 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 113
configure wave -valuecolwidth 167
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {244 ps}
