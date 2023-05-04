/*
 * Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
 * 
 * On Thu May  4 22:04:10 IST 2023
 * 
 */

/* Generation options: keep-fires */
#ifndef __mkTestbench_h__
#define __mkTestbench_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"


/* Class declaration for the mkTestbench module */
class MOD_mkTestbench : public Module {
 
 /* Clock handles */
 private:
  tClock __clk_handle_0;
 
 /* Clock gate handles */
 public:
  tUInt8 *clk_gate[0];
 
 /* Instantiation parameters */
 public:
 
 /* Module state */
 public:
  MOD_Reg<tUInt8> INST_counter;
  MOD_CReg<tUInt64> INST_pipe1_rv;
  MOD_CReg<tUInt64> INST_pipe2_rv;
  MOD_Reg<tUInt8> INST_rg_cnt;
 
 /* Constructor */
 public:
  MOD_mkTestbench(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_WILL_FIRE_RL_rl_finish;
  tUInt8 DEF_CAN_FIRE_RL_rl_finish;
  tUInt8 DEF_WILL_FIRE_RL_rl_dummy_print2;
  tUInt8 DEF_CAN_FIRE_RL_rl_dummy_print2;
  tUInt8 DEF_WILL_FIRE_RL_rl_stage2;
  tUInt8 DEF_CAN_FIRE_RL_rl_stage2;
  tUInt8 DEF_WILL_FIRE_RL_rl_stage1;
  tUInt8 DEF_CAN_FIRE_RL_rl_stage1;
  tUInt8 DEF_WILL_FIRE_RL_rl_give_inputs;
  tUInt8 DEF_CAN_FIRE_RL_rl_give_inputs;
  tUInt8 DEF_WILL_FIRE_RL_cycle_count;
  tUInt8 DEF_CAN_FIRE_RL_cycle_count;
  tUInt64 DEF_pipe2_rv_port0__read____d22;
  tUInt64 DEF_pipe1_rv_port0__read____d11;
  tUInt8 DEF_x__h683;
 
 /* Local definitions */
 private:
  tUInt64 DEF_v__h1063;
  tUInt64 DEF_v__h1019;
  tUInt64 DEF_v__h902;
  tUInt8 DEF_x__h540;
  tUInt64 DEF__0_CONCAT_DONTCARE___d19;
 
 /* Rules */
 public:
  void RL_cycle_count();
  void RL_rl_give_inputs();
  void RL_rl_stage1();
  void RL_rl_stage2();
  void RL_rl_dummy_print2();
  void RL_rl_finish();
 
 /* Methods */
 public:
 
 /* Reset routines */
 public:
  void reset_RST_N(tUInt8 ARG_rst_in);
 
 /* Static handles to reset routines */
 public:
 
 /* Pointers to reset fns in parent module for asserting output resets */
 private:
 
 /* Functions for the parent module to register its reset fns */
 public:
 
 /* Functions to set the elaborated clock id */
 public:
  void set_clk_0(char const *s);
 
 /* State dumping routine */
 public:
  void dump_state(unsigned int indent);
 
 /* VCD dumping routines */
 public:
  unsigned int dump_VCD_defs(unsigned int levels);
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkTestbench &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkTestbench &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkTestbench &backing);
};

#endif /* ifndef __mkTestbench_h__ */