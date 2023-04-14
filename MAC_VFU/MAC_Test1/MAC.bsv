package MAC;

import mac8::*;
import mac16::*;
import mac322p::*;
import mac642p::*;

interface Ifc_MAC;
    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(2) mode);
    method ActionValue#(Bit#(128)) mac_result();
endinterface: Ifc_MAC

(*synthesize*)
module mkMAC(Ifc_MAC);

    // Registers for Inputs
    Reg#(Bit#(64)) m1 <- mkReg(0);
    Reg#(Bit#(64)) m2 <- mkReg(0);
    Reg#(Bit#(64)) a <- mkReg(0);

    // Register for MAC Result
    Reg#(Bit#(128)) resmac <- mkReg(0);

    // Ready Signal
    Reg#(Bit#(2)) isReady <- mkRegA(0);
    
    // Mode of Operation of the VFU
    Reg#(Bit#(2)) reg_mode <- mkReg(0);

    // 64-Bit MAC
    Ifc_mac642p mac_64b <- mkmac642p;

    // 32-Bit MAC
    Ifc_mac322p mac_32b <- mkmac322p;

    // 16-Bit MAC
    Ifc_mac16 mac_16b_1 <- mkmac16;
    Ifc_mac16 mac_16b_2 <- mkmac16;
    
    // 8-Bit MAC
    Ifc_mac8 mac_8b_1 <- mkmac8;
    Ifc_mac8 mac_8b_2 <- mkmac8;
    Ifc_mac8 mac_8b_3 <- mkmac8;
    Ifc_mac8 mac_8b_4 <- mkmac8;

    rule compute_MAC (isReady == 1);
        case (reg_mode)
            0: begin
                mac_64b.get_values(m1, m2, a);
                isReady <= 2;
            end
            1: begin
                mac_64b.get_values(extend(m1[31:0]), extend(m2[31:0]), extend(a[31:0]));
                mac_32b.get_values(m1[63:32], m2[63:32], a[63:32]);
                isReady <= 2;
            end
            2: begin
                mac_64b.get_values(extend(m1[15:0]), extend(m2[15:0]), extend(a[15:0]));
                mac_32b.get_values(extend(m1[31:16]), extend(m2[31:16]), extend(a[31:16]));
                mac_16b_1.get_values(m1[47:32], m2[47:32], a[47:32]);
                mac_16b_2.get_values(m1[63:48], m2[63:48], a[63:48]);
                isReady <= 2;
            end
            3: begin
                mac_64b.get_values(extend(m1[7:0]), extend(m2[7:0]), extend(a[7:0]));
                mac_32b.get_values(extend(m1[15:8]), extend(m2[15:8]), extend(a[15:8]));
                mac_16b_1.get_values(extend(m1[23:16]), extend(m2[23:16]), extend(a[23:16]));
                mac_16b_2.get_values(extend(m1[31:24]), extend(m2[31:24]), extend(a[31:24]));
                mac_8b_1.get_values(m1[39:32], m2[39:32], a[39:32]);
                mac_8b_2.get_values(m1[47:40], m2[47:40], a[47:40]);
                mac_8b_3.get_values(m1[55:48], m2[55:48], a[55:48]);
                mac_8b_4.get_values(m1[63:56], m2[63:56], a[63:56]);
                isReady <= 2;
            end
            default: begin
                mac_64b.get_values(m1, m2, a);
                isReady <= 2;
            end
        endcase
    endrule: compute_MAC

    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(2) mode) if (isReady == 0);
        m1 <= multiplicand1;
        m2 <= multiplicand2;
        a <= addend;
        reg_mode <= mode;
        isReady <= 1;
    endmethod

    method ActionValue#(Bit#(128)) mac_result() if (isReady == 2);
        Bit#(128) final_mac_result = 0;
        case (reg_mode)
            0: begin
                final_mac_result = mac_64b.mac_result;
            end
            1: begin
                final_mac_result = {mac_32b.mac_result, mac_64b.mac_result[63:0]};
            end
            2: begin
                final_mac_result = {mac_16b_2.mac_result, mac_16b_1.mac_result, mac_32b.mac_result[31:0], mac_64b.mac_result[31:0]};
            end
            3: begin
                final_mac_result = {mac_8b_4.mac_result, mac_8b_3.mac_result, mac_8b_2.mac_result, mac_8b_1.mac_result, mac_16b_2.mac_result[15:0], mac_16b_1.mac_result[15:0], mac_32b.mac_result[15:0], mac_64b.mac_result[15:0]};
            end
            default: begin
                final_mac_result = mac_64b.mac_result;
            end
        endcase
        return final_mac_result;
    endmethod

endmodule
                
endpackage : MAC
    