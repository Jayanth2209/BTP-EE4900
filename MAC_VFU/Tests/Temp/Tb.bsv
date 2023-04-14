package Tb;

import mac642p::*;

(*synthesize*)
module mkTb(Empty);

    Ifc_mac642p dut<- mkmac642p;

    Reg#(Bit#(2)) stage <-mkRegA(0);

    rule load_inputs (stage == 0);

        Bit#(64) m1 = 'hffffffffffffffff;
        Bit#(64) m2 = 'hffffffffffffffff;
        Bit#(64) a = 'hffffffffffffffff;

        $display("Inputs: M1 %h, M2 %h, and A %h\n", m1, m2, a);    

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