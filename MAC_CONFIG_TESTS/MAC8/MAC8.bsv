package MAC8;

    import Vector :: *;

    import FIFOF :: *;
    import SpecialFIFOs :: *;

    interface Ifc_MAC8;
        method Action get_inputs(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);
        method Bit#(64) mac_result;
        //method Bit#(68) mac_result;
    endinterface: Ifc_MAC8

    function Bit#(64) generate_macs (Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);

        Bit#(16) mac0 = extend(multiplicand1[7:0])*extend(multiplicand2[7:0]) + extend(addend[7:0]);
        Bit#(16) mac1 = extend(multiplicand1[15:8])*extend(multiplicand2[15:8]) + extend(addend[15:8]);
        Bit#(16) mac2 = extend(multiplicand1[23:16])*extend(multiplicand2[23:16]) + extend(addend[23:16]);
        Bit#(16) mac3 = extend(multiplicand1[31:24])*extend(multiplicand2[31:24]) + extend(addend[31:24]);

        Bit#(64) macs = {mac3, mac2, mac1, mac0};

        return macs;

    endfunction

    (*synthesize*)
    (*descending_urgency = "get_inputs, rl_generate_macs, mac_result"*)
    module mkMAC8(Ifc_MAC8);

        FIFOF#(Tuple3#(Bit#(32), Bit#(32), Bit#(32))) mac_inputs <- mkPipelineFIFOF;

        FIFOF#(Bit#(64)) mac_output <- mkPipelineFIFOF;

        // Reg#(Bit#(4)) counter <- mkReg(0);
        // rule cycle_count;
        //     counter <= counter + 1;
        // endrule

        rule rl_generate_macs;
            let mac_i = mac_inputs.first();
            mac_output.enq(generate_macs(tpl_1(mac_i), tpl_2(mac_i), tpl_3(mac_i)));
            mac_inputs.deq();
        endrule: rl_generate_macs

        method Action get_inputs(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);
            mac_inputs.enq(tuple3(multiplicand1, multiplicand2, addend));
        endmethod

        method Bit#(64) mac_result;
            let final_mac_result = mac_output.first();
            return final_mac_result;
        endmethod

        // method Bit#(68) mac_result;
        //     let final_mac_result = mac_output.first();
        //     return {counter, final_mac_result};
        // endmethod

    endmodule

endpackage: MAC8