// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Valu_tb_deneme__Syms.h"


void Valu_tb_deneme___024root__trace_chg_sub_0(Valu_tb_deneme___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Valu_tb_deneme___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_chg_top_0\n"); );
    // Init
    Valu_tb_deneme___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu_tb_deneme___024root*>(voidSelf);
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Valu_tb_deneme___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Valu_tb_deneme___024root__trace_chg_sub_0(Valu_tb_deneme___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[2U]))) {
        bufp->chgIData(oldp+0,((IData)(vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result)),32);
        bufp->chgBit(oldp+1,(((0ULL == vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result)
                               ? 1U : 0U)));
        bufp->chgBit(oldp+2,((1U & (IData)((vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
                                            >> 0x1fU)))));
        bufp->chgBit(oldp+3,((1U & (IData)((vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
                                            >> 0x20U)))));
        bufp->chgQData(oldp+4,(vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result),33);
    }
    bufp->chgIData(oldp+6,(vlSelf->alu_tb_deneme__DOT__source_a),32);
    bufp->chgIData(oldp+7,(vlSelf->alu_tb_deneme__DOT__source_b),32);
    bufp->chgCData(oldp+8,(vlSelf->alu_tb_deneme__DOT__alu_control),4);
    bufp->chgBit(oldp+9,(((1U & (((vlSelf->alu_tb_deneme__DOT__source_a 
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
}

void Valu_tb_deneme___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root__trace_cleanup\n"); );
    // Init
    Valu_tb_deneme___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu_tb_deneme___024root*>(voidSelf);
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
}
