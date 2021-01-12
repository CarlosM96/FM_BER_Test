#-------------------------------------------------------------
# Generated Example Tcl script for IP 'TX_GTH' (xilinx.com:ip:gtwizard:3.6)
#-------------------------------------------------------------

# Set up project params
set_param chipscope.maxJobs 1
set_param xicom.use_bs_reader 1
# Declare source IP directory
set srcIpDir "/home/daphnelme/Desktop/CarlosPrueba/GTH_RX_SIM_Folder/GTH_RX_VC709/GTH_RX_VC709.srcs/sources_1/ip/TX_GTH"

# Create project
puts "INFO: \[open_example_project\] Creating new example project..."
create_project -name TX_GTH_ex -force
set_property part xc7vx690tffg1761-2 [current_project]
set_property target_language verilog [current_project]
set_property simulator_language MIXED [current_project]
set_property coreContainer.enable false [current_project]
set returnCode 0

# Set up pre-compilation paths

# Import the original IP (excluding example files)
puts "INFO: \[open_example_project\] Importing original IP ..."
import_ip -files [list [file join $srcIpDir TX_GTH.xci]] -name TX_GTH
reset_target {open_example} [get_ips TX_GTH]

# Generate the IP
proc _filter_supported_targets {targets ip} {
  set res {}
  set all [get_property SUPPORTED_TARGETS $ip]
  foreach target $targets {
    lappend res {*}[lsearch -all -inline -nocase $all $target]
  }
  return $res
}
puts "INFO: \[open_example_project\] Generating the example project IP ..."
generate_target -quiet [_filter_supported_targets {instantiation_template synthesis simulation implementation shared_logic} [get_ips TX_GTH]] [get_ips TX_GTH]

# Add example synthesis HDL files
puts "INFO: \[open_example_project\] Adding example synthesis HDL files ..."
add_files -scan_for_includes -quiet -fileset [current_fileset] \
  [list [file join $srcIpDir TX_GTH/example_design/tx_gth_exdes.v]] \
  [list [file join $srcIpDir TX_GTH/example_design/tx_gth_gt_frame_check.v]] \
  [list [file join $srcIpDir TX_GTH/example_design/tx_gth_gt_frame_gen.v]]

# Add example miscellaneous synthesis files
puts "INFO: \[open_example_project\] Adding example synthesis miscellaneous files ..."
add_files -quiet -fileset [current_fileset] \
  [list [file join $srcIpDir TX_GTH/example_design/gt_rom_init_tx.dat]]
set_property USED_IN_SIMULATION false [get_files [list [file join $srcIpDir TX_GTH/example_design/gt_rom_init_tx.dat]]]

# Add example XDC files
puts "INFO: \[open_example_project\] Adding example XDC files ..."
add_files -quiet -fileset [current_fileset -constrset] \
  [list [file join $srcIpDir TX_GTH/example_design/TX_GTH_exdes.xdc]]


# Add example simulation HDL files
puts "INFO: \[open_example_project\] Adding simulation HDL files ..."
if { [catch {current_fileset -simset} exc] } { create_fileset -simset sim_1 }
add_files -quiet -scan_for_includes -fileset [current_fileset -simset] \
  [list [file join $srcIpDir TX_GTH/simulation/tx_gth_tb.v]]
set_property USED_IN_SYNTHESIS false [get_files [list [file join $srcIpDir TX_GTH/simulation/tx_gth_tb.v]]]

# Add example miscellaneous simulation files
puts "INFO: \[open_example_project\] Adding simulation miscellaneous files ..."
if { [catch {current_fileset -simset} exc] } { create_fileset -simset sim_1 }
add_files -quiet -fileset [current_fileset -simset] \
  [list [file join $srcIpDir TX_GTH/simulation/functional/gt_rom_init_tx.dat]]
set_property USED_IN_SYNTHESIS false [get_files [list [file join $srcIpDir TX_GTH/simulation/functional/gt_rom_init_tx.dat]]]

# Import all files while preserving hierarchy
import_files

# Set top
set_property TOP [lindex [find_top] 0] [current_fileset]

puts "INFO: \[open_example_project\] Sourcing example extension scripts ..."
# Source script extension file(s)
if {[catch {source [file join $srcIpDir tcl/set_top.tcl]} errMsg]} {
  puts "ERROR: \[open_example_project\] Open Example Project failed: Error encountered while sourcing custom IP example design script."
  puts "$errMsg"
  error "ERROR: see log file for details."
  incr returnCode
}
if {[catch {source [file join $srcIpDir TX_GTH/tcl/xci.tcl]} errMsg]} {
  puts "ERROR: \[open_example_project\] Open Example Project failed: Error encountered while sourcing custom IP example design script."
  puts "$errMsg"
  error "ERROR: see log file for details."
  incr returnCode
}
if {[catch {source [file join $srcIpDir TX_GTH/tcl/tx_gth_partner.tcl]} errMsg]} {
  puts "ERROR: \[open_example_project\] Open Example Project failed: Error encountered while sourcing custom IP example design script."
  puts "$errMsg"
  error "ERROR: see log file for details."
  incr returnCode
}

# Update compile order
update_compile_order -fileset [current_fileset]
update_compile_order -fileset [current_fileset -simset]
set tops [list]
foreach tfile [ get_files -filter {name=~"*.xci" || name=~"*.bdj" || name=~"*.bd"}] { if { [lsearch [list_property $tfile] PARENT_COMPOSITE_FILE ] == -1} {lappend tops $tfile} }
puts "INFO: \[open_example_project\] Rebuilding all the top level IPs ..."
generate_target all $tops
export_ip_user_files -force

set dfile [file join $srcIpDir oepdone.txt]
if { [ catch { set doneFile [open $dfile w] } ] } {
} else { 
  puts $doneFile "Open Example Project DONE"
  close $doneFile
}
if { $returnCode != 0 } {
  puts "ERROR: \[open_example_project\] Problems were encountered while executing the example design script, please review the log file."
  error "ERROR: See log file for details."
  incr returnCode
} else {
  puts "INFO: \[open_example_project\] Open Example Project completed"
}
