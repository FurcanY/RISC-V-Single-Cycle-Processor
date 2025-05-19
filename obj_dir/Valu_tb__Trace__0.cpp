// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Valu_tb__Syms.h"


void Valu_tb___024root__trace_chg_sub_0(Valu_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Valu_tb___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_chg_top_0\n"); );
    // Init
    Valu_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu_tb___024root*>(voidSelf);
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Valu_tb___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Valu_tb___024root__trace_chg_sub_0(Valu_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[2U]))) {
        bufp->chgIData(oldp+0,(vlSelf->alu_tb__DOT__source_a),32);
        bufp->chgIData(oldp+1,(vlSelf->alu_tb__DOT__source_b),32);
        bufp->chgCData(oldp+2,(vlSelf->alu_tb__DOT__alu_control),4);
        bufp->chgIData(oldp+3,(vlSelf->alu_tb__DOT__expected_result),32);
        bufp->chgBit(oldp+4,(vlSelf->alu_tb__DOT__expected_zero));
        bufp->chgBit(oldp+5,(vlSelf->alu_tb__DOT__expected_negative));
        bufp->chgBit(oldp+6,(vlSelf->alu_tb__DOT__expected_carry));
        bufp->chgBit(oldp+7,(vlSelf->alu_tb__DOT__expected_overflow));
        bufp->chgIData(oldp+8,(vlSelf->alu_tb__DOT__op_val),32);
        bufp->chgIData(oldp+9,(vlSelf->alu_tb__DOT__file),32);
        bufp->chgIData(oldp+10,(vlSelf->alu_tb__DOT__r),32);
        bufp->chgIData(oldp+11,(vlSelf->alu_tb__DOT__line),32);
        bufp->chgIData(oldp+12,(vlSelf->alu_tb__DOT__error_count),32);
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[3U] 
                     | vlSelf->__Vm_traceActivity[4U]))) {
        bufp->chgIData(oldp+13,(vlSelf->alu_tb__DOT__alu_result),32);
        bufp->chgBit(oldp+14,(vlSelf->alu_tb__DOT__zero_flag));
        bufp->chgBit(oldp+15,(vlSelf->alu_tb__DOT__negative_flag));
        bufp->chgBit(oldp+16,(vlSelf->alu_tb__DOT__carry_flag));
        bufp->chgBit(oldp+17,(vlSelf->alu_tb__DOT__overflow_flag));
        bufp->chgQData(oldp+18,(vlSelf->alu_tb__DOT__dut__DOT__temp_result),33);
    }
}

void Valu_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root__trace_cleanup\n"); );
    // Init
    Valu_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu_tb___024root*>(voidSelf);
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
}
