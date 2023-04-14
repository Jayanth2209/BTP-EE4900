package Tb;

import MAC::*;

(*synthesize*)
module mkTb(Empty);

    Ifc_MAC dut <- mkMAC;

    Reg#(Bit#(2)) stage <- mkRegA(0);

    Reg#(Bit#(2)) reg_mode <- mkReg(0);

    rule load_inputs (stage == 0);

        Bit#(64) m1 = 'h47dfe10869d1a42f;
        Bit#(64) m2 = 'h5632ecb93e48d7cb;
        Bit#(64) a = 'h348afe5970f6e613;

        Bit#(2) mode = 'b01;
        reg_mode <= 'b01;

        $display("\nInputs: M1 = %h, M2 = %h, A = %h, and Mode: %h\n", m1, m2, a, mode);    

        dut.get_values(m1, m2, a, mode);

        stage <= 1;

    endrule

    rule read_output (stage == 1);
        let res = dut.mac_result;
        case (reg_mode)
            0: $display("MAC Result: %h %h %h %h %h %h %h %h\nCycles: %d\n", res[127:112], res[111:96], res[95:80], res[79:64], res[63:48], res[47:32], res[31:16], res[15:0], (res[131:128] - 1));
            1: $display("MAC Result: %h %h %h %h\nCycles: %d\n", res[127:96], res[95:64], res[63:32], res[31:0], (res[131:128] - 1));
            2: $display("MAC Result: %h %h\nCycles: %d\n", res[127:64], res[63:0], (res[131:128] - 1));
            3: $display("MAC Result: %h\nCycles: %d\n", res[127:0], (res[131:128] - 1));
            default: $display("MAC Result: %h\n", res, (res[131:128] - 1));
        endcase
        stage <= 2;
        $finish(0);
    endrule
endmodule

// 8X8: 180e 2c18 d06a 0621 19de 3bbe 8aa2 2558
// 16X16: 18332818 d016fd21 19bed1be 8a669058
// 32X32: 183381c92c57fd21 19bee1ecfa4f9058
// 64X64: 183381c92ceb24c924180394fa4f9058 

endpackage
