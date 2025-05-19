// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu_tb.h for the primary calling header

#include "verilated.h"

#include "Valu_tb__Syms.h"
#include "Valu_tb___024root.h"

VL_ATTR_COLD void Valu_tb___024root___eval_initial__TOP(Valu_tb___024root* vlSelf);
VlCoroutine Valu_tb___024root___eval_initial__TOP__0(Valu_tb___024root* vlSelf);

void Valu_tb___024root___eval_initial(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___eval_initial\n"); );
    // Body
    Valu_tb___024root___eval_initial__TOP(vlSelf);
    vlSelf->__Vm_traceActivity[1U] = 1U;
    Valu_tb___024root___eval_initial__TOP__0(vlSelf);
}

VL_INLINE_OPT void Valu_tb___024root___act_sequent__TOP__0(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___act_sequent__TOP__0\n"); );
    // Body
    vlSelf->alu_tb__DOT__dut__DOT__temp_result = 0ULL;
    vlSelf->alu_tb__DOT__alu_result = 0U;
    vlSelf->alu_tb__DOT__carry_flag = 0U;
    vlSelf->alu_tb__DOT__overflow_flag = 0U;
    if ((8U & (IData)(vlSelf->alu_tb__DOT__alu_control))) {
        vlSelf->alu_tb__DOT__alu_result = ((4U & (IData)(vlSelf->alu_tb__DOT__alu_control))
                                            ? 0U : 
                                           ((2U & (IData)(vlSelf->alu_tb__DOT__alu_control))
                                             ? 0U : 
                                            ((1U & (IData)(vlSelf->alu_tb__DOT__alu_control))
                                              ? ((vlSelf->alu_tb__DOT__source_a 
                                                  < vlSelf->alu_tb__DOT__source_b)
                                                  ? 1U
                                                  : 0U)
                                              : (VL_LTS_III(32, vlSelf->alu_tb__DOT__source_a, vlSelf->alu_tb__DOT__source_b)
                                                  ? 1U
                                                  : 0U))));
    } else if ((4U & (IData)(vlSelf->alu_tb__DOT__alu_control))) {
        vlSelf->alu_tb__DOT__alu_result = ((2U & (IData)(vlSelf->alu_tb__DOT__alu_control))
                                            ? ((1U 
                                                & (IData)(vlSelf->alu_tb__DOT__alu_control))
                                                ? VL_SHIFTRS_III(32,32,5, vlSelf->alu_tb__DOT__source_a, 
                                                                 (0x1fU 
                                                                  & vlSelf->alu_tb__DOT__source_b))
                                                : (vlSelf->alu_tb__DOT__source_a 
                                                   >> 
                                                   (0x1fU 
                                                    & vlSelf->alu_tb__DOT__source_b)))
                                            : ((1U 
                                                & (IData)(vlSelf->alu_tb__DOT__alu_control))
                                                ? (vlSelf->alu_tb__DOT__source_a 
                                                   << 
                                                   (0x1fU 
                                                    & vlSelf->alu_tb__DOT__source_b))
                                                : (vlSelf->alu_tb__DOT__source_a 
                                                   ^ vlSelf->alu_tb__DOT__source_b)));
    } else if ((2U & (IData)(vlSelf->alu_tb__DOT__alu_control))) {
        vlSelf->alu_tb__DOT__alu_result = ((1U & (IData)(vlSelf->alu_tb__DOT__alu_control))
                                            ? (vlSelf->alu_tb__DOT__source_a 
                                               | vlSelf->alu_tb__DOT__source_b)
                                            : (vlSelf->alu_tb__DOT__source_a 
                                               & vlSelf->alu_tb__DOT__source_b));
    } else if ((1U & (IData)(vlSelf->alu_tb__DOT__alu_control))) {
        vlSelf->alu_tb__DOT__dut__DOT__temp_result 
            = (0x1ffffffffULL & ((QData)((IData)(vlSelf->alu_tb__DOT__source_a)) 
                                 - (QData)((IData)(vlSelf->alu_tb__DOT__source_b))));
        vlSelf->alu_tb__DOT__alu_result = (IData)(vlSelf->alu_tb__DOT__dut__DOT__temp_result);
        vlSelf->alu_tb__DOT__carry_flag = (1U & (IData)(
                                                        (vlSelf->alu_tb__DOT__dut__DOT__temp_result 
                                                         >> 0x20U)));
        vlSelf->alu_tb__DOT__overflow_flag = (((vlSelf->alu_tb__DOT__source_a 
                                                >> 0x1fU) 
                                               != (vlSelf->alu_tb__DOT__source_b 
                                                   >> 0x1fU)) 
                                              & ((vlSelf->alu_tb__DOT__alu_result 
                                                  >> 0x1fU) 
                                                 != 
                                                 (vlSelf->alu_tb__DOT__source_a 
                                                  >> 0x1fU)));
    } else {
        vlSelf->alu_tb__DOT__dut__DOT__temp_result 
            = (0x1ffffffffULL & ((QData)((IData)(vlSelf->alu_tb__DOT__source_a)) 
                                 + (QData)((IData)(vlSelf->alu_tb__DOT__source_b))));
        vlSelf->alu_tb__DOT__alu_result = (IData)(vlSelf->alu_tb__DOT__dut__DOT__temp_result);
        vlSelf->alu_tb__DOT__carry_flag = (1U & (IData)(
                                                        (vlSelf->alu_tb__DOT__dut__DOT__temp_result 
                                                         >> 0x20U)));
        vlSelf->alu_tb__DOT__overflow_flag = (((vlSelf->alu_tb__DOT__source_a 
                                                >> 0x1fU) 
                                               == (vlSelf->alu_tb__DOT__source_b 
                                                   >> 0x1fU)) 
                                              & ((vlSelf->alu_tb__DOT__alu_result 
                                                  >> 0x1fU) 
                                                 != 
                                                 (vlSelf->alu_tb__DOT__source_a 
                                                  >> 0x1fU)));
    }
    vlSelf->alu_tb__DOT__zero_flag = (0U == vlSelf->alu_tb__DOT__alu_result);
    vlSelf->alu_tb__DOT__negative_flag = (vlSelf->alu_tb__DOT__alu_result 
                                          >> 0x1fU);
}

void Valu_tb___024root___eval_act(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___eval_act\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        Valu_tb___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[3U] = 1U;
    }
}

void Valu_tb___024root___eval_nba(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Valu_tb___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[4U] = 1U;
    }
}

void Valu_tb___024root___eval_triggers__act(Valu_tb___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb___024root___dump_triggers__act(Valu_tb___024root* vlSelf);
#endif  // VL_DEBUG
void Valu_tb___024root___timing_resume(Valu_tb___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb___024root___dump_triggers__nba(Valu_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Valu_tb___024root___eval(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___eval\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Valu_tb___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Valu_tb___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("tb/alu_tb.sv", 5, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                Valu_tb___024root___timing_resume(vlSelf);
                Valu_tb___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Valu_tb___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("tb/alu_tb.sv", 5, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Valu_tb___024root___eval_nba(vlSelf);
        }
    }
}

void Valu_tb___024root___timing_resume(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___timing_resume\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

#ifdef VL_DEBUG
void Valu_tb___024root___eval_debug_assertions(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
