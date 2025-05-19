// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu_tb_deneme.h for the primary calling header

#include "verilated.h"

#include "Valu_tb_deneme__Syms.h"
#include "Valu_tb_deneme___024root.h"

VlCoroutine Valu_tb_deneme___024root___eval_initial__TOP__0(Valu_tb_deneme___024root* vlSelf);

void Valu_tb_deneme___024root___eval_initial(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_initial\n"); );
    // Body
    Valu_tb_deneme___024root___eval_initial__TOP__0(vlSelf);
}

VL_INLINE_OPT VlCoroutine Valu_tb_deneme___024root___eval_initial__TOP__0(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_initial__TOP__0\n"); );
    // Body
    VL_WRITEF("deneme tb baslatiliyor\n");
    vlSelf->alu_tb_deneme__DOT__source_a = 0x64U;
    vlSelf->alu_tb_deneme__DOT__source_b = 0x64U;
    vlSelf->alu_tb_deneme__DOT__alu_control = 1U;
    co_await vlSelf->__VdlySched.delay(1ULL, nullptr, 
                                       "tb/alu_tb_deneme.sv", 
                                       32);
    if (VL_UNLIKELY((0U != (IData)(vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result)))) {
        VL_WRITEF("hata var dayi\n");
    }
    vlSelf->alu_tb_deneme__DOT__source_a = 0xfaU;
    vlSelf->alu_tb_deneme__DOT__source_b = 0xfaU;
    vlSelf->alu_tb_deneme__DOT__alu_control = 0U;
    co_await vlSelf->__VdlySched.delay(1ULL, nullptr, 
                                       "tb/alu_tb_deneme.sv", 
                                       40);
    if (VL_UNLIKELY((0x1f4U != (IData)(vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result)))) {
        VL_WRITEF("hata var dayi\n");
    }
}

VL_INLINE_OPT void Valu_tb_deneme___024root___act_sequent__TOP__0(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___act_sequent__TOP__0\n"); );
    // Body
    VL_WRITEF("ALU input => A: %x, B: %x, OP: %0#\n",
              32,vlSelf->alu_tb_deneme__DOT__source_a,
              32,vlSelf->alu_tb_deneme__DOT__source_b,
              4,(IData)(vlSelf->alu_tb_deneme__DOT__alu_control));
    if (((((((((0U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control)) 
               | (1U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))) 
              | (8U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))) 
             | (9U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))) 
            | (2U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))) 
           | (3U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))) 
          | (4U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))) 
         | (5U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control)))) {
        vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
            = (0x1ffffffffULL & ((0U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))
                                  ? ((QData)((IData)(vlSelf->alu_tb_deneme__DOT__source_a)) 
                                     + (QData)((IData)(vlSelf->alu_tb_deneme__DOT__source_b)))
                                  : ((1U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))
                                      ? ((QData)((IData)(vlSelf->alu_tb_deneme__DOT__source_a)) 
                                         - (QData)((IData)(vlSelf->alu_tb_deneme__DOT__source_b)))
                                      : ((8U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))
                                          ? (QData)((IData)(
                                                            VL_LTS_III(32, vlSelf->alu_tb_deneme__DOT__source_a, vlSelf->alu_tb_deneme__DOT__source_b)))
                                          : ((9U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))
                                              ? (QData)((IData)(
                                                                (vlSelf->alu_tb_deneme__DOT__source_a 
                                                                 < vlSelf->alu_tb_deneme__DOT__source_b)))
                                              : ((2U 
                                                  == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))
                                                  ? (QData)((IData)(
                                                                    (vlSelf->alu_tb_deneme__DOT__source_a 
                                                                     & vlSelf->alu_tb_deneme__DOT__source_b)))
                                                  : 
                                                 ((3U 
                                                   == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))
                                                   ? (QData)((IData)(
                                                                     (vlSelf->alu_tb_deneme__DOT__source_a 
                                                                      | vlSelf->alu_tb_deneme__DOT__source_b)))
                                                   : 
                                                  ((4U 
                                                    == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))
                                                    ? (QData)((IData)(
                                                                      (vlSelf->alu_tb_deneme__DOT__source_a 
                                                                       ^ vlSelf->alu_tb_deneme__DOT__source_b)))
                                                    : (QData)((IData)(
                                                                      (vlSelf->alu_tb_deneme__DOT__source_a 
                                                                       << 
                                                                       (0x1fU 
                                                                        & vlSelf->alu_tb_deneme__DOT__source_b))))))))))));
    } else if ((6U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))) {
        vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
            = (QData)((IData)((vlSelf->alu_tb_deneme__DOT__source_a 
                               >> (0x1fU & vlSelf->alu_tb_deneme__DOT__source_b))));
    } else if ((7U == (IData)(vlSelf->alu_tb_deneme__DOT__alu_control))) {
        vlSelf->alu_tb_deneme__DOT__dut__DOT__temp_result 
            = (QData)((IData)((vlSelf->alu_tb_deneme__DOT__source_a 
                               >> (0x1fU & vlSelf->alu_tb_deneme__DOT__source_b))));
    }
}

void Valu_tb_deneme___024root___eval_act(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_act\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        Valu_tb_deneme___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

void Valu_tb_deneme___024root___eval_nba(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Valu_tb_deneme___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
    }
}

void Valu_tb_deneme___024root___eval_triggers__act(Valu_tb_deneme___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb_deneme___024root___dump_triggers__act(Valu_tb_deneme___024root* vlSelf);
#endif  // VL_DEBUG
void Valu_tb_deneme___024root___timing_resume(Valu_tb_deneme___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb_deneme___024root___dump_triggers__nba(Valu_tb_deneme___024root* vlSelf);
#endif  // VL_DEBUG

void Valu_tb_deneme___024root___eval(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval\n"); );
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
            Valu_tb_deneme___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Valu_tb_deneme___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("tb/alu_tb_deneme.sv", 1, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                Valu_tb_deneme___024root___timing_resume(vlSelf);
                Valu_tb_deneme___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Valu_tb_deneme___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("tb/alu_tb_deneme.sv", 1, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Valu_tb_deneme___024root___eval_nba(vlSelf);
        }
    }
}

void Valu_tb_deneme___024root___timing_resume(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___timing_resume\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

#ifdef VL_DEBUG
void Valu_tb_deneme___024root___eval_debug_assertions(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
