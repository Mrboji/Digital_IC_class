.PHONY: syn sim open clean 

currentPath = $(shell powershell -Command "Get-Location")
CASE = $(shell powershell -Command "Split-Path -Leaf '$(currentPath)'")

syn:
	cd .\rtl\syn\syn_vivado & .\create.bat

sim:
	cd .\rtl\sim\sim_modelsim & .\Run_Sim.bat

open:
	cd .\rtl\syn\syn_vivado & vivado .\$(CASE).xpr

clean:
	@cd .\rtl\syn\syn_vivado & .\clean.bat
	@cd .\rtl\sim\sim_modelsim & .\clean.bat

clean_all:
	@cd .\rtl\syn\syn_vivado & powershell Remove-Item $(CASE).*