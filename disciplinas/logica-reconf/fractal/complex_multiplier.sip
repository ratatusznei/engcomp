set_global_assignment -entity "complex_multiplier" -library "lib_complex_multiplier" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "complex_multiplier" -library "lib_complex_multiplier" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "complex_multiplier" -library "lib_complex_multiplier" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_complex_multiplier" -name SPD_FILE [file join $::quartus(sip_path) "complex_multiplier.spd"]

set_global_assignment -library "lib_complex_multiplier" -name MISC_FILE [file join $::quartus(sip_path) "complex_multiplier_sim/dspba_library_package.vhd"]
set_global_assignment -library "lib_complex_multiplier" -name MISC_FILE [file join $::quartus(sip_path) "complex_multiplier_sim/dspba_library.vhd"]
set_global_assignment -library "lib_complex_multiplier" -name MISC_FILE [file join $::quartus(sip_path) "complex_multiplier_sim/complex_multiplier.vhd"]
