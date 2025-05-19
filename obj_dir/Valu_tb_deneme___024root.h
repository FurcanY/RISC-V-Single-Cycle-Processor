// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Valu_tb_deneme.h for the primary calling header

#ifndef VERILATED_VALU_TB_DENEME___024ROOT_H_
#define VERILATED_VALU_TB_DENEME___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Valu_tb_deneme__Syms;

class alignas(VL_CACHE_LINE_BYTES) Valu_tb_deneme___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*3:0*/ alu_tb_deneme__DOT__alu_control;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ alu_tb_deneme__DOT__source_a;
    IData/*31:0*/ alu_tb_deneme__DOT__source_b;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    QData/*32:0*/ alu_tb_deneme__DOT__dut__DOT__temp_result;
    VlUnpacked<CData/*0:0*/, 3> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Valu_tb_deneme__Syms* const vlSymsp;

    // CONSTRUCTORS
    Valu_tb_deneme___024root(Valu_tb_deneme__Syms* symsp, const char* v__name);
    ~Valu_tb_deneme___024root();
    VL_UNCOPYABLE(Valu_tb_deneme___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
