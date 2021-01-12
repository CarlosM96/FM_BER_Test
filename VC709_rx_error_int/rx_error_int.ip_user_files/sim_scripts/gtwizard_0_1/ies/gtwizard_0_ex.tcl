#-------------------------------------------------------------
# Generated Example Tcl script for IP 'gtwizard_0' (xilinx.com:ip:gtwizard:3.6)
#-------------------------------------------------------------

# Declare source IP directory
set srcIpDir "/home/daphnelme/Desktop/CarlosPrueba/GTH_RX_SIM_Folder/GTH_RX_VC709/GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1"

# Create project
puts "INFO: \[open_example_project\] Creating new example project..."
create_project -name gtwizard_0_ex -force
set_property part xc7vx690tffg1761-2 [current_project]
set_property target_language verilog [current_project]
set_property simulator_language MIXED [current_project]
set_property coreContainer.enable false [current_project]
set returnCode 0

# Set up pre-compilation paths

# Import the original IP (excluding example files)
puts "INFO: \[open_example_project\] Importing original IP ..."
import_ip -files [list [file join $srcIpDir gtwizard_0.xci]] -name gtwizard_0
reset_target {open_example} [get_ips gtwizard_0]

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
generate_target -quiet [_filter_supported_targets {instantiation_template synthesis simulation implementation shared_logic} [get_ips gtwizard_0]] [get_ips gtwizard_0]

# Add example synthesis HDL files
puts "INFO: \[open_example_project\] Adding example synthesis HDL files ..."
add_files -scan_for_includes -quiet -fileset [current_fileset] \
  [list [file join $srcIpDir gtwizard_0/example_design/gtwizard_0_exdes.v]] \
  [list [file join $srcIpDir gtwizard_0/example_design/gtwizard_0_gt_frame_check.v]] \
  [list [file join $srcIpDir gtwizard_0/example_design/gtwizard_0_gt_frame_gen.v]]

# Add example miscellaneous synthesis files
puts "INFO: \[open_example_project\] Adding example synthesis miscellaneous files ..."
add_files -quiet -fileset [current_fileset] \
  [list [file join $srcIpDir gtwizard_0/example_design/gt_rom_init_rx.dat]]
set_property USED_IN_SIMULATION false [get_files [list [file join $srcIpDir gtwizard_0/example_design/gt_rom_init_rx.dat]]]

# Add example XDC files
puts "INFO: \[open_example_project\] Adding example XDC files ..."
add_files -quiet -fileset [current_fileset -constrset] \
  [list [file join $srcIpDir gtwizard_0/example_design/gtwizard_0_exdes.xdc]]


# Add example simulation HDL files
puts "INFO: \[open_example_project\] Adding simulation HDL files ..."
if { [catch {current_fileset -simset} exc] } { create_fileset -simset sim_1 }
add_files -quiet -scan_for_includes -fileset [current_fileset -simset] \
  [list [file join $srcIpDir gtwizard_0/simulation/gtwizard_0_tb.v]]
set_property USED_IN_SYNTHESIS false [get_files [list [file join $srcIpDir gtwizard_0/simulation/gtwizard_0_tb.v]]]

# Add example miscellaneous simulation files
puts "INFO: \[open_example_project\] Adding simulation miscellaneous files ..."
if { [catch {current_fileset -simset} exc] } { create_fileset -simset sim_1 }
add_files -quiet -fileset [current_fileset -simset] \
  [list [file join $srcIpDir gtwizard_0/simulation/functional/gt_rom_init_rx.dat]]
set_property USED_IN_SYNTHESIS false [get_files [list [file join $srcIpDir gtwizard_0/simulation/functional/gt_rom_init_rx.dat]]]

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
if {[catch {source [file join $srcIpDir gtwizard_0/tcl/xci.tcl]} errMsg]} {
  puts "ERROR: \[open_example_project\] Open Example Project failed: Error encountered while sourcing custom IP example design script."
  puts "$errMsg"
  error "ERROR: see log file for details."
  incr returnCode
}
if {[catch {source [file join $srcIpDir gtwizard_0/tcl/gtwizard_0_partner.tcl]} errMsg]} {
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
