// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Valu_tb.h for the primary calling header

#ifndef VERILATED_VALU_TB___024ROOT_H_
#define VERILATED_VALU_TB___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"
class Valu_tb___024unit;


class Valu_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Valu_tb___024root final : public VerilatedModule {
  public:
    // CELLS
    Valu_tb___024unit* __PVT____024unit;

    // DESIGN SPECIFIC STATE
    CData/*3:0*/ alu_tb__DOT__alu_control;
    CData/*0:0*/ alu_tb__DOT__zero_flag;
    CData/*0:0*/ alu_tb__DOT__negative_flag;
    CData/*0:0*/ alu_tb__DOT__carry_flag;
    CData/*0:0*/ alu_tb__DOT__overflow_flag;
    CData/*0:0*/ alu_tb__DOT__expected_zero;
    CData/*0:0*/ alu_tb__DOT__expected_negative;
    CData/*0:0*/ alu_tb__DOT__expected_carry;
    CData/*0:0*/ alu_tb__DOT__expected_overflow;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ alu_tb__DOT__source_a;
    IData/*31:0*/ alu_tb__DOT__source_b;
    IData/*31:0*/ alu_tb__DOT__alu_result;
    IData/*31:0*/ alu_tb__DOT__expected_result;
    IData/*31:0*/ alu_tb__DOT__op_val;
    IData/*31:0*/ alu_tb__DOT__file;
    IData/*31:0*/ alu_tb__DOT__r;
    IData/*31:0*/ alu_tb__DOT__line;
    IData/*31:0*/ alu_tb__DOT__error_count;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VactIterCount;
    QData/*32:0*/ alu_tb__DOT__dut__DOT__temp_result;
    VlUnpacked<CData/*0:0*/, 5> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Valu_tb__Syms* const vlSymsp;

    // CONSTRUCTORS
    Valu_tb___024root(Valu_tb__Syms* symsp, const char* v__name);
    ~Valu_tb___024root();
    VL_UNCOPYABLE(Valu_tb___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
