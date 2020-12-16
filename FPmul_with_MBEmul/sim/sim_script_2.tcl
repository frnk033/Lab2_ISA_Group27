##########SIMULATION#################

source init_msim6.2g

vlib work

vcom -93 -work ./work ../common/fpnormalize_fpnormalize.vhd
vcom -93 -work ./work ../common/fpround_fpround.vhd
vcom -93 -work ./work ../common/packfp_packfp.vhd
vcom -93 -work ./work ../common/unpackfp_unpackfp.vhd

vcom -93 -work ./work ../multiplier/ha.vhd
vcom -93 -work ./work ../multiplier/FA.vhd
vcom -93 -work ./work ../multiplier/mux3to1.vhd
vcom -93 -work ./work ../multiplier/reg.vhd
vcom -93 -work ./work ../multiplier/FF.vhd
vcom -93 -work ./work ../multiplier/RCA.vhd
vcom -93 -work ./work ../multiplier/part_prod_gen.vhd
vcom -93 -work ./work ../multiplier/Dadda.vhd
vcom -93 -work ./work ../multiplier/MBE.vhd
vcom -93 -work ./work ../multiplier/fpmul_stage1_struct.vhd
vcom -93 -work ./work ../multiplier/fpmul_stage2_struct_modified.vhd
vcom -93 -work ./work ../multiplier/fpmul_stage3_struct.vhd
vcom -93 -work ./work ../multiplier/fpmul_stage4_struct.vhd
vcom -93 -work ./work ../multiplier/fpmul_pipeline.vhd

vcom -93 -work ./work ../tb/data_maker_2.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vcom -93 -work ./work ../tb/clk_gen.vhd

vlog -work ./work ../tb/tb_mul.v

#vsim &


