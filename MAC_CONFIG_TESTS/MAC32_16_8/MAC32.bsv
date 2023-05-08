package MAC32;

    import Vector :: *;

    import FIFOF :: *;
    import SpecialFIFOs :: *;

    interface Ifc_MAC32;
        method Action get_inputs(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend, Bit#(2) mode);
        method Bit#(64) mac_result;
        //method Bit#(68) mac_result;
    endinterface: Ifc_MAC32

    // function Tuple4#(Bit#(32), Bit#(32), Bit#(32), Bit#(32)) generate_partials (Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(2) mode);

    //     Vector#(4, Reg#(Bit#(32))) partial <- replicateM(mkReg(0));

    //     for (int i = 0; i < 2; i = i + 1) begin
    //         for (int j = 0; j < 2; j = j + 1) begin
    //             partial[i+j] = extend(multiplicand1[15+16*i:16*i])*extend(multiplicand2[15+16*j:16*j]);
    //         end
    //     end

    //     // case (mode)
    //     //     0: begin
    //     //         partial[0] = extend(multiplicand1[15:0] && 'h00ff)*extend(multiplicand2[15:0] && 'h00ff);
    //     //         partial[1] = extend((multiplicand1[15:0] && 'hff00) >> 8)*extend(multiplicand2[31:16] && 'h00ff);
    //     //         partial[2] = extend(multiplicand1[31:16] && 'h00ff)*extend((multiplicand2[15:0] && 'hff00) >> 8);
    //     //         partial[3] = extend((multiplicand1[31:16] && 'hff00) >> 8)*extend((multiplicand2[15:0] && 'hff00) >> 8);

    //     //         // for (int i = 0; i < 2; i = i + 1) begin
    //     //         //     for (int j = 0; j < 2; j = j + 1) begin
    //     //         //         partial[2*i+j] = (j ? extend((multiplicand1[15+16*i:16*i] && 'hff00) >> 8) : extend(multiplicand1[15+16*i:16*i] && 'h00ff))*(j ? extend((multiplicand2[15+16*j:16*j] && 'h00ff) >> 8) : extend(multiplicand2[15+16*j:16*j] && 'hff00));
    //     //         //     end
    //     //         // end

    //     //     end
    //     //     1: begin
    //     //         for (int i = 0; i < 2; i = i + 1) begin
    //     //             for (int j = 0; j < 2; j = j + 1) begin
    //     //                 partial[2*i+j] = extend(multiplicand1[15+16*i:16*i])*extend(multiplicand2[15+16*j:16*j]);
    //     //             end
    //     //         end
    //     //     end
    //     //     2: begin
    //     //         for (int i = 0; i < 2; i = i + 1) begin
    //     //             for (int j = 0; j < 2; j = j + 1) begin
    //     //                 partial[2*i+j] = extend(multiplicand1[15+16*i:16*i])*extend(multiplicand2[15+16*j:16*j]);
    //     //             end
    //     //         end
    //     //     end
    //     //     default: begin
    //     //         for (int i = 0; i < 2; i = i + 1) begin
    //     //             for (int j = 0; j < 2; j = j + 1) begin
    //     //                 partial[2*i+j] = extend(multiplicand1[15+16*i:16*i])*extend(multiplicand2[15+16*j:16*j]);
    //     //             end
    //     //         end
    //     //     end
    //     // endcase

    //     Tuple4#(Bit#(32), Bit#(32), Bit#(32), Bit#(32)) partials = tuple4(partial[0], partial[1], partial[2], partial[3]);

    //     return partials;

    // endfunction

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

        Reg#(Bit#(2)) mode_r <- mkReg(0);

        Vector#(4, Reg#(Bit#(32))) partial <- replicateM(mkReg(0));

        FIFOF#(Tuple3#(Bit#(32), Bit#(32), Bit#(32))) mac_inputs <- mkPipelineFIFOF;

        FIFOF#(Tuple5#(Bit#(32), Bit#(32), Bit#(32), Bit#(32), Bit#(32))) partial_product <- mkPipelineFIFOF;

        FIFOF#(Bit#(64)) mac_output <- mkPipelineFIFOF;

        Vector#(4, Reg#(Bit#(16))) mac8 <- replicateM(mkReg(0));

        // Reg#(Bit#(4)) counter <- mkReg(0);
        // rule cycle_count;
        //     counter <= counter + 1;
        // endrule

        rule rl_generate_partials (mode_r != 'h0);
            let mac_i = mac_inputs.first();
            //partial_product.enq(tuple5(tpl_1(generate_partials(tpl_1(mac_i), tpl_2(mac_i))), tpl_2(generate_partials(tpl_1(mac_i), tpl_2(mac_i))), tpl_3(generate_partials(tpl_1(mac_i), tpl_2(mac_i))), tpl_4(generate_partials(tpl_1(mac_i), tpl_2(mac_i))), tpl_3(mac_i)));
            for (int i = 0; i < 2; i = i + 1) begin
                for (int j = 0; j < 2; j = j + 1) begin
                    partial[2*i+j] <= (Bit#(32) extend(tpl_1(mac_i)[15+16*i:16*i]))*(Bit#(32) extend(tpl_2(mac_i)[15+16*j:16*j]));
                end
            end
            partial_product.enq(tuple5(partial[3], partial[2], partial[1], partial[0], tpl_3(mac_i)));
            mac_inputs.deq();
        endrule: rl_generate_partials

        rule rl_mac_32 (mode_r == 'h2);
            let pp = partial_product.first();
            mac_output.enq(add_partials(pp));
            partial_product.deq();
        endrule: rl_mac_32

        rule rl_mac_16 (mode_r == 'h1);
            let mac16 = partial_product.first();
            mac_output.enq({tpl_4(mac16) + (Bit#(32) extend(tpl_5(mac16)[31:16])), tpl_1(mac16) + (Bit#(32) extend(tpl_5(mac16)[15:0]))});
            partial_product.deq();
        endrule: rl_mac_16

        rule rl_mac_8 (mode_r == 'h0);
            let mac_i = mac_inputs.first();
            for (int i = 0; i < 4; i = i + 1) begin
                mac8[i] <= (Bit#(16) extend(tpl_1(mac_i)[7+8*i:8*i]))*(Bit#(16) extend(tpl_2(mac_i)[7+8*i:8*i])) + (Bit#(16) extend(tpl_3(mac_i)[7+8*i:8*i]));
            end
            mac_output.enq({mac8[3], mac8[2], mac8[1], mac8[0]});
            mac_inputs.deq();
        endrule: rl_mac_8

        method Action get_inputs(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend, Bit#(2) mode);
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