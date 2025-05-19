// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu_tb_deneme.h for the primary calling header

#include "verilated.h"

#include "Valu_tb_deneme__Syms.h"
#include "Valu_tb_deneme__Syms.h"
#include "Valu_tb_deneme___024root.h"

void Valu_tb_deneme___024root___ctor_var_reset(Valu_tb_deneme___024root* vlSelf);

Valu_tb_deneme___024root::Valu_tb_deneme___024root(Valu_tb_deneme__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Valu_tb_deneme___024root___ctor_var_reset(this);
}

void Valu_tb_deneme___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Valu_tb_deneme___024root::~Valu_tb_deneme___024root() {
}
