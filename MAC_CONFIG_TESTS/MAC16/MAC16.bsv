package MAC16;

    import Vector :: *;

    import FIFOF :: *;
    import SpecialFIFOs :: *;

    interface Ifc_MAC16;
        method Action get_inputs(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);
        method Bit#(64) mac_result();
        //method Bit#(68) mac_result();
    endinterface: Ifc_MAC16

    function Tuple4#(Bit#(32), Bit#(32), Bit#(32), Bit#(32)) generate_macs (Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);

        Bit#(32) mac0 = extend(multiplicand1[15:0])*extend(multiplicand2[15:0]) + extend(addend[15:0]);
        Bit#(32) mac1 = extend(multiplicand1[15:0])*extend(multiplicand2[31:16]) + extend(addend[15:0]);
        Bit#(32) mac2 = extend(multiplicand1[31:16])*extend(multiplicand2[15:0]) + extend(addend[31:16]);
        Bit#(32) mac3 = extend(multiplicand1[31:16])*extend(multiplicand2[31:16]) + extend(addend[31:16]);

        Tuple4#(Bit#(32), Bit#(32), Bit#(32), Bit#(32)) macs = tuple4(mac0, mac1, mac2, mac3);

        return macs;

    endfunction

    (*synthesize*)
    (*descending_urgency = "get_inputs, rl_generate_macs, mac_result"*)
    module mkMAC16(Ifc_MAC16);

        FIFOF#(Tuple3#(Bit#(32), Bit#(32), Bit#(32))) mac_inputs <- mkPipelineFIFOF;

        FIFOF#(Tuple5#(Bit#(32), Bit#(32), Bit#(32), Bit#(32), Bit#(32))) partial_product <- mkPipelineFIFOF;

        FIFOF#(Bit#(64)) mac_output <- mkPipelineFIFOF;

        // Reg#(Bit#(4)) counter <- mkReg(0);
        // rule cycle_count;
        //     counter <= counter + 1;
        // endrule

        rule rl_generate_macs;
            let mac_i = mac_inputs.first();
            mac_output.enq({tpl_4(generate_macs(tpl_1(mac_i), tpl_2(mac_i), tpl_3(mac_i))), tpl_1(generate_macs(tpl_1(mac_i), tpl_2(mac_i), tpl_3(mac_i)))});
            mac_inputs.deq();
        endrule: rl_generate_macs

        method Action get_inputs(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);
            mac_inputs.enq(tuple3(multiplicand1, multiplicand2, addend));
        endmethod

        method Bit#(64) mac_result();
            let final_mac_result = mac_output.first();
            return final_mac_result;
        endmethod

        // method Bit#(68) mac_result();
        //     let final_mac_result = mac_output.first();
        //     return {counter, final_mac_result};
        // endmethod

    endmodule

endpackage: MAC16