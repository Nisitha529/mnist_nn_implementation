# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATAWIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L1_NUM_INPUTS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L1_NUM_NEURONS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L2_NUM_INPUTS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L2_NUM_NEURONS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L3_NUM_INPUTS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L3_NUM_NEURONS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L4_NUM_INPUTS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L4_NUM_NEURONS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WEIGHTINTWIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DATAWIDTH { PARAM_VALUE.DATAWIDTH } {
	# Procedure called to update DATAWIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATAWIDTH { PARAM_VALUE.DATAWIDTH } {
	# Procedure called to validate DATAWIDTH
	return true
}

proc update_PARAM_VALUE.L1_NUM_INPUTS { PARAM_VALUE.L1_NUM_INPUTS } {
	# Procedure called to update L1_NUM_INPUTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L1_NUM_INPUTS { PARAM_VALUE.L1_NUM_INPUTS } {
	# Procedure called to validate L1_NUM_INPUTS
	return true
}

proc update_PARAM_VALUE.L1_NUM_NEURONS { PARAM_VALUE.L1_NUM_NEURONS } {
	# Procedure called to update L1_NUM_NEURONS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L1_NUM_NEURONS { PARAM_VALUE.L1_NUM_NEURONS } {
	# Procedure called to validate L1_NUM_NEURONS
	return true
}

proc update_PARAM_VALUE.L2_NUM_INPUTS { PARAM_VALUE.L2_NUM_INPUTS } {
	# Procedure called to update L2_NUM_INPUTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L2_NUM_INPUTS { PARAM_VALUE.L2_NUM_INPUTS } {
	# Procedure called to validate L2_NUM_INPUTS
	return true
}

proc update_PARAM_VALUE.L2_NUM_NEURONS { PARAM_VALUE.L2_NUM_NEURONS } {
	# Procedure called to update L2_NUM_NEURONS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L2_NUM_NEURONS { PARAM_VALUE.L2_NUM_NEURONS } {
	# Procedure called to validate L2_NUM_NEURONS
	return true
}

proc update_PARAM_VALUE.L3_NUM_INPUTS { PARAM_VALUE.L3_NUM_INPUTS } {
	# Procedure called to update L3_NUM_INPUTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L3_NUM_INPUTS { PARAM_VALUE.L3_NUM_INPUTS } {
	# Procedure called to validate L3_NUM_INPUTS
	return true
}

proc update_PARAM_VALUE.L3_NUM_NEURONS { PARAM_VALUE.L3_NUM_NEURONS } {
	# Procedure called to update L3_NUM_NEURONS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L3_NUM_NEURONS { PARAM_VALUE.L3_NUM_NEURONS } {
	# Procedure called to validate L3_NUM_NEURONS
	return true
}

proc update_PARAM_VALUE.L4_NUM_INPUTS { PARAM_VALUE.L4_NUM_INPUTS } {
	# Procedure called to update L4_NUM_INPUTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L4_NUM_INPUTS { PARAM_VALUE.L4_NUM_INPUTS } {
	# Procedure called to validate L4_NUM_INPUTS
	return true
}

proc update_PARAM_VALUE.L4_NUM_NEURONS { PARAM_VALUE.L4_NUM_NEURONS } {
	# Procedure called to update L4_NUM_NEURONS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L4_NUM_NEURONS { PARAM_VALUE.L4_NUM_NEURONS } {
	# Procedure called to validate L4_NUM_NEURONS
	return true
}

proc update_PARAM_VALUE.WEIGHTINTWIDTH { PARAM_VALUE.WEIGHTINTWIDTH } {
	# Procedure called to update WEIGHTINTWIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WEIGHTINTWIDTH { PARAM_VALUE.WEIGHTINTWIDTH } {
	# Procedure called to validate WEIGHTINTWIDTH
	return true
}


proc update_MODELPARAM_VALUE.DATAWIDTH { MODELPARAM_VALUE.DATAWIDTH PARAM_VALUE.DATAWIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATAWIDTH}] ${MODELPARAM_VALUE.DATAWIDTH}
}

proc update_MODELPARAM_VALUE.L1_NUM_NEURONS { MODELPARAM_VALUE.L1_NUM_NEURONS PARAM_VALUE.L1_NUM_NEURONS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L1_NUM_NEURONS}] ${MODELPARAM_VALUE.L1_NUM_NEURONS}
}

proc update_MODELPARAM_VALUE.L1_NUM_INPUTS { MODELPARAM_VALUE.L1_NUM_INPUTS PARAM_VALUE.L1_NUM_INPUTS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L1_NUM_INPUTS}] ${MODELPARAM_VALUE.L1_NUM_INPUTS}
}

proc update_MODELPARAM_VALUE.L2_NUM_NEURONS { MODELPARAM_VALUE.L2_NUM_NEURONS PARAM_VALUE.L2_NUM_NEURONS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L2_NUM_NEURONS}] ${MODELPARAM_VALUE.L2_NUM_NEURONS}
}

proc update_MODELPARAM_VALUE.L2_NUM_INPUTS { MODELPARAM_VALUE.L2_NUM_INPUTS PARAM_VALUE.L2_NUM_INPUTS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L2_NUM_INPUTS}] ${MODELPARAM_VALUE.L2_NUM_INPUTS}
}

proc update_MODELPARAM_VALUE.L3_NUM_NEURONS { MODELPARAM_VALUE.L3_NUM_NEURONS PARAM_VALUE.L3_NUM_NEURONS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L3_NUM_NEURONS}] ${MODELPARAM_VALUE.L3_NUM_NEURONS}
}

proc update_MODELPARAM_VALUE.L3_NUM_INPUTS { MODELPARAM_VALUE.L3_NUM_INPUTS PARAM_VALUE.L3_NUM_INPUTS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L3_NUM_INPUTS}] ${MODELPARAM_VALUE.L3_NUM_INPUTS}
}

proc update_MODELPARAM_VALUE.L4_NUM_NEURONS { MODELPARAM_VALUE.L4_NUM_NEURONS PARAM_VALUE.L4_NUM_NEURONS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L4_NUM_NEURONS}] ${MODELPARAM_VALUE.L4_NUM_NEURONS}
}

proc update_MODELPARAM_VALUE.L4_NUM_INPUTS { MODELPARAM_VALUE.L4_NUM_INPUTS PARAM_VALUE.L4_NUM_INPUTS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L4_NUM_INPUTS}] ${MODELPARAM_VALUE.L4_NUM_INPUTS}
}

proc update_MODELPARAM_VALUE.WEIGHTINTWIDTH { MODELPARAM_VALUE.WEIGHTINTWIDTH PARAM_VALUE.WEIGHTINTWIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WEIGHTINTWIDTH}] ${MODELPARAM_VALUE.WEIGHTINTWIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

