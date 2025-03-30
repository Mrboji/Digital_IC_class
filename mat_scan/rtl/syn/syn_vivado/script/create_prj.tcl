### ============= Specify the top module of the design
set DESIGN_TOP mat_scan

### ============= Specify the xdc file
set XDC_FILE ./script/top.xdc

### ============= Create project
create_project mat_scan -part xc7z020clg400-2
read_xdc $XDC_FILE
set_param general.maxThreads 16

source ./script/read_src.tcl

set_property top $DESIGN_TOP [current_fileset]