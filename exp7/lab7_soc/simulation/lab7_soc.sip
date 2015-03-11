set_global_assignment -entity "lab7_soc" -library "lib_lab7_soc" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "lab7_soc" -library "lib_lab7_soc" -name IP_TOOL_VERSION "13.1"
set_global_assignment -entity "lab7_soc" -library "lib_lab7_soc" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_lab7_soc" -name SPD_FILE [file join $::quartus(sip_path) "../../lab7_soc.spd"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "../../lab7_soc.qsys"]

set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "lab7_soc.v"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/lab7_soc_sysid_qsys_0.vo"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/lab7_soc_sdram_pll.vo"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/lab7_soc_sdram.v"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/lab7_soc_led.v"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/lab7_soc_onchip_memory2_0.hex"]
set_global_assignment -library "lib_lab7_soc" -name MISC_FILE [file join $::quartus(sip_path) "submodules/lab7_soc_onchip_memory2_0.v"]
