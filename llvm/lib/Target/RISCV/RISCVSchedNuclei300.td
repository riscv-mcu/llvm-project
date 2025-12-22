//==- RISCVSchedNuclei300.td - Nuclei300 Scheduling Definitions ----*- tablegen -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// ===---------------------------------------------------------------------===//
// The following definitions describe the simpler per-operand machine model.
// This works with MachineScheduler. See MCSchedule.h for details.

// Nuclei300 machine model for scheduling and other instruction cost heuristics.
def Nuclei300Model : SchedMachineModel {
  let MicroOpBufferSize = 0; // Nuclei300 is in-order.
  let IssueWidth = 1;        // 1 micro-op is dispatched per cycle.
  let LoadLatency = 2;       // Modified to match table: 整数LOAD指令2 cycle
  let MispredictPenalty = 3;
  let CompleteModel = false;
  let UnsupportedFeatures = [HasStdExtZbkb, HasStdExtZbkc, HasStdExtZbkx,
                             HasStdExtZcmt, HasStdExtZknd, HasStdExtZkne,
                             HasStdExtZknh, HasStdExtZksed, HasStdExtZksh,
                             HasStdExtZkr, HasVInstructions, HasVInstructionsI64];
}

//===----------------------------------------------------------------------===//
// Define each kind of processor resource and number available.

// Modeling each pipeline as a ProcResource using the BufferSize = 0 since
// Nuclei300 is in-order.

let BufferSize = 0 in {
def Nuclei300UnitALU        : ProcResource<1>; // Int ALU
def Nuclei300UnitIMul       : ProcResource<1>; // Int Multiply
def Nuclei300UnitMem        : ProcResource<1>; // Load/Store
def Nuclei300UnitB          : ProcResource<1>; // Branch

def Nuclei300UnitFPALU      : ProcResource<1>; // FP ALU
}

let BufferSize = 1 in {
def Nuclei300UnitIDiv       : ProcResource<1>; // Int Division
def Nuclei300UnitFPDivSqrt  : ProcResource<1>; // FP Divide/Sqrt
}

//===----------------------------------------------------------------------===//

let SchedModel = Nuclei300Model in {

// 分支指令 - 全部2 cycle
def : WriteRes<WriteJmp, [Nuclei300UnitB]> { let Latency = 2; }
def : WriteRes<WriteJal, [Nuclei300UnitB]> { let Latency = 2; }
def : WriteRes<WriteJalr, [Nuclei300UnitB]> { let Latency = 2; }

// ALU指令 - 全部1 cycle
def : WriteRes<WriteIALU32, [Nuclei300UnitALU]> { let Latency = 1; }
def : WriteRes<WriteIALU, [Nuclei300UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftImm32, [Nuclei300UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftImm, [Nuclei300UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftReg32, [Nuclei300UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftReg, [Nuclei300UnitALU]> { let Latency = 1; }



// LUI/AUIPC - 1 cycle
def : WriteRes<WriteLUI, [Nuclei300UnitALU]> { let Latency = 1; }
def : WriteRes<WriteAUIPC, [Nuclei300UnitALU]> { let Latency = 1; }

// Bit-Manipulation Extensions - 1 cycle
def : WriteRes<WriteBitmanip, [Nuclei300UnitALU]> { let Latency = 1; }

// 整数乘法
def : WriteRes<WriteIMul, [Nuclei300UnitIMul]> { let Latency = 2; }
def : WriteRes<WriteIMul32, [Nuclei300UnitIMul]> { let Latency = 2; }

// 整数除法
def : WriteRes<WriteIDiv32, [Nuclei300UnitIDiv]> {
  let Latency = 17; // 17 cycles for RV32M division
  let ReleaseAtCycles = [17]; // Non-pipelined
}
def : WriteRes<WriteIDiv, [Nuclei300UnitIDiv]> {
  let Latency = 33; // 33 cycles for RV64M division
  let ReleaseAtCycles = [33]; // Non-pipelined
}

// 整数余数
def : WriteRes<WriteIRem32, [Nuclei300UnitIDiv]> {
  let Latency = 17; // 17 cycles for RV32M remainder
  let ReleaseAtCycles = [17]; // Non-pipelined
}
def : WriteRes<WriteIRem, [Nuclei300UnitIDiv]> {
  let Latency = 33; // 33 cycles for RV64M remainder
  let ReleaseAtCycles = [33]; // Non-pipelined
}

// 原子指令
def : WriteRes<WriteAtomicW, [Nuclei300UnitMem]> {
  let Latency = 6; // Other atomic instructions: 6 cycles
}
def : WriteRes<WriteAtomicD, [Nuclei300UnitMem]> {
  let Latency = 6; // Other atomic instructions: 6 cycles
}
def : WriteRes<WriteAtomicLDW, [Nuclei300UnitMem]> {
  let Latency = 3; // LR.W/SC.W: 3 cycles
}
def : WriteRes<WriteAtomicLDD, [Nuclei300UnitMem]> {
  let Latency = 3; // LR.W/SC.W: 3 cycles
}
def : WriteRes<WriteAtomicSTW, [Nuclei300UnitMem]> {
  let Latency = 3; // LR.W/SC.W: 3 cycles
}
def : WriteRes<WriteAtomicSTD, [Nuclei300UnitMem]> {
  let Latency = 3; // LR.W/SC.W: 3 cycles
}

// 存储指令 - 全部1 cycle (包括整数和单精度浮点)
def : WriteRes<WriteSTB, [Nuclei300UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTH, [Nuclei300UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTW, [Nuclei300UnitMem]> { let Latency = 1; }
def : WriteRes<WriteFST32, [Nuclei300UnitMem]> { let Latency = 1; }

// 存储指令 - 双精度浮点4 cycle
def : WriteRes<WriteSTD, [Nuclei300UnitMem]> { let Latency = 4; }
def : WriteRes<WriteFST64, [Nuclei300UnitMem]> { let Latency = 4; }

// 加载指令 - 全部2 cycle (包括整数和浮点)
def : WriteRes<WriteLDB, [Nuclei300UnitMem]> { let Latency = 2; }
def : WriteRes<WriteLDH, [Nuclei300UnitMem]> { let Latency = 2; }
def : WriteRes<WriteLDW, [Nuclei300UnitMem]> { let Latency = 2; }
def : WriteRes<WriteFLD32, [Nuclei300UnitMem]> { let Latency = 2; }

// 加载指令 - 双精度浮点4 cycle
def : WriteRes<WriteLDD, [Nuclei300UnitMem]> { let Latency = 4; }
def : WriteRes<WriteFLD64, [Nuclei300UnitMem]> { let Latency = 4; }

// 浮点指令 - 全部4 cycle (包括各种精度的FMAC)
let Latency = 4 in {
def : WriteRes<WriteFAdd32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFAdd64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFSGNJ32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFSGNJ64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMinMax32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMinMax64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMul32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMul64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMA32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMA64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCmp32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCmp64, [Nuclei300UnitFPALU]>;
}

// 浮点转换指令 - 全部2 cycle
let Latency = 2 in {
def : WriteRes<WriteFCvtI32ToF32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtI32ToF64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToF64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToF32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFClass32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFClass64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMovF32ToI32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMovI32ToF32, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMovF64ToI64, [Nuclei300UnitFPALU]>;
def : WriteRes<WriteFMovI64ToF64, [Nuclei300UnitFPALU]>;
}

// 浮点除法
def : WriteRes<WriteFDiv32, [Nuclei300UnitFPDivSqrt]> { 
  let Latency = 19; // 16-19周期（取最大19）
  let ReleaseAtCycles = [19]; // Non-pipelined
}
def : WriteRes<WriteFDiv64, [Nuclei300UnitFPDivSqrt]> { 
  let Latency = 35; // 32-35周期（取最大35）
  let ReleaseAtCycles = [35]; // Non-pipelined
}

// 浮点平方根
def : WriteRes<WriteFSqrt32, [Nuclei300UnitFPDivSqrt]> { 
  let Latency = 19; // 16-19周期（取最大19）
  let ReleaseAtCycles = [19]; // Non-pipelined
}
def : WriteRes<WriteFSqrt64, [Nuclei300UnitFPDivSqrt]> { 
  let Latency = 35; // 32-35周期（取最大35）
  let ReleaseAtCycles = [35]; // Non-pipelined
}

// 其他指令
def : WriteRes<WriteCSR, []> { let Latency = 1; }
def : WriteRes<WriteNop, []> { let Latency = 1; }

def : InstRW<[WriteIALU], (instrs COPY)>;

//===----------------------------------------------------------------------===//
// Bypass and advance
def : ReadAdvance<ReadJmp, 0>;
def : ReadAdvance<ReadJalr, 0>;
def : ReadAdvance<ReadCSR, 0>;
def : ReadAdvance<ReadStoreData, 0>;
def : ReadAdvance<ReadMemBase, 0>;
def : ReadAdvance<ReadIALU, 0>;
def : ReadAdvance<ReadIALU32, 0>;
def : ReadAdvance<ReadShiftImm, 0>;
def : ReadAdvance<ReadShiftImm32, 0>;
def : ReadAdvance<ReadShiftReg, 0>;
def : ReadAdvance<ReadShiftReg32, 0>;
def : ReadAdvance<ReadIDiv, 0>;
def : ReadAdvance<ReadIDiv32, 0>;
def : ReadAdvance<ReadIRem, 0>;
def : ReadAdvance<ReadIRem32, 0>;
def : ReadAdvance<ReadIMul, 0>;
def : ReadAdvance<ReadIMul32, 0>;
def : ReadAdvance<ReadAtomicWA, 0>;
def : ReadAdvance<ReadAtomicWD, 0>;
def : ReadAdvance<ReadAtomicDA, 0>;
def : ReadAdvance<ReadAtomicDD, 0>;
def : ReadAdvance<ReadAtomicLDW, 0>;
def : ReadAdvance<ReadAtomicLDD, 0>;
def : ReadAdvance<ReadAtomicSTW, 0>;
def : ReadAdvance<ReadAtomicSTD, 0>;
def : ReadAdvance<ReadFStoreData, 0>;
def : ReadAdvance<ReadFMemBase, 0>;
def : ReadAdvance<ReadFAdd32, 0>;
def : ReadAdvance<ReadFAdd64, 0>;
def : ReadAdvance<ReadFMul32, 0>;
def : ReadAdvance<ReadFMul64, 0>;
def : ReadAdvance<ReadFMA32, 0>;
def : ReadAdvance<ReadFMA32Addend, 0>;
def : ReadAdvance<ReadFMA64, 0>;
def : ReadAdvance<ReadFMA64Addend, 0>;
def : ReadAdvance<ReadFDiv32, 0>;
def : ReadAdvance<ReadFDiv64, 0>;
def : ReadAdvance<ReadFSqrt32, 0>;
def : ReadAdvance<ReadFSqrt64, 0>;
def : ReadAdvance<ReadFCmp32, 0>;
def : ReadAdvance<ReadFCmp64, 0>;
def : ReadAdvance<ReadFSGNJ32, 0>;
def : ReadAdvance<ReadFSGNJ64, 0>;
def : ReadAdvance<ReadFMinMax32, 0>;
def : ReadAdvance<ReadFMinMax64, 0>;
def : ReadAdvance<ReadFCvtF32ToI32, 0>;
def : ReadAdvance<ReadFCvtF32ToI64, 0>;
def : ReadAdvance<ReadFCvtF64ToI32, 0>;
def : ReadAdvance<ReadFCvtF64ToI64, 0>;
def : ReadAdvance<ReadFCvtI32ToF32, 0>;
def : ReadAdvance<ReadFCvtI32ToF64, 0>;
def : ReadAdvance<ReadFCvtI64ToF32, 0>;
def : ReadAdvance<ReadFCvtI64ToF64, 0>;
def : ReadAdvance<ReadFCvtF32ToF64, 0>;
def : ReadAdvance<ReadFCvtF64ToF32, 0>;
def : ReadAdvance<ReadFMovF32ToI32, 0>;
def : ReadAdvance<ReadFMovI32ToF32, 0>;
def : ReadAdvance<ReadFMovF64ToI64, 0>;
def : ReadAdvance<ReadFMovI64ToF64, 0>;
def : ReadAdvance<ReadFClass32, 0>;
def : ReadAdvance<ReadFClass64, 0>;

//===----------------------------------------------------------------------===//
// Unsupported extensions
defm : UnsupportedSchedV;
defm : UnsupportedSchedZabha;
defm : UnsupportedSchedZba;
defm : UnsupportedSchedZbb;
defm : UnsupportedSchedZbc;
defm : UnsupportedSchedZbs;
defm : UnsupportedSchedZbkb;
defm : UnsupportedSchedZbkx;
defm : UnsupportedSchedZfa;
defm : UnsupportedSchedZfh;
defm : UnsupportedSchedSFB;
defm : UnsupportedSchedXsfvcp;
defm : UnsupportedSchedZvk;
}
