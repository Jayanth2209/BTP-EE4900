package Tb;

import mac322p::*;

(*synthesize*)
module mkTb(Empty);

    Ifc_mac322p dut <- mkmac322p;

    Reg#(Bit#(2)) stage <- mkRegA(0);

    rule load_inputs (stage == 0);

        Bit#(32) m1 = 'h0000a42f;
        Bit#(32) m2 = 'h0000d7cb;
        Bit#(32) a = 'h000ee613;
        //Bit#(2) reg_mode = 'b00;

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

//8a749058

endpackage
