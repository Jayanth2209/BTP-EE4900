package MAC64;

    import Vector :: *;

    import FIFOF :: *;
    import SpecialFIFOs :: *;

    interface Ifc_MAC64;
        method Action get_inputs(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(1) mode);
        method Bit#(128) mac_result;
        //method Bit#(132) mac_result;
    endinterface: Ifc_MAC64

    function Vector#(8, Bit#(32)) generate_partials_1 (Bit#(64) multiplicand1, Bit#(64) multiplicand2);

        Vector#(8, Bit#(32)) partial_1;

        partial_1[0] = extend(multiplicand1[15:0])*extend(multiplicand2[15:0]);    // A0B0      0 = 0

        partial_1[1] = extend(multiplicand1[15:0])*extend(multiplicand2[31:16]);    // A0B1     1 = 1
        partial_1[2] = extend(multiplicand1[31:16])*extend(multiplicand2[15:0]);    // A1B0     2 = 2

        partial_1[3] = extend(multiplicand1[31:16])*extend(multiplicand2[31:16]);    // A1B1    3 = 4
        
        partial_1[4] = extend(multiplicand1[47:32])*extend(multiplicand2[47:32]);    // A2B2   4 = 11

        partial_1[5] = extend(multiplicand1[47:32])*extend(multiplicand2[63:48]);    // A2B3   5 = 13
        partial_1[6] = extend(multiplicand1[63:48])*extend(multiplicand2[47:32]);    // A3B2   6 = 14

        partial_1[7] = extend(multiplicand1[63:48])*extend(multiplicand2[63:48]);    // A3B3   7 = 15

        return partial_1;

    endfunction

    function Vector#(8, Bit#(32)) generate_partials_2 (Bit#(64) multiplicand1, Bit#(64) multiplicand2);

        Vector#(8, Bit#(32)) partial_2;

        partial_2[0] = extend(multiplicand1[15:0])*extend(multiplicand2[47:32]);    // A0B2     0 = 3

        partial_2[1] = extend(multiplicand1[47:32])*extend(multiplicand2[15:0]);    // A2B0     1 = 5

        partial_2[2] = extend(multiplicand1[15:0])*extend(multiplicand2[63:48]);    // A0B3     2 = 6
        partial_2[3] = extend(multiplicand1[31:16])*extend(multiplicand2[47:32]);    // A1B2    3 = 7
        partial_2[4] = extend(multiplicand1[47:32])*extend(multiplicand2[31:16]);    // A2B1    4 = 8
        partial_2[5] = extend(multiplicand1[63:48])*extend(multiplicand2[15:0]);    // A3B0     5 = 9

        partial_2[6] = extend(multiplicand1[31:16])*extend(multiplicand2[63:48]);    // A1B3   6 = 10
        
        partial_2[7] = extend(multiplicand1[63:48])*extend(multiplicand2[31:16]);    // A3B1   7 = 12

        return partial_2;

    endfunction

    function Bit#(128) mac_64 (Vector#(8, Bit#(32)) partial_1, Vector#(8, Bit#(32)) partial_2, Bit#(64) addend);

        Bit#(128) result = extend(partial_1[0]) + 
                           ((extend(partial_1[1]) + extend(partial_1[2])) << 16) +
                           ((extend(partial_2[0]) + extend(partial_1[3]) + extend(partial_2[1])) << 32) +
                           ((extend(partial_2[2]) + extend(partial_2[3]) + extend(partial_2[4]) + extend(partial_2[5])) << 48) +
                           ((extend(partial_2[6]) + extend(partial_1[4]) + extend(partial_2[7])) << 64) + 
                           ((extend(partial_1[5]) + extend(partial_1[6])) << 80) +
                           (extend(partial_1[7]) << 96) +
                           extend(addend);

        return result;

    endfunction

    function Bit#(128) mac_32 (Vector#(8, Bit#(32)) partial, Bit#(64) addend);

        Bit#(64) mac_32_1 = extend(partial[0]) +
                            ((extend(partial[1]) + extend(partial[2])) << 16) +
                            ((extend(partial[3])) << 32) +
                            extend(addend[31:0]);

        Bit#(64) mac_32_2 = extend(partial[4]) +
                            ((extend(partial[5]) + extend(partial[6])) << 16) +
                            ((extend(partial[7])) << 32) +
                            extend(addend[63:32]);

        return {mac_32_2, mac_32_1};

    endfunction

    (*synthesize*)
    (*descending_urgency = "get_inputs, rl_generate_partials_1, mac_result"*)
    module mkMAC64(Ifc_MAC64);

        Reg#(Bit#(1)) mode_r <- mkReg(0);

        FIFOF#(Tuple3#(Bit#(64), Bit#(64), Bit#(64))) mac_inputs_1 <- mkPipelineFIFOF;

        FIFOF#(Tuple2#(Vector#(8, Bit#(32)), Bit#(64))) partial_product_1 <- mkPipelineFIFOF;

        FIFOF#(Tuple3#(Bit#(64), Bit#(64), Bit#(64))) mac_inputs_2 <- mkPipelineFIFOF;

        FIFOF#(Tuple2#(Vector#(8, Bit#(32)), Bit#(64))) partial_product_2 <- mkPipelineFIFOF;

        FIFOF#(Bit#(128)) mac_output <- mkPipelineFIFOF;

        // Reg#(Bit#(4)) counter <- mkReg(0);
        // rule cycle_count;
        //     counter <= counter + 1;
        // endrule

        rule rl_generate_partials_1;
            let mac_i = mac_inputs_1.first();
            partial_product_1.enq(tuple2(generate_partials_1(tpl_1(mac_i), tpl_2(mac_i)), tpl_3(mac_i)));
            mac_inputs_1.deq();
            mac_inputs_2.enq(mac_i);
        endrule: rl_generate_partials_1

        rule rl_generate_partials_2 (mode_r == 'h1);
            let mac_i = mac_inputs_2.first();
            partial_product_2.enq(tuple2(generate_partials_2(tpl_1(mac_i), tpl_2(mac_i)), tpl_3(mac_i)));
            mac_inputs_2.deq();
        endrule: rl_generate_partials_2

        rule rl_mac_64 (mode_r == 'h1);
            let pp1 = partial_product_1.first();
            let pp2 = partial_product_2.first();
            mac_output.enq(mac_64(tpl_1(pp1), tpl_1(pp2), tpl_2(pp2)));
            partial_product_1.deq();
            partial_product_2.deq();
        endrule: rl_mac_64

        rule rl_mac_32 (mode_r == 'h0);
            let pp = partial_product_1.first();
            mac_output.enq(mac_32(tpl_1(pp), tpl_2(pp)));
            partial_product_1.deq();
        endrule: rl_mac_32

        method Action get_inputs(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(1) mode);
            mac_inputs_1.enq(tuple3(multiplicand1, multiplicand2, addend));
            mode_r <= mode;
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