package MAC64;

    import Vector :: *;

    import FIFOF :: *;
    import SpecialFIFOs :: *;

    interface Ifc_MAC64;
        method Action get_inputs(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend);
        method Bit#(128) mac_result;
        //method Bit#(132) mac_result;
    endinterface: Ifc_MAC64

    function Vector#(16, Bit#(32)) generate_partials (Bit#(64) multiplicand1, Bit#(64) multiplicand2);

        Vector#(16, Bit#(32)) partial;

        partial[0] = extend(multiplicand1[15:0])*extend(multiplicand2[15:0]);    // A0B0

        partial[1] = extend(multiplicand1[15:0])*extend(multiplicand2[31:16]);    // A0B1
        partial[2] = extend(multiplicand1[31:16])*extend(multiplicand2[15:0]);    // A1B0

        partial[3] = extend(multiplicand1[15:0])*extend(multiplicand2[47:32]);    // A0B2
        partial[4] = extend(multiplicand1[31:16])*extend(multiplicand2[31:16]);    // A1B1
        partial[5] = extend(multiplicand1[47:32])*extend(multiplicand2[15:0]);    // A2B0

        partial[6] = extend(multiplicand1[15:0])*extend(multiplicand2[63:48]);    // A0B3
        partial[7] = extend(multiplicand1[31:16])*extend(multiplicand2[47:32]);    // A1B2
        partial[8] = extend(multiplicand1[47:32])*extend(multiplicand2[31:16]);    // A2B1
        partial[9] = extend(multiplicand1[63:48])*extend(multiplicand2[15:0]);    // A3B0

        partial[10] = extend(multiplicand1[31:16])*extend(multiplicand2[63:48]);    // A1B3
        partial[11] = extend(multiplicand1[47:32])*extend(multiplicand2[47:32]);    // A2B2
        partial[12] = extend(multiplicand1[63:48])*extend(multiplicand2[31:16]);    // A3B1

        partial[13] = extend(multiplicand1[47:32])*extend(multiplicand2[63:48]);    // A2B3
        partial[14] = extend(multiplicand1[63:48])*extend(multiplicand2[47:32]);    // A3B2

        partial[15] = extend(multiplicand1[63:48])*extend(multiplicand2[63:48]);    // A3B3

        return partial;

    endfunction

    function Bit#(128) mac_64 (Vector#(16, Bit#(32)) partial, Bit#(64) addend);

        Bit#(128) result = extend(partial[0]) + 
                           ((extend(partial[1]) + extend(partial[2])) << 16) +
                           ((extend(partial[3]) + extend(partial[4]) + extend(partial[5])) << 32) +
                           ((extend(partial[6]) + extend(partial[7]) + extend(partial[8]) + extend(partial[9])) << 48) +
                           ((extend(partial[10]) + extend(partial[11]) + extend(partial[12])) << 64) + 
                           ((extend(partial[13]) + extend(partial[14])) << 80) +
                           (extend(partial[15]) << 96) +
                           extend(addend);

        return result;

    endfunction

    (*synthesize*)
    (*descending_urgency = "get_inputs, rl_generate_partials, rl_mac_64, mac_result"*)
    module mkMAC64(Ifc_MAC64);

        FIFOF#(Tuple3#(Bit#(64), Bit#(64), Bit#(64))) mac_inputs <- mkPipelineFIFOF;

        FIFOF#(Tuple2#(Vector#(16, Bit#(32)), Bit#(64))) partial_product <- mkPipelineFIFOF;

        FIFOF#(Bit#(128)) mac_output <- mkPipelineFIFOF;

        // Reg#(Bit#(4)) counter <- mkReg(0);
        // rule cycle_count;
        //     counter <= counter + 1;
        // endrule

        rule rl_generate_partials;
            let mac_i = mac_inputs.first();
            partial_product.enq(tuple2(generate_partials(tpl_1(mac_i), tpl_2(mac_i)), tpl_3(mac_i)));
            mac_inputs.deq();
        endrule: rl_generate_partials

        rule rl_mac_64;
            let pp = partial_product.first();
            mac_output.enq(mac_64(tpl_1(pp), tpl_2(pp)));
            partial_product.deq();
        endrule: rl_mac_64

        method Action get_inputs(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend);
            mac_inputs.enq(tuple3(multiplicand1, multiplicand2, addend));
        endmethod

        method Bit#(128) mac_result;
            let final_mac_result = mac_output.first();
            return final_mac_result;
        endmethod

        // method Bit#(132) mac_result;
        //     let final_mac_result = mac_output.first();
        //     return {counter, final_mac_result};
        // endmethod

    endmodule

endpackage: MAC64