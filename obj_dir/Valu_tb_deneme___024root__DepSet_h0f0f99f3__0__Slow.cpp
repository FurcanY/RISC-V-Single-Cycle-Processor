// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu_tb_deneme.h for the primary calling header

#include "verilated.h"

#include "Valu_tb_deneme__Syms.h"
#include "Valu_tb_deneme___024root.h"

VL_ATTR_COLD void Valu_tb_deneme___024root___eval_static(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_static\n"); );
}

VL_ATTR_COLD void Valu_tb_deneme___024root___eval_final(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_final\n"); );
}

VL_ATTR_COLD void Valu_tb_deneme___024root___eval_triggers__stl(Valu_tb_deneme___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb_deneme___024root___dump_triggers__stl(Valu_tb_deneme___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void Valu_tb_deneme___024root___eval_stl(Valu_tb_deneme___024root* vlSelf);

VL_ATTR_COLD void Valu_tb_deneme___024root___eval_settle(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        Valu_tb_deneme___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                Valu_tb_deneme___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("tb/alu_tb_deneme.sv", 1, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            Valu_tb_deneme___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb_deneme___024root___dump_triggers__stl(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

void Valu_tb_deneme___024root___act_sequent__TOP__0(Valu_tb_deneme___024root* vlSelf);

VL_ATTR_COLD void Valu_tb_deneme___024root___eval_stl(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Valu_tb_deneme___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb_deneme___024root___dump_triggers__act(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb_deneme___024root___dump_triggers__nba(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Valu_tb_deneme___024root___ctor_var_reset(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->alu_tb_deneme__DOT__source_a = VL_RAND_RESET_I(32);
    vlSelf->alu_tb_deneme__DOT__source_b = VL_RAND_RESET_I(32);
    vlSelf->alu_tb_deneme__DOT__alu_control = VL_RAND_RESET_I(4);
    vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result = VL_RAND_RESET_Q(33);
    for (int __Vi0 = 0; __Vi0 < 3; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
