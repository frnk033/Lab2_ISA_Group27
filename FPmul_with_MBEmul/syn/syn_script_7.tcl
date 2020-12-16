#### SYNTHESIS #####

source synopsys_dc.setup

#  READING VHDL SOURCE FILES 
analyze -f vhdl -lib WORK ../common/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../common/fpround_fpround.vhd
analyze -f vhdl -lib WORK ../common/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../common/unpackfp_unpackfp.vhd
analyze -f vhdl -lib WORK ../multiplier/reg.vhd
analyze -f vhdl -lib WORK ../multiplier/FF.vhd
analyze -f vhdl -lib WORK ../multiplier/ha.vhd
analyze -f vhdl -lib WORK ../multiplier/FA.vhd
analyze -f vhdl -lib WORK ../multiplier/mux3to1.vhd
analyze -f vhdl -lib WORK ../multiplier/Dadda.vhd
analyze -f vhdl -lib WORK ../multiplier/RCA.vhd
analyze -f vhdl -lib WORK ../multiplier/part_prod_gen.vhd
analyze -f vhdl -lib WORK ../multiplier/MBE.vhd
analyze -f vhdl -lib WORK ../multiplier/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../multiplier/fpmul_stage2_struct_modified.vhd
analyze -f vhdl -lib WORK ../multiplier/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../multiplier/fpmul_stage4_struct.vhd
analyze -f vhdl -lib WORK ../multiplier/fpmul_pipeline.vhd

set power_preserve_rtl_hier_names true
elaborate FPmul -arch pipeline -lib WORK > ./elaborate.txt

# APPLYING CONSTRAINTS
create_clock -name MY_CLK -period 1.17 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]


# START THE SYNTHESIS
compile

#RECOMPLIE THE DESIGN PERFORMING RETIMING
optimize_registers

# SAVE THE RESULTS
report_timing > report_timing_7.txt
report_area > report_area_7.txt



