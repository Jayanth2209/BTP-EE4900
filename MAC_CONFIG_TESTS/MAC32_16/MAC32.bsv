package MAC32;

    import Vector :: *;

    import FIFOF :: *;
    import SpecialFIFOs :: *;

    interface Ifc_MAC32;
        method Action get_inputs(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend, Bit#(1) mode);
        method Bit#(64) mac_result;
        //method Bit#(68) mac_result;
    endinterface: Ifc_MAC32

    function Tuple4#(Bit#(32), Bit#(32), Bit#(32), Bit#(32)) generate_partials (Bit#(32) multiplicand1, Bit#(32) multiplicand2);

        Bit#(32) partial0 = extend(multiplicand1[15:0])*extend(multiplicand2[15:0]);
        Bit#(32) partial1 = extend(multiplicand1[15:0])*extend(multiplicand2[31:16]);
        Bit#(32) partial2 = extend(multiplicand1[31:16])*extend(multiplicand2[15:0]);
        Bit#(32) partial3 = extend(multiplicand1[31:16])*extend(multiplicand2[31:16]);

        Tuple4#(Bit#(32), Bit#(32), Bit#(32), Bit#(32)) partials = tuple4(partial0, partial1, partial2, partial3);

        return partials;

    endfunction

    function Bit#(64) add_partials (Tuple5#(Bit#(32), Bit#(32), Bit#(32), Bit#(32), Bit#(32)) partial_product);

        Bit#(64) result = extend(tpl_1(partial_product)) +
                          (extend(tpl_2(partial_product) + tpl_3(partial_product)) << 16) +
                          (extend(tpl_4(partial_product)) << 32) +
                          extend(tpl_5(partial_product));

        return result;

    endfunction

    (*synthesize*)
    (*descending_urgency = "get_inputs, rl_generate_partials, rl_add_partials, mac_result"*)
    module mkMAC32(Ifc_MAC32);

        Reg#(Bit#(1)) mode_r <- mkReg(0);

        FIFOF#(Tuple3#(Bit#(32), Bit#(32), Bit#(32))) mac_inputs <- mkPipelineFIFOF;

        FIFOF#(Tuple5#(Bit#(32), Bit#(32), Bit#(32), Bit#(32), Bit#(32))) partial_product <- mkPipelineFIFOF;

        FIFOF#(Bit#(64)) mac_output <- mkPipelineFIFOF;

        // Reg#(Bit#(4)) counter <- mkReg(0);
        // rule cycle_count;
        //     counter <= counter + 1;
        // endrule

        rule rl_generate_partials;
            let mac_i = mac_inputs.first();
            partial_product.enq(tuple5(tpl_1(generate_partials(tpl_1(mac_i), tpl_2(mac_i))), tpl_2(generate_partials(tpl_1(mac_i), tpl_2(mac_i))), tpl_3(generate_partials(tpl_1(mac_i), tpl_2(mac_i))), tpl_4(generate_partials(tpl_1(mac_i), tpl_2(mac_i))), tpl_3(mac_i)));
            mac_inputs.deq();
        endrule: rl_generate_partials

        rule rl_add_partials (mode_r == 1);
            let pp = partial_product.first();
            mac_output.enq(add_partials(pp));
            partial_product.deq();
        endrule: rl_add_partials

        rule rl_mac_16 (mode_r == 0);
            let mac16 = partial_product.first();
            mac_output.enq({tpl_4(mac16) + extend(tpl_5(mac16)[31:16]), tpl_1(mac16) + extend(tpl_5(mac16)[15:0])});
            partial_product.deq();
        endrule: rl_mac_16

        method Action get_inputs(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend, Bit#(1) mode);
            mac_inputs.enq(tuple3(multiplicand1, multiplicand2, addend));
            mode_r <= mode;
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

endpackage: MAC32