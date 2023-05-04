package Testbench;
  import FIFO :: *;
  import FIFOF :: *;
  import SpecialFIFOs :: *;

  module mkTestbench(Empty);
    FIFO#(Bit#(32)) pipe1 <- mkPipelineFIFO;
    FIFOF#(Bit#(32)) pipe2 <- mkPipelineFIFOF; //This FIFO has explicit empty, full signals
    Reg#(Bit#(4)) rg_cnt <- mkReg(0);

    Reg#(Bit#(4)) counter <- mkReg(0);
    rule cycle_count;
        counter <= counter + 1;
    endrule

    rule rl_give_inputs (rg_cnt < 6);
      pipe1.enq(zeroExtend(rg_cnt));
      rg_cnt <= rg_cnt + 1;
      $display();
    endrule

    rule rl_stage1;
      let data = pipe1.first();
      pipe2.enq(data);
      pipe1.deq();
      $display("%t: PIPE1: data: %d", $time, data);
    endrule

    // Once do check the generated verilog to get an idea about the firing conditions
    // of the rules 
    rule rl_stage2(pipe2.notEmpty);
      let data = pipe2.first();
      pipe2.deq();
      $display("%t: PIPE2: data: %d", $time, data);
    endrule

    //rule rl_dummy_print1(!pipe1.notEmpty);
    //  $display("%t: PIPE1 is Empty", $time);
    //endrule

    rule rl_dummy_print2(!pipe2.notEmpty);
      $display("%t: PIPE2 is Empty", $time);
    endrule

    rule rl_finish(rg_cnt == 6);
        $display("\nCycles: %d\n", counter);
        $finish();
    endrule
  endmodule
endpackage