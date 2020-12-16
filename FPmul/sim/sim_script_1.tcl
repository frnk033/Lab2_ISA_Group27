##########SIMULATION#################

source init_msim6.2g

vlib work

vcom -93 -work ./work ../common/fpnormalize_fpnormalize.vhd
vcom -93 -work ./work ../common/fpround_fpround.vhd
vcom -93 -work ./work ../common/packfp_packfp.vhd
vcom -93 -work ./work ../common/unpackfp_unpackfp.vhd


vcom -93 -work ./work ../multiplier/reg.vhd
vcom -93 -work ./work ../multiplier/fpmul_stage1_struct.vhd
vcom -93 -work ./work ../multiplier/fpmul_stage2_struct.vhd
vcom -93 -work ./work ../multiplier/fpmul_stage3_struct.vhd
vcom -93 -work ./work ../multiplier/fpmul_stage4_struct.vhd
vcom -93 -work ./work ../multiplier/fpmul_pipeline.vhd

vcom -93 -work ./work ../tb/data_maker.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vcom -93 -work ./work ../tb/clk_gen.vhd

vlog -work ./work ../tb/tb_mul.v

vsim &


