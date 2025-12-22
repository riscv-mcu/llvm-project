//==- RISCVSchedNuclei600.td - Nuclei600 Scheduling Definitions ----*- tablegen -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// ===---------------------------------------------------------------------===//
// The following definitions describe the simpler per-operand machine model.
// This works with MachineScheduler. See MCSchedule.h for details.

// Nuclei600 machine model for scheduling and other instruction cost heuristics.
def Nuclei600Model : SchedMachineModel {
  let MicroOpBufferSize = 0; // Nuclei600 is in-order.
  let IssueWidth = 1;        // 1 micro-op is dispatched per cycle.
  let LoadLatency = 4;       // Base memory latency (4+X cycles)
  let MispredictPenalty = 3;
  let CompleteModel = false;
  let UnsupportedFeatures = [HasStdExtZbkb, HasStdExtZbkc, HasStdExtZbkx,
                             HasStdExtZcmt, HasStdExtZknd, HasStdExtZkne,
                             HasStdExtZknh, HasStdExtZksed, HasStdExtZksh,
                             HasStdExtZkr, HasVInstructions, HasVInstructionsI64];
}

//===----------------------------------------------------------------------===//
// Define each kind of processor resource and number available.

let BufferSize = 0 in {
def Nuclei600UnitALU        : ProcResource<1>; // Int ALU
def Nuclei600UnitIMul       : ProcResource<1>; // Int Multiply
def Nuclei600UnitMem        : ProcResource<1>; // Load/Store
def Nuclei600UnitB          : ProcResource<1>; // Branch
def Nuclei600UnitFPALU      : ProcResource<1>; // FP ALU
def Nuclei600UnitDSPMul     : ProcResource<1>; // DSP乘法单元
def Nuclei600UnitDSPOther   : ProcResource<1>; // DSP其他操作
}

let BufferSize = 1 in {
def Nuclei600UnitIDiv       : ProcResource<1>; // Int Division
def Nuclei600UnitFPDivSqrt  : ProcResource<1>; // FP Divide/Sqrt
}

def WriteDSPMul   : SchedWrite;
def WriteDSPOther : SchedWrite;

//===----------------------------------------------------------------------===//

let SchedModel = Nuclei600Model in {

//===----------------------------------------------------------------------===//
// 基础ALU和位操作指令 - 1 cycle

def : WriteRes<WriteIALU32, [Nuclei600UnitALU]> { let Latency = 1; }
def : WriteRes<WriteIALU, [Nuclei600UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftImm32, [Nuclei600UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftImm, [Nuclei600UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftReg32, [Nuclei600UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftReg, [Nuclei600UnitALU]> { let Latency = 1; }
def : WriteRes<WriteBitmanip, [Nuclei600UnitALU]> { let Latency = 1; }

//===----------------------------------------------------------------------===//
// DSP指令 - 乘法4 cycle，其他2 cycle

def : WriteRes<WriteDSPMul, [Nuclei600UnitDSPMul]> { let Latency = 4; }
def : WriteRes<WriteDSPOther, [Nuclei600UnitDSPOther]> { let Latency = 2; }

//===----------------------------------------------------------------------===//
// 分支指令 - 1 cycle (不考虑跳转后取指)

def : WriteRes<WriteJal, [Nuclei600UnitB]> { let Latency = 1; }
def : WriteRes<WriteJalr, [Nuclei600UnitB]> { let Latency = 1; }
def : WriteRes<WriteJmp, [Nuclei600UnitB]> { let Latency = 1; }

//===----------------------------------------------------------------------===//
// 整数乘法 - 配置为3 cycle (取中间值)

def : WriteRes<WriteIMul32, [Nuclei600UnitIMul]> { let Latency = 3; }
def : WriteRes<WriteIMul, [Nuclei600UnitIMul]> { let Latency = 3; }

//===----------------------------------------------------------------------===//
// 整数除法 - Radix16配置(32位9周期，64位17周期)

def : WriteRes<WriteIDiv32, [Nuclei600UnitIDiv]> {
  let Latency = 9;
  let ReleaseAtCycles = [9]; // Non-pipelined
}
def : WriteRes<WriteIDiv, [Nuclei600UnitIDiv]> {
  let Latency = 17;
  let ReleaseAtCycles = [17]; // Non-pipelined
}

//===----------------------------------------------------------------------===//
// 内存操作 - Load(4+X) Store(1)

def : WriteRes<WriteLDW, [Nuclei600UnitMem]> { let Latency = 4; } // Base 4+X
def : WriteRes<WriteLDD, [Nuclei600UnitMem]> { let Latency = 4; }
def : WriteRes<WriteFLD32, [Nuclei600UnitMem]> { let Latency = 4; }
def : WriteRes<WriteFLD64, [Nuclei600UnitMem]> { let Latency = 4; }
def : WriteRes<WriteSTB, [Nuclei600UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTH, [Nuclei600UnitMem]> { let Latency = 1; }

def : WriteRes<WriteSTW, [Nuclei600UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTD, [Nuclei600UnitMem]> { let Latency = 1; }
def : WriteRes<WriteFST32, [Nuclei600UnitMem]> { let Latency = 1; }
def : WriteRes<WriteFST64, [Nuclei600UnitMem]> { let Latency = 1; }


let Latency = 3 in {
def : WriteRes<WriteLDB, [Nuclei600UnitMem]>;
def : WriteRes<WriteLDH, [Nuclei600UnitMem]>;
}

let Latency = 2 in {

// Atomic memory
def : WriteRes<WriteAtomicW, [Nuclei600UnitMem]>;
def : WriteRes<WriteAtomicD, [Nuclei600UnitMem]>;

def : WriteRes<WriteAtomicLDW, [Nuclei600UnitMem]>;
def : WriteRes<WriteAtomicLDD, [Nuclei600UnitMem]>;
}

def : WriteRes<WriteAtomicSTW, [Nuclei600UnitMem]>;
def : WriteRes<WriteAtomicSTD, [Nuclei600UnitMem]>;

//===----------------------------------------------------------------------===//
// 浮点FMAC操作 - 配置为4 cycle (中间值)

let Latency = 4 in {
def : WriteRes<WriteFAdd32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFAdd64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMul32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMul64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMA32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMA64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCmp32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCmp64, [Nuclei600UnitFPALU]>;
}

//===----------------------------------------------------------------------===//
// 浮点杂项操作 - 3 cycle

let Latency = 3 in {
def : WriteRes<WriteFSGNJ32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFSGNJ64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMinMax32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMinMax64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtI32ToF32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtI32ToF64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToF64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToF32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFClass32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFClass64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMovF32ToI32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMovI32ToF32, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMovF64ToI64, [Nuclei600UnitFPALU]>;
def : WriteRes<WriteFMovI64ToF64, [Nuclei600UnitFPALU]>;
}

//===----------------------------------------------------------------------===//
// 浮点除法和开方 - Radix4配置(32位20周期)

def : WriteRes<WriteFDiv32, [Nuclei600UnitFPDivSqrt]> {
  let Latency = 20;
  let ReleaseAtCycles = [20]; // Non-pipelined
}
def : WriteRes<WriteFSqrt32, [Nuclei600UnitFPDivSqrt]> {
  let Latency = 20;
  let ReleaseAtCycles = [20];
}
def : WriteRes<WriteFDiv64, [Nuclei600UnitFPDivSqrt]> {
  let Latency = 34;
  let ReleaseAtCycles = [34];
}
def : WriteRes<WriteFSqrt64, [Nuclei600UnitFPDivSqrt]> {
  let Latency = 34;
  let ReleaseAtCycles = [34];
}

// Integer remainder
def : WriteRes<WriteIRem32, [Nuclei600UnitIDiv]> {
  let Latency = 34;
  let ReleaseAtCycles = [34];
}
def : WriteRes<WriteIRem, [Nuclei600UnitIDiv]> {
  let Latency = 34;
  let ReleaseAtCycles = [34];
}

//===----------------------------------------------------------------------===//
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
