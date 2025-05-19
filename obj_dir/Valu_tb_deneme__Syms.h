// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VALU_TB_DENEME__SYMS_H_
#define VERILATED_VALU_TB_DENEME__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Valu_tb_deneme.h"

// INCLUDE MODULE CLASSES
#include "Valu_tb_deneme___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Valu_tb_deneme__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Valu_tb_deneme* const __Vm_modelp;
    bool __Vm_activity = false;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode = 0;  ///< Used by trace routines when tracing multiple models
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Valu_tb_deneme___024root       TOP;

    // CONSTRUCTORS
    Valu_tb_deneme__Syms(VerilatedContext* contextp, const char* namep, Valu_tb_deneme* modelp);
    ~Valu_tb_deneme__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
