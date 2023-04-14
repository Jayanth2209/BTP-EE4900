package adder;

    interface Ifc_adder;
        (*always_ready, always_enabled*)
        method Action iA (Bit#(8) a);
        (*always_ready, always_enabled*)
        method Action iB (Bit#(8) b);
        (*always_enabled*)
        method Bit#(8) oP();
    endinterface: Ifc_adder

    (*synthesize*)
    module mkadder(Ifc_adder);
        Reg#(Bit#(8)) reg_a <- mkReg(0);
        Reg#(Bit#(8)) reg_b <- mkReg(0);

        method Action iA (Bit#(8) a);
            reg_a <= a;
        endmethod

        method Action iB (Bit#(8) b);
            reg_b <= b;
        endmethod

        method Bit#(8) oP();
            return (reg_a + reg_b);
        endmethod

    endmodule

endpackage
