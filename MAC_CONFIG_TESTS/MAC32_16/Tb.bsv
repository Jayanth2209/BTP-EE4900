package Tb;

import MAC32::*;

(*synthesize*)
module mkTb(Empty);

    Ifc_MAC32 dut <- mkMAC32;

    Reg#(Bit#(2)) stage <- mkRegA(0);

    rule load_inputs (stage == 0);

        Bit#(32) m1 = 'h69d1a42f;
        Bit#(32) m2 = 'h3e48d7cb;
        Bit#(32) a = 'h70f6e613;

        Bit#(1) mode = 'h0;

        $display("\nInputs: M1 = %h, M2 = %h, A = %h, and Mode = %h\n", m1, m2, a, mode);    

        dut.get_inputs(m1, m2, a, mode);

        stage <= 1;

    endrule

    rule read_output (stage == 1);
        let res = dut.mac_result;
        $display("MAC Result: %h\n", res);
        //$display("MAC Result: %h\nCycles: %d\n", res[63:0], res[67:64]);
        stage <= 2;
        $finish(0);
    endrule
endmodule

// 8X8: 180e 2c18 d06a 0621 19de 3bbe 8aa2 2558
// 16X16: 18332818 d016fd21 19bed1be 8a669058
// 32X32: 183381c92c57fd21 19bee1ecfa4f9058
// 64X64: 183381c92ceb24c924180394fa4f9058 

endpackage
