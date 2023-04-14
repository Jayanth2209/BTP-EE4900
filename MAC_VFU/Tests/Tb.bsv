package Tb;

import mac644p::*;

(*synthesize*)
module mkTb(Empty);

    Ifc_mac644p dut <- mkmac644p;

    Reg#(Bit#(2)) stage <- mkRegA(0);

    rule load_inputs (stage == 0);

        Bit#(64) m1 = 'hffffffffffffffff;
        Bit#(64) m2 = 'hffffffffffffffff;
        Bit#(64) a = 'hffffffffffffffff;
        Bit#(2) reg_mode = 'b00;

        $display("Inputs: M1 = %h, M2 = %h, and A = %h\n", m1, m2, a);    

        dut.get_values(m1, m2, a);

        stage <= 1;

    endrule

    rule read_output (stage == 1);
        let res = dut.mac_result;
        $display("MAC Result: %h ", res);
        stage <= 2;
        $finish(0);
    endrule
endmodule

endpackage
