// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Valu_tb.h for the primary calling header

#include "verilated.h"

#include "Valu_tb__Syms.h"
#include "Valu_tb___024unit.h"

VL_ATTR_COLD void Valu_tb___024unit___ctor_var_reset(Valu_tb___024unit* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Valu_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+  Valu_tb___024unit___ctor_var_reset\n"); );
    // Body
    for (int __Vi = 0; __Vi < 16; ++__Vi) {
        vlSelf->__Venumtab_enum_name0[__Vi] = std::string{""};
    }
    vlSelf->__Venumtab_enum_name0[0] = std::string{"ALU_ADD"};
    vlSelf->__Venumtab_enum_name0[1] = std::string{"ALU_SUB"};
    vlSelf->__Venumtab_enum_name0[2] = std::string{"ALU_AND"};
    vlSelf->__Venumtab_enum_name0[3] = std::string{"ALU_OR"};
    vlSelf->__Venumtab_enum_name0[4] = std::string{"ALU_XOR"};
    vlSelf->__Venumtab_enum_name0[5] = std::string{"ALU_SLL"};
    vlSelf->__Venumtab_enum_name0[6] = std::string{"ALU_SRL"};
    vlSelf->__Venumtab_enum_name0[7] = std::string{"ALU_SRA"};
    vlSelf->__Venumtab_enum_name0[8] = std::string{"ALU_SLT"};
    vlSelf->__Venumtab_enum_name0[9] = std::string{"ALU_SLTU"};
}
