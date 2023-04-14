TOPFILE ?=  
TOPMODULE ?= 

# VSIM ?= 

BSC_COMP_FLAGS = -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing
BSC_LINK_FLAGS = -keep-fires

# Bluesim
BSIM_DIRS = -simdir build_bsim -bdir build_bsim -info-dir build_bsim
BSIM_EXE = $(TOPMODULE)_bsim

.PHONY: all_bsim
all_bsim: full_clean  compile  link    simulate

build_bsim:
	mkdir  build_bsim

.PHONY: compile
compile: build_bsim
	@echo Compiling for Bluesim ...
	bsc -u -sim $(BSIM_DIRS) $(BSC_COMP_FLAGS) -g $(TOPMODULE)  $(TOPFILE) 
	@echo Compiling for Bluesim Finished

.PHONY: link
link:
	@echo Linking for Bluesim ...
	bsc -e $(TOPMODULE) -sim -o $(BSIM_EXE) $(BSIM_DIRS) $(BSC_LINK_FLAGS)
	@echo Linking for Bluesim Finished

.PHONY: simulate
simulate:
	@echo Bluesim simulation ...
	./$(BSIM_EXE)  -V
	@echo Bluesim Simulation Finished

#Verilog
V_DIRS = -vdir verilog_dir -bdir build_v -info-dir build_v
VSIM_EXE = $(TOPMODULE)_vsim

.PHONY: all_vsim
all_vsim: full_clean  verilog  v_link  v_simulate

build_v:
	mkdir  build_v
verilog_dir:
	mkdir  verilog_dir

.PHONY: verilog
verilog: build_v  verilog_dir
	@echo Compiling for Verilog ...
	bsc -u -verilog $(V_DIRS) $(BSC_COMP_FLAGS) -g $(TOPMODULE)  $(TOPFILE)
	@echo Compiling for Verilog Finished

# .PHONY: v_link
# v_link:  build_v  verilog_dir
# 	@echo Linking for Verilog sim ...
# 	bsc -e $(TOPMODULE) -verilog -o ./$(VSIM_EXE) $(V_DIRS) -vsim $(VSIM)  verilog_dir/$(TOPMODULE).v \
# 		$(DISTRO)/Example_Programs/Common/C_imports.c
# 	@echo Linking for Verilog sim finished

# .PHONY: v_simulate
# v_simulate:
# 	@echo Verilog simulation...
# 	./$(VSIM_EXE)  +bscvcd
# 	@echo Verilog simulation finished

# Clean
.PHONY: clean
clean:
	rm -f  build_bsim/*  build_v/*    *~

.PHONY: full_clean
full_clean:
	rm -r -f  build_bsim  build_v  verilog_dir  *~
	rm -f  *$(TOPMODULE)*  *.vcd
