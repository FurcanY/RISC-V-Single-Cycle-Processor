// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu_tb_deneme.h for the primary calling header

#include "verilated.h"

#include "Valu_tb_deneme__Syms.h"
#include "Valu_tb_deneme__Syms.h"
#include "Valu_tb_deneme___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb_deneme___024root___dump_triggers__act(Valu_tb_deneme___024root* vlSelf);
#endif  // VL_DEBUG

void Valu_tb_deneme___024root___eval_triggers__act(Valu_tb_deneme___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb_deneme___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, vlSelf->__VdlySched.awaitingCurrentTime());
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Valu_tb_deneme___024root___dump_triggers__act(vlSelf);
    }
#endif
}
