package Tb;

import MAC64::*;

(*synthesize*)
module mkTb(Empty);

    Ifc_MAC64 dut <- mkMAC64;

    Reg#(Bit#(2)) stage <- mkRegA(0);

    rule load_inputs (stage == 0);

        Bit#(64) m1 = 'h47dfe10869d1a42f;
        Bit#(64) m2 = 'h5632ecb93e48d7cb;
        Bit#(64) a = 'h348afe5970f6e613;
  
        $display("\nInputs: M1 = %h, M2 = %h, and A = %h\n", m1, m2, a);  

        dut.get_inputs(m1, m2, a);

        stage <= 1;

    endrule

    rule read_output (stage == 1);
        let res = dut.mac_result;
        $display("MAC Result: %h\n", res);
        //$display("MAC Result: %h\nCycles: %d\n", res[127:0], res[131:128]);
        stage <= 2;
        $finish(0);
    endrule
endmodule

// 8X8: 180e 2c18 d06a 0621 19de 3bbe 8aa2 2558
// 16X16: 18332818 d016fd21 19bed1be 8a669058
// 32X32: 183381c92c57fd21 19bee1ecfa4f9058
// 64X64: 183381c92ceb24c924180394fa4f9058 

endpackage
