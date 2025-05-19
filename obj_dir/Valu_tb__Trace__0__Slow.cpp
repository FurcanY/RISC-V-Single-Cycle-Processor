// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Valu_tb__Syms.h"


VL_ATTR_COLD void Valu_tb___024root__trace_init_sub__TOP__0(Valu_tb___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushNamePrefix("alu_tb ");
    tracep->declBus(c+1,"source_a", false,-1, 31,0);
    tracep->declBus(c+2,"source_b", false,-1, 31,0);
    tracep->declBus(c+3,"alu_control", false,-1, 3,0);
    tracep->declBus(c+14,"alu_result", false,-1, 31,0);
    tracep->declBit(c+15,"zero_flag", false,-1);
    tracep->declBit(c+16,"negative_flag", false,-1);
    tracep->declBit(c+17,"carry_flag", false,-1);
    tracep->declBit(c+18,"overflow_flag", false,-1);
    tracep->declBus(c+4,"expected_result", false,-1, 31,0);
    tracep->declBit(c+5,"expected_zero", false,-1);
    tracep->declBit(c+6,"expected_negative", false,-1);
    tracep->declBit(c+7,"expected_carry", false,-1);
    tracep->declBit(c+8,"expected_overflow", false,-1);
    tracep->declBus(c+9,"op_val", false,-1, 31,0);
    tracep->declBus(c+10,"file", false,-1, 31,0);
    tracep->declBus(c+11,"r", false,-1, 31,0);
    tracep->declBus(c+12,"line", false,-1, 31,0);
    tracep->declBus(c+13,"error_count", false,-1, 31,0);
    tracep->pushNamePrefix("dut ");
    tracep->declBus(c+1,"source_a", false,-1, 31,0);
    tracep->declBus(c+2,"source_b", false,-1, 31,0);
    tracep->declBus(c+3,"alu_control", false,-1, 3,0);
    tracep->declBus(c+14,"alu_result", false,-1, 31,0);
    tracep->declBit(c+15,"zero_flag", false,-1);
    tracep->declBit(c+16,"negative_flag", false,-1);
    tracep->declBit(c+17,"carry_flag", false,-1);
    tracep->declBit(c+18,"overflow_flag", false,-1);
    tracep->declQuad(c+19,"temp_result", false,-1, 32,0);
    tracep->popNamePrefix(2);
}

VL_ATTR_COLD void Valu_tb___024root__trace_init_sub__TOP__riscv_pkg__0(Valu_tb___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_init_sub__TOP__riscv_pkg__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+21,"XLEN", false,-1, 31,0);
    tracep->declBus(c+22,"REG_ADDR_WIDTH", false,-1, 31,0);
    tracep->declBus(c+23,"MEM_SIZE", false,-1, 31,0);
    tracep->declBus(c+24,"OPCODE_LUI", false,-1, 6,0);
    tracep->declBus(c+25,"OPCODE_AUIPC", false,-1, 6,0);
    tracep->declBus(c+26,"OPCODE_JAL", false,-1, 6,0);
    tracep->declBus(c+27,"OPCODE_JALR", false,-1, 6,0);
    tracep->declBus(c+28,"OPCODE_BRANCH", false,-1, 6,0);
    tracep->declBus(c+29,"OPCODE_LOAD", false,-1, 6,0);
    tracep->declBus(c+30,"OPCODE_STORE", false,-1, 6,0);
    tracep->declBus(c+31,"OPCODE_I_TYPE", false,-1, 6,0);
    tracep->declBus(c+32,"OPCODE_R_TYPE", false,-1, 6,0);
    tracep->declBus(c+33,"FUNCT3_JALR", false,-1, 2,0);
    tracep->declBus(c+33,"FUNCT3_BEQ", false,-1, 2,0);
    tracep->declBus(c+34,"FUNCT3_BNE", false,-1, 2,0);
    tracep->declBus(c+35,"FUNCT3_BLT", false,-1, 2,0);
    tracep->declBus(c+36,"FUNCT3_BGE", false,-1, 2,0);
    tracep->declBus(c+37,"FUNCT3_BLTU", false,-1, 2,0);
    tracep->declBus(c+38,"FUNCT3_BGEU", false,-1, 2,0);
    tracep->declBus(c+33,"FUNCT3_LB", false,-1, 2,0);
    tracep->declBus(c+34,"FUNCT3_LH", false,-1, 2,0);
    tracep->declBus(c+39,"FUNCT3_LW", false,-1, 2,0);
    tracep->declBus(c+35,"FUNCT3_LBU", false,-1, 2,0);
    tracep->declBus(c+36,"FUNCT3_LHU", false,-1, 2,0);
    tracep->declBus(c+33,"FUNCT3_SB", false,-1, 2,0);
    tracep->declBus(c+34,"FUNCT3_SH", false,-1, 2,0);
    tracep->declBus(c+39,"FUNCT3_SW", false,-1, 2,0);
    tracep->declBus(c+33,"FUNCT3_ADDI", false,-1, 2,0);
    tracep->declBus(c+39,"FUNCT3_SLTI", false,-1, 2,0);
    tracep->declBus(c+40,"FUNCT3_SLTIU", false,-1, 2,0);
    tracep->declBus(c+35,"FUNCT3_XORI", false,-1, 2,0);
    tracep->declBus(c+37,"FUNCT3_ORI", false,-1, 2,0);
    tracep->declBus(c+38,"FUNCT3_ANDI", false,-1, 2,0);
    tracep->declBus(c+34,"FUNCT3_SLLI", false,-1, 2,0);
    tracep->declBus(c+36,"FUNCT3_SRLI", false,-1, 2,0);
    tracep->declBus(c+36,"FUNCT3_SRAI", false,-1, 2,0);
    tracep->declBus(c+33,"FUNCT3_ADD", false,-1, 2,0);
    tracep->declBus(c+33,"FUNCT3_SUB", false,-1, 2,0);
    tracep->declBus(c+34,"FUNCT3_SLL", false,-1, 2,0);
    tracep->declBus(c+39,"FUNCT3_SLT", false,-1, 2,0);
    tracep->declBus(c+40,"FUNCT3_SLTU", false,-1, 2,0);
    tracep->declBus(c+35,"FUNCT3_XOR", false,-1, 2,0);
    tracep->declBus(c+36,"FUNCT3_SRL", false,-1, 2,0);
    tracep->declBus(c+36,"FUNCT3_SRA", false,-1, 2,0);
    tracep->declBus(c+37,"FUNCT3_OR", false,-1, 2,0);
    tracep->declBus(c+38,"FUNCT3_AND", false,-1, 2,0);
    tracep->declBus(c+41,"FUNCT7_SLLI", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_SRLI", false,-1, 6,0);
    tracep->declBus(c+42,"FUNCT7_SRAI", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_ADD", false,-1, 6,0);
    tracep->declBus(c+42,"FUNCT7_SUB", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_SLT", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_SLL", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_SLTU", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_XOR", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_SRL", false,-1, 6,0);
    tracep->declBus(c+42,"FUNCT7_SRA", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_OR", false,-1, 6,0);
    tracep->declBus(c+41,"FUNCT7_AND", false,-1, 6,0);
}

VL_ATTR_COLD void Valu_tb___024root__trace_init_top(Valu_tb___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_init_top\n"); );
    // Body
    Valu_tb___024root__trace_init_sub__TOP__0(vlSelf, tracep);
    tracep->pushNamePrefix("riscv_pkg ");
    Valu_tb___024root__trace_init_sub__TOP__riscv_pkg__0(vlSelf, tracep);
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void Valu_tb___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Valu_tb___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Valu_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Valu_tb___024root__trace_register(Valu_tb___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Valu_tb___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Valu_tb___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Valu_tb___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Valu_tb___024root__trace_full_sub_0(Valu_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Valu_tb___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_full_top_0\n"); );
    // Init
    Valu_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu_tb___024root*>(voidSelf);
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Valu_tb___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Valu_tb___024root__trace_full_sub_0(Valu_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,(vlSelf->alu_tb__DOT__source_a),32);
    bufp->fullIData(oldp+2,(vlSelf->alu_tb__DOT__source_b),32);
    bufp->fullCData(oldp+3,(vlSelf->alu_tb__DOT__alu_control),4);
    bufp->fullIData(oldp+4,(vlSelf->alu_tb__DOT__expected_result),32);
    bufp->fullBit(oldp+5,(vlSelf->alu_tb__DOT__expected_zero));
    bufp->fullBit(oldp+6,(vlSelf->alu_tb__DOT__expected_negative));
    bufp->fullBit(oldp+7,(vlSelf->alu_tb__DOT__expected_carry));
    bufp->fullBit(oldp+8,(vlSelf->alu_tb__DOT__expected_overflow));
    bufp->fullIData(oldp+9,(vlSelf->alu_tb__DOT__op_val),32);
    bufp->fullIData(oldp+10,(vlSelf->alu_tb__DOT__file),32);
    bufp->fullIData(oldp+11,(vlSelf->alu_tb__DOT__r),32);
    bufp->fullIData(oldp+12,(vlSelf->alu_tb__DOT__line),32);
    bufp->fullIData(oldp+13,(vlSelf->alu_tb__DOT__error_count),32);
    bufp->fullIData(oldp+14,(vlSelf->alu_tb__DOT__alu_result),32);
    bufp->fullBit(oldp+15,(vlSelf->alu_tb__DOT__zero_flag));
    bufp->fullBit(oldp+16,(vlSelf->alu_tb__DOT__negative_flag));
    bufp->fullBit(oldp+17,(vlSelf->alu_tb__DOT__carry_flag));
    bufp->fullBit(oldp+18,(vlSelf->alu_tb__DOT__overflow_flag));
    bufp->fullQData(oldp+19,(vlSelf->alu_tb__DOT__dut__DOT__temp_result),33);
    bufp->fullIData(oldp+21,(0x20U),32);
    bufp->fullIData(oldp+22,(5U),32);
    bufp->fullIData(oldp+23,(0x400U),32);
    bufp->fullCData(oldp+24,(0x37U),7);
    bufp->fullCData(oldp+25,(0x17U),7);
    bufp->fullCData(oldp+26,(0x6fU),7);
    bufp->fullCData(oldp+27,(0x67U),7);
    bufp->fullCData(oldp+28,(0x63U),7);
    bufp->fullCData(oldp+29,(3U),7);
    bufp->fullCData(oldp+30,(0x23U),7);
    bufp->fullCData(oldp+31,(0x13U),7);
    bufp->fullCData(oldp+32,(0x33U),7);
    bufp->fullCData(oldp+33,(0U),3);
    bufp->fullCData(oldp+34,(1U),3);
    bufp->fullCData(oldp+35,(4U),3);
    bufp->fullCData(oldp+36,(5U),3);
    bufp->fullCData(oldp+37,(6U),3);
    bufp->fullCData(oldp+38,(7U),3);
    bufp->fullCData(oldp+39,(2U),3);
    bufp->fullCData(oldp+40,(3U),3);
    bufp->fullCData(oldp+41,(0U),7);
    bufp->fullCData(oldp+42,(0x20U),7);
}
