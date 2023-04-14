package Tb;

import MAC::*;

(*synthesize*)
module mkTb(Empty);

    Ifc_MAC dut <- mkMAC;

    Reg#(Bit#(2)) stage <- mkRegA(0);

    Reg#(Bit#(2)) reg_mode <- mkReg(0);

    rule load_inputs (stage == 0);

        Bit#(32) m1 = 'h69d1a42f;
        Bit#(32) m2 = 'h3e48d7cb;
        Bit#(32) a = 'h70f6e613;

        Bit#(2) mode = 'b00;
        reg_mode <= 'b00;

        $display("\nInputs: M1 = %h, M2 = %h, A = %h, and Mode: %h\n", m1, m2, a, mode);    

        dut.get_values(m1, m2, a, mode);

        stage <= 1;

    endrule

    rule read_output (stage == 1);
        let res = dut.mac_result;
        case (reg_mode)
            0: $display("MAC Result: %h %h %h %h\n", res[63:48], res[47:32], res[31:16], res[15:0]);
            1: $display("MAC Result: %h %h\n", res[63:32], res[31:0]);
            2: $display("MAC Result: %h\n", res);
            default: $display("MAC Result: %h\n", res);
        endcase
        // case (reg_mode)
        //     0: $display("MAC Result: %h %h %h %h\nCycles: %d\n", res[63:48], res[47:32], res[31:16], res[15:0], (res[67:64]-1));
        //     1: $display("MAC Result: %h %h\nCycles: %d\n", res[63:32], res[31:0], (res[67:64]-1));
        //     2: $display("MAC Result: %h\nCycles: %d\n", res[63:0], (res[67:64]-1));
        //     default: $display("MAC Result: %h\nCycles: %d\n", res[63:0], (res[67:64]-1));
        // endcase
        stage <= 2;
        $finish(0);
    endrule
endmodule

// 8X8: 19de 3bbe 8aa2 2558
// 16X16: 19bed1be 8a669058
// 32X32: 19bee1ecfa4f9058

endpackage
