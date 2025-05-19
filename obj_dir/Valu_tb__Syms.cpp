// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Valu_tb__Syms.h"
#include "Valu_tb.h"
#include "Valu_tb___024root.h"
#include "Valu_tb___024unit.h"

// FUNCTIONS
Valu_tb__Syms::~Valu_tb__Syms()
{
}

Valu_tb__Syms::Valu_tb__Syms(VerilatedContext* contextp, const char* namep, Valu_tb* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
    , TOP____024unit{this, Verilated::catName(namep, "$unit")}
{
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    TOP.__PVT____024unit = &TOP____024unit;
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
    TOP____024unit.__Vconfigure(true);
    // Setup scopes
    __Vscope_alu_tb.configure(this, name(), "alu_tb", "alu_tb", -12, VerilatedScope::SCOPE_OTHER);
}
