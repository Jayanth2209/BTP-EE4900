package Tb;

import MAC::*;

(*synthesize*)
module mkTb(Empty);

    Ifc_MAC dut <- mkMAC;

    Reg#(Bit#(2)) stage <- mkRegA(0);

    rule load_inputs (stage == 0);

        // Bit#(64) m1 = 'h2f;
        // Bit#(64) m2 = 'hcb;
        // Bit#(64) a = 'h13;
        // Bit#(2) mode = 'b00;

        // Bit#(64) m1 = 'ha42f;
        // Bit#(64) m2 = 'hd7cb;
        // Bit#(64) a = 'he613;
        // Bit#(2) mode = 'b01;

        // Bit#(64) m1 = 'h69d1a42f;
        // Bit#(64) m2 = 'h3e48d7cb;
        // Bit#(64) a = 'h70f6e613;
        // Bit#(2) mode = 'b10;

        Bit#(64) m1 = 'h47dfe10869d1a42f;
        Bit#(64) m2 = 'h5632ecb93e48d7cb;
        Bit#(64) a = 'h348afe5970f6e613;
        Bit#(2) mode = 'b11;

        $display("Inputs: M1 = %h, M2 = %h, A = %h, and Mode: %h\n", m1, m2, a, mode);    

        dut.get_values(m1, m2, a, mode);

        stage <= 1;

    endrule

    rule read_output (stage == 1);
        let res = dut.mac_result;
        $display("MAC Result: %h ", res);
        stage <= 2;
        $finish(0);
    endrule
endmodule

// 8X8: 2558 (2f x cb + 13)
// 16X16: 8a669058 (a42f x d7cb + e613)
// 32X32: 19bee1ecfa4f9058 (69d1a42f x 3e48d7cb + 70f6e613)
// 64X64: 183381c92ceb24c924180394fa4f9058 (47dfe10869d1a42f x 5632ecb93e48d7cb + 348afe5970f6e613)

endpackage
