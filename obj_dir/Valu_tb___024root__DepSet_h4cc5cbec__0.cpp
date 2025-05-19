// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu_tb.h for the primary calling header

#include "verilated.h"

#include "Valu_tb__Syms.h"
#include "Valu_tb__Syms.h"
#include "Valu_tb___024root.h"

VL_INLINE_OPT VlCoroutine Valu_tb___024root___eval_initial__TOP__0(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___eval_initial__TOP__0\n"); );
    // Init
    VlWide<5>/*159:0*/ __Vtemp_1;
    std::string __Vtemp_2;
    // Body
    co_await vlSelf->__VdlySched.delay(0x14ULL, nullptr, 
                                       "tb/alu_tb.sv", 
                                       43);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    __Vtemp_1[0U] = 0x2e747874U;
    __Vtemp_1[1U] = 0x74657374U;
    __Vtemp_1[2U] = 0x616c755fU;
    __Vtemp_1[3U] = 0x6573742fU;
    __Vtemp_1[4U] = 0x2e2f74U;
    vlSelf->alu_tb__DOT__file = VL_FOPEN_NN(VL_CVT_PACK_STR_NW(5, __Vtemp_1)
                                            , std::string{"r"});
    ;
    if (VL_UNLIKELY((0U == vlSelf->alu_tb__DOT__file))) {
        VL_WRITEF("[%0t] %%Fatal: alu_tb.sv:46: Assertion failed in %Nalu_tb\n",
                  64,VL_TIME_UNITED_Q(1),-12,vlSymsp->name());
        VL_STOP_MT("tb/alu_tb.sv", 46, "");
    }
    while ((! (vlSelf->alu_tb__DOT__file ? feof(VL_CVT_I_FP(vlSelf->alu_tb__DOT__file)) : true))) {
        vlSelf->alu_tb__DOT__r = VL_FSCANF_IX(vlSelf->alu_tb__DOT__file,"%x %x %# %x %# %# %# %#\n",
                                              32,&(vlSelf->alu_tb__DOT__source_a),
                                              32,&(vlSelf->alu_tb__DOT__source_b),
                                              32,&(vlSelf->alu_tb__DOT__op_val),
                                              32,&(vlSelf->alu_tb__DOT__expected_result),
                                              1,&(vlSelf->alu_tb__DOT__expected_zero),
                                              1,&(vlSelf->alu_tb__DOT__expected_negative),
                                              1,&(vlSelf->alu_tb__DOT__expected_carry),
                                              1,&(vlSelf->alu_tb__DOT__expected_overflow)) ;
        vlSelf->alu_tb__DOT__alu_control = (0xfU & vlSelf->alu_tb__DOT__op_val);
        co_await vlSelf->__VdlySched.delay(0xaULL, 
                                           nullptr, 
                                           "tb/alu_tb.sv", 
                                           55);
        vlSelf->__Vm_traceActivity[2U] = 1U;
        if (VL_UNLIKELY((((((vlSelf->alu_tb__DOT__alu_result 
                             != vlSelf->alu_tb__DOT__expected_result) 
                            | ((IData)(vlSelf->alu_tb__DOT__zero_flag) 
                               != (IData)(vlSelf->alu_tb__DOT__expected_zero))) 
                           | ((IData)(vlSelf->alu_tb__DOT__negative_flag) 
                              != (IData)(vlSelf->alu_tb__DOT__expected_negative))) 
                          | ((IData)(vlSelf->alu_tb__DOT__carry_flag) 
                             != (IData)(vlSelf->alu_tb__DOT__expected_carry))) 
                         | ((IData)(vlSelf->alu_tb__DOT__overflow_flag) 
                            != (IData)(vlSelf->alu_tb__DOT__expected_overflow))))) {
            VL_WRITEF("HATA: Satir %0d\n A      = %b\n B      = %b\n",
                      32,vlSelf->alu_tb__DOT__line,
                      32,vlSelf->alu_tb__DOT__source_a,
                      32,vlSelf->alu_tb__DOT__source_b);
            __Vtemp_2 = Valu_tb___024unit::__Venumtab_enum_name0
                [vlSelf->alu_tb__DOT__alu_control];
            VL_WRITEF(" Op     = %0@\n Beklenen: R=%b Z=%b N=%b C=%b O=%b\n Ger\303\247ek  : R=%b Z=%b N=%b C=%b O=%b\n\n",
                      -1,&(__Vtemp_2),32,vlSelf->alu_tb__DOT__expected_result,
                      1,(IData)(vlSelf->alu_tb__DOT__expected_zero),
                      1,vlSelf->alu_tb__DOT__expected_negative,
                      1,(IData)(vlSelf->alu_tb__DOT__expected_carry),
                      1,vlSelf->alu_tb__DOT__expected_overflow,
                      32,vlSelf->alu_tb__DOT__alu_result,
                      1,(IData)(vlSelf->alu_tb__DOT__zero_flag),
                      1,vlSelf->alu_tb__DOT__negative_flag,
                      1,(IData)(vlSelf->alu_tb__DOT__carry_flag),
                      1,vlSelf->alu_tb__DOT__overflow_flag);
            vlSelf->alu_tb__DOT__error_count = ((IData)(1U) 
                                                + vlSelf->alu_tb__DOT__error_count);
        }
        vlSelf->alu_tb__DOT__line = ((IData)(1U) + vlSelf->alu_tb__DOT__line);
    }
    VL_FCLOSE_I(vlSelf->alu_tb__DOT__file); if ((0U 
                                                 == vlSelf->alu_tb__DOT__error_count)) {
        VL_WRITEF("Tum testler basarili! (%0d satir)\n",
                  32,vlSelf->alu_tb__DOT__line);
    } else {
        VL_WRITEF("%0d satirda hata bulundu.\n",32,
                  vlSelf->alu_tb__DOT__error_count);
    }
    VL_FINISH_MT("tb/alu_tb.sv", 84, "");
    vlSelf->__Vm_traceActivity[2U] = 1U;
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Valu_tb___024root___dump_triggers__act(Valu_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Valu_tb___024root___eval_triggers__act(Valu_tb___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Valu_tb___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, vlSelf->__VdlySched.awaitingCurrentTime());
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Valu_tb___024root___dump_triggers__act(vlSelf);
    }
#endif
}
