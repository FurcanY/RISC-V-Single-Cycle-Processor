// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Valu_tb_deneme__Syms.h"


VL_ATTR_COLD void Valu_tb_deneme___024root__trace_init_sub__TOP__0(Valu_tb_deneme___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushNamePrefix("alu_tb_deneme ");
    tracep->declBus(c+7,"source_a", false,-1, 31,0);
    tracep->declBus(c+8,"source_b", false,-1, 31,0);
    tracep->declBus(c+9,"alu_control", false,-1, 3,0);
    tracep->declBus(c+1,"alu_result", false,-1, 31,0);
    tracep->declBit(c+2,"zero_flag", false,-1);
    tracep->declBit(c+3,"negative_flag", false,-1);
    tracep->declBit(c+4,"carry_flag", false,-1);
    tracep->declBit(c+10,"overflow_flag", false,-1);
    tracep->pushNamePrefix("dut ");
    tracep->declBus(c+7,"source_a", false,-1, 31,0);
    tracep->declBus(c+8,"source_b", false,-1, 31,0);
    tracep->declBus(c+9,"alu_control", false,-1, 3,0);
    tracep->declBus(c+1,"alu_result", false,-1, 31,0);
    tracep->declBit(c+2,"zero_flag", false,-1);
    tracep->declBit(c+3,"negative_flag", false,-1);
    tracep->declBit(c+4,"carry_flag", false,-1);
    tracep->declBit(c+10,"overflow_flag", false,-1);
    tracep->declQuad(c+5,"temp_result", false,-1, 32,0);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Valu_tb_deneme___024root__trace_init_sub__TOP__riscv_pkg__0(Valu_tb_deneme___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_init_sub__TOP__riscv_pkg__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+11,"XLEN", false,-1, 31,0);
    tracep->declBus(c+12,"REG_ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+13,"MEM_SIZE", false,-1, 31,0);
    tracep->declBus(c+14,"OPCODE_LUI", false,-1, 6,0);
    tracep->declBus(c+15,"OPCODE_AUIPC", false,-1, 6,0);
    tracep->declBus(c+16,"OPCODE_JAL", false,-1, 6,0);
    tracep->declBus(c+17,"OPCODE_JALR", false,-1, 6,0);
    tracep->declBus(c+18,"OPCODE_BRANCH", false,-1, 6,0);
    tracep->declBus(c+19,"OPCODE_LOAD", false,-1, 6,0);
    tracep->declBus(c+20,"OPCODE_STORE", false,-1, 6,0);
    tracep->declBus(c+21,"OPCODE_I_TYPE", false,-1, 6,0);
    tracep->declBus(c+22,"OPCODE_R_TYPE", false,-1, 6,0);
    tracep->declBus(c+23,"FUNCT3_JALR", false,-1, 2,0);
    tracep->declBus(c+23,"FUNCT3_BEQ", false,-1, 2,0);
    tracep->declBus(c+24,"FUNCT3_BNE", false,-1, 2,0);
    tracep->declBus(c+25,"FUNCT3_BLT", false,-1, 2,0);
    tracep->declBus(c+26,"FUNCT3_BGE", false,-1, 2,0);
    tracep->declBus(c+27,"FUNCT3_BLTU", false,-1, 2,0);
    tracep->declBus(c+28,"FUNCT3_BGEU", false,-1, 2,0);
    tracep->declBus(c+23,"FUNCT3_LB", false,-1, 2,0);
    tracep->declBus(c+24,"FUNCT3_LH", false,-1, 2,0);
    tracep->declBus(c+29,"FUNCT3_LW", false,-1, 2,0);
    tracep->declBus(c+25,"FUNCT3_LBU", false,-1, 2,0);
    tracep->declBus(c+26,"FUNCT3_LHU", false,-1, 2,0);
    tracep->declBus(c+23,"FUNCT3_SB", false,-1, 2,0);
    tracep->declBus(c+24,"FUNCT3_SH", false,-1, 2,0);
    tracep->declBus(c+29,"FUNCT3_SW", false,-1, 2,0);
    tracep->declBus(c+23,"FUNCT3_ADDI", false,-1, 2,0);
    tracep->declBus(c+29,"FUNCT3_SLTI", false,-1, 2,0);
    tracep->declBus(c+30,"FUNCT3_SLTIU", false,-1, 2,0);
    tracep->declBus(c+25,"FUNCT3_XORI", false,-1, 2,0);
    tracep->declBus(c+27,"FUNCT3_ORI", false,-1, 2,0);
    tracep->declBus(c+28,"FUNCT3_ANDI", false,-1, 2,0);
    tracep->declBus(c+24,"FUNCT3_SLLI", false,-1, 2,0);
    tracep->declBus(c+26,"FUNCT3_SRLI", false,-1, 2,0);
    tracep->declBus(c+26,"FUNCT3_SRAI", false,-1, 2,0);
    tracep->declBus(c+23,"FUNCT3_ADD", false,-1, 2,0);
    tracep->declBus(c+23,"FUNCT3_SUB", false,-1, 2,0);
    tracep->declBus(c+24,"FUNCT3_SLL", false,-1, 2,0);
    tracep->declBus(c+29,"FUNCT3_SLT", false,-1, 2,0);
    tracep->declBus(c+30,"FUNCT3_SLTU", false,-1, 2,0);
    tracep->declBus(c+25,"FUNCT3_XOR", false,-1, 2,0);
    tracep->declBus(c+26,"FUNCT3_SRL", false,-1, 2,0);
    tracep->declBus(c+26,"FUNCT3_SRA", false,-1, 2,0);
    tracep->declBus(c+27,"FUNCT3_OR", false,-1, 2,0);
    tracep->declBus(c+28,"FUNCT3_AND", false,-1, 2,0);
    tracep->declBus(c+31,"FUNCT7_SLLI", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_SRLI", false,-1, 6,0);
    tracep->declBus(c+32,"FUNCT7_SRAI", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_ADD", false,-1, 6,0);
    tracep->declBus(c+32,"FUNCT7_SUB", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_SLT", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_SLL", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_SLTU", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_XOR", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_SRL", false,-1, 6,0);
    tracep->declBus(c+32,"FUNCT7_SRA", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_OR", false,-1, 6,0);
    tracep->declBus(c+31,"FUNCT7_AND", false,-1, 6,0);
}

VL_ATTR_COLD void Valu_tb_deneme___024root__trace_init_top(Valu_tb_deneme___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_init_top\n"); );
    // Body
    Valu_tb_deneme___024root__trace_init_sub__TOP__0(vlSelf, tracep);
    tracep->pushNamePrefix("riscv_pkg ");
    Valu_tb_deneme___024root__trace_init_sub__TOP__riscv_pkg__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void Valu_tb_deneme___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Valu_tb_deneme___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Valu_tb_deneme___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Valu_tb_deneme___024root__trace_register(Valu_tb_deneme___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Valu_tb_deneme___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Valu_tb_deneme___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Valu_tb_deneme___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Valu_tb_deneme___024root__trace_full_sub_0(Valu_tb_deneme___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Valu_tb_deneme___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_full_top_0\n"); );
    // Init
    Valu_tb_deneme___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu_tb_deneme___024root*>(voidSelf);
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Valu_tb_deneme___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Valu_tb_deneme___024root__trace_full_sub_0(Valu_tb_deneme___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,((IData)(vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result)),32);
    bufp->fullBit(oldp+2,(((0ULL == vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result)
                            ? 1U : 0U)));
    bufp->fullBit(oldp+3,((1U & (IData)((vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
                                         >> 0x1fU)))));
    bufp->fullBit(oldp+4,((1U & (IData)((vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
                                         >> 0x20U)))));
    bufp->fullQData(oldp+5,(vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result),33);
    bufp->fullIData(oldp+7,(vlSelf->alu_tb_deneme__DOT__source_a),32);
    bufp->fullIData(oldp+8,(vlSelf->alu_tb_deneme__DOT__source_b),32);
    bufp->fullCData(oldp+9,(vlSelf->alu_tb_deneme__DOT__alu_control),4);
    bufp->fullBit(oldp+10,(((1U & (((vlSelf->alu_tb_deneme__DOT__source_a 
                                     & vlSelf->alu_tb_deneme__DOT__source_b) 
                                    >> 0x1fU) & (~ (IData)(
                                                           (vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
                                                            >> 0x1fU)))))
                             ? 1U : ((1U & (((~ (vlSelf->alu_tb_deneme__DOT__source_a 
                                                 >> 0x1fU)) 
                                             & (~ (vlSelf->alu_tb_deneme__DOT__source_b 
                                                   >> 0x1fU))) 
                                            & (IData)(
                                                      (vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
                                                       >> 0x1fU))))
                                      ? 1U : 0U))));
    bufp->fullIData(oldp+11,(0x20U),32);
    bufp->fullIData(oldp+12,(5U),32);
    bufp->fullIData(oldp+13,(0x400U),32);
    bufp->fullCData(oldp+14,(0x37U),7);
    bufp->fullCData(oldp+15,(0x17U),7);
    bufp->fullCData(oldp+16,(0x6fU),7);
    bufp->fullCData(oldp+17,(0x67U),7);
    bufp->fullCData(oldp+18,(0x63U),7);
    bufp->fullCData(oldp+19,(3U),7);
    bufp->fullCData(oldp+20,(0x23U),7);
    bufp->fullCData(oldp+21,(0x13U),7);
    bufp->fullCData(oldp+22,(0x33U),7);
    bufp->fullCData(oldp+23,(0U),3);
    bufp->fullCData(oldp+24,(1U),3);
    bufp->fullCData(oldp+25,(4U),3);
    bufp->fullCData(oldp+26,(5U),3);
    bufp->fullCData(oldp+27,(6U),3);
    bufp->fullCData(oldp+28,(7U),3);
    bufp->fullCData(oldp+29,(2U),3);
    bufp->fullCData(oldp+30,(3U),3);
    bufp->fullCData(oldp+31,(0U),7);
    bufp->fullCData(oldp+32,(0x20U),7);
}
