// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Valu_tb_deneme.h"
#include "Valu_tb_deneme__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Valu_tb_deneme::Valu_tb_deneme(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Valu_tb_deneme__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Valu_tb_deneme::Valu_tb_deneme(const char* _vcname__)
    : Valu_tb_deneme(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Valu_tb_deneme::~Valu_tb_deneme() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Valu_tb_deneme___024root___eval_debug_assertions(Valu_tb_deneme___024root* vlSelf);
#endif  // VL_DEBUG
void Valu_tb_deneme___024root___eval_static(Valu_tb_deneme___024root* vlSelf);
void Valu_tb_deneme___024root___eval_initial(Valu_tb_deneme___024root* vlSelf);
void Valu_tb_deneme___024root___eval_settle(Valu_tb_deneme___024root* vlSelf);
void Valu_tb_deneme___024root___eval(Valu_tb_deneme___024root* vlSelf);

void Valu_tb_deneme::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Valu_tb_deneme::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Valu_tb_deneme___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Valu_tb_deneme___024root___eval_static(&(vlSymsp->TOP));
        Valu_tb_deneme___024root___eval_initial(&(vlSymsp->TOP));
        Valu_tb_deneme___024root___eval_settle(&(vlSymsp->TOP));
    }
    // MTask 0 start
    VL_DEBUG_IF(VL_DBG_MSGF("MTask0 starting\n"););
    Verilated::mtaskId(0);
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Valu_tb_deneme___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Valu_tb_deneme::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Valu_tb_deneme::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Valu_tb_deneme::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Valu_tb_deneme___024root___eval_final(Valu_tb_deneme___024root* vlSelf);

VL_ATTR_COLD void Valu_tb_deneme::final() {
    Valu_tb_deneme___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Valu_tb_deneme::hierName() const { return vlSymsp->name(); }
const char* Valu_tb_deneme::modelName() const { return "Valu_tb_deneme"; }
unsigned Valu_tb_deneme::threads() const { return 1; }
void Valu_tb_deneme::prepareClone() const { contextp()->prepareClone(); }
void Valu_tb_deneme::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> Valu_tb_deneme::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void Valu_tb_deneme___024root__trace_init_top(Valu_tb_deneme___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Valu_tb_deneme___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Valu_tb_deneme___024root*>(voidSelf);
    Valu_tb_deneme__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->scopeEscape(' ');
    tracep->pushNamePrefix(std::string{vlSymsp->name()} + ' ');
    Valu_tb_deneme___024root__trace_init_top(vlSelf, tracep);
    tracep->popNamePrefix();
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void Valu_tb_deneme___024root__trace_register(Valu_tb_deneme___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Valu_tb_deneme::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (tfp->isOpen()) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'Valu_tb_deneme::trace()' shall not be called after 'VerilatedVcdC::open()'.");
    }
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Valu_tb_deneme___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
