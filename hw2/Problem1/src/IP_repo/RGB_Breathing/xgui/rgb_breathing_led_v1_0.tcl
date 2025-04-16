# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "COLOR1_B" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR1_G" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR1_R" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR2_B" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR2_G" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR2_R" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR3_B" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR3_G" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR3_R" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR4_B" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR4_G" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLOR4_R" -parent ${Page_0}


}

proc update_PARAM_VALUE.COLOR1_B { PARAM_VALUE.COLOR1_B } {
	# Procedure called to update COLOR1_B when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR1_B { PARAM_VALUE.COLOR1_B } {
	# Procedure called to validate COLOR1_B
	return true
}

proc update_PARAM_VALUE.COLOR1_G { PARAM_VALUE.COLOR1_G } {
	# Procedure called to update COLOR1_G when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR1_G { PARAM_VALUE.COLOR1_G } {
	# Procedure called to validate COLOR1_G
	return true
}

proc update_PARAM_VALUE.COLOR1_R { PARAM_VALUE.COLOR1_R } {
	# Procedure called to update COLOR1_R when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR1_R { PARAM_VALUE.COLOR1_R } {
	# Procedure called to validate COLOR1_R
	return true
}

proc update_PARAM_VALUE.COLOR2_B { PARAM_VALUE.COLOR2_B } {
	# Procedure called to update COLOR2_B when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR2_B { PARAM_VALUE.COLOR2_B } {
	# Procedure called to validate COLOR2_B
	return true
}

proc update_PARAM_VALUE.COLOR2_G { PARAM_VALUE.COLOR2_G } {
	# Procedure called to update COLOR2_G when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR2_G { PARAM_VALUE.COLOR2_G } {
	# Procedure called to validate COLOR2_G
	return true
}

proc update_PARAM_VALUE.COLOR2_R { PARAM_VALUE.COLOR2_R } {
	# Procedure called to update COLOR2_R when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR2_R { PARAM_VALUE.COLOR2_R } {
	# Procedure called to validate COLOR2_R
	return true
}

proc update_PARAM_VALUE.COLOR3_B { PARAM_VALUE.COLOR3_B } {
	# Procedure called to update COLOR3_B when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR3_B { PARAM_VALUE.COLOR3_B } {
	# Procedure called to validate COLOR3_B
	return true
}

proc update_PARAM_VALUE.COLOR3_G { PARAM_VALUE.COLOR3_G } {
	# Procedure called to update COLOR3_G when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR3_G { PARAM_VALUE.COLOR3_G } {
	# Procedure called to validate COLOR3_G
	return true
}

proc update_PARAM_VALUE.COLOR3_R { PARAM_VALUE.COLOR3_R } {
	# Procedure called to update COLOR3_R when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR3_R { PARAM_VALUE.COLOR3_R } {
	# Procedure called to validate COLOR3_R
	return true
}

proc update_PARAM_VALUE.COLOR4_B { PARAM_VALUE.COLOR4_B } {
	# Procedure called to update COLOR4_B when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR4_B { PARAM_VALUE.COLOR4_B } {
	# Procedure called to validate COLOR4_B
	return true
}

proc update_PARAM_VALUE.COLOR4_G { PARAM_VALUE.COLOR4_G } {
	# Procedure called to update COLOR4_G when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR4_G { PARAM_VALUE.COLOR4_G } {
	# Procedure called to validate COLOR4_G
	return true
}

proc update_PARAM_VALUE.COLOR4_R { PARAM_VALUE.COLOR4_R } {
	# Procedure called to update COLOR4_R when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR4_R { PARAM_VALUE.COLOR4_R } {
	# Procedure called to validate COLOR4_R
	return true
}


proc update_MODELPARAM_VALUE.COLOR1_R { MODELPARAM_VALUE.COLOR1_R PARAM_VALUE.COLOR1_R } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR1_R}] ${MODELPARAM_VALUE.COLOR1_R}
}

proc update_MODELPARAM_VALUE.COLOR1_G { MODELPARAM_VALUE.COLOR1_G PARAM_VALUE.COLOR1_G } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR1_G}] ${MODELPARAM_VALUE.COLOR1_G}
}

proc update_MODELPARAM_VALUE.COLOR1_B { MODELPARAM_VALUE.COLOR1_B PARAM_VALUE.COLOR1_B } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR1_B}] ${MODELPARAM_VALUE.COLOR1_B}
}

proc update_MODELPARAM_VALUE.COLOR2_R { MODELPARAM_VALUE.COLOR2_R PARAM_VALUE.COLOR2_R } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR2_R}] ${MODELPARAM_VALUE.COLOR2_R}
}

proc update_MODELPARAM_VALUE.COLOR2_G { MODELPARAM_VALUE.COLOR2_G PARAM_VALUE.COLOR2_G } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR2_G}] ${MODELPARAM_VALUE.COLOR2_G}
}

proc update_MODELPARAM_VALUE.COLOR2_B { MODELPARAM_VALUE.COLOR2_B PARAM_VALUE.COLOR2_B } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR2_B}] ${MODELPARAM_VALUE.COLOR2_B}
}

proc update_MODELPARAM_VALUE.COLOR3_R { MODELPARAM_VALUE.COLOR3_R PARAM_VALUE.COLOR3_R } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR3_R}] ${MODELPARAM_VALUE.COLOR3_R}
}

proc update_MODELPARAM_VALUE.COLOR3_G { MODELPARAM_VALUE.COLOR3_G PARAM_VALUE.COLOR3_G } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR3_G}] ${MODELPARAM_VALUE.COLOR3_G}
}

proc update_MODELPARAM_VALUE.COLOR3_B { MODELPARAM_VALUE.COLOR3_B PARAM_VALUE.COLOR3_B } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR3_B}] ${MODELPARAM_VALUE.COLOR3_B}
}

proc update_MODELPARAM_VALUE.COLOR4_R { MODELPARAM_VALUE.COLOR4_R PARAM_VALUE.COLOR4_R } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR4_R}] ${MODELPARAM_VALUE.COLOR4_R}
}

proc update_MODELPARAM_VALUE.COLOR4_G { MODELPARAM_VALUE.COLOR4_G PARAM_VALUE.COLOR4_G } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR4_G}] ${MODELPARAM_VALUE.COLOR4_G}
}

proc update_MODELPARAM_VALUE.COLOR4_B { MODELPARAM_VALUE.COLOR4_B PARAM_VALUE.COLOR4_B } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR4_B}] ${MODELPARAM_VALUE.COLOR4_B}
}

