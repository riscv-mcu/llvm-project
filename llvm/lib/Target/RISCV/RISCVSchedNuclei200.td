//==- RISCVSchedNuclei200.td - Nuclei200 Scheduling Definitions ----*- tablegen -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// ===---------------------------------------------------------------------===//
// The following definitions describe the simpler per-operand machine model.
// This works with MachineScheduler. See MCSchedule.h for details.

// Nuclei200 machine model for scheduling and other instruction cost heuristics.
def Nuclei200Model : SchedMachineModel {
  let MicroOpBufferSize = 0; // Nuclei200 is in-order.
  let IssueWidth = 1;        // 1 micro-op is dispatched per cycle.
  let LoadLatency = 2;       // Updated to match table: integer load is 2 cycles
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
// Nuclei200 is in-order.

let BufferSize = 0 in {
def Nuclei200UnitALU        : ProcResource<1>; // Int ALU
def Nuclei200UnitIMul       : ProcResource<1>; // Int Multiply
def Nuclei200UnitMem        : ProcResource<1>; // Load/Store
def Nuclei200UnitB          : ProcResource<1>; // Branch

def Nuclei200UnitFPALU      : ProcResource<1>; // FP ALU
}

let BufferSize = 1 in {
def Nuclei200UnitIDiv       : ProcResource<1>; // Int Division
def Nuclei200UnitFPDivSqrt  : ProcResource<1>; // FP Divide/Sqrt
}

//===----------------------------------------------------------------------===//

let SchedModel = Nuclei200Model in {

// 分支指令 - JAL/JALR指令2 cycle
def : WriteRes<WriteJmp, [Nuclei200UnitB]> { let Latency = 2; }
def : WriteRes<WriteJal, [Nuclei200UnitB]> { let Latency = 2; }
def : WriteRes<WriteJalr, [Nuclei200UnitB]> { let Latency = 2; }

// ALU指令和移位操作 - 全部1 cycle
def : WriteRes<WriteIALU32, [Nuclei200UnitALU]> { let Latency = 1; }
def : WriteRes<WriteIALU, [Nuclei200UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftImm32, [Nuclei200UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftImm, [Nuclei200UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftReg32, [Nuclei200UnitALU]> { let Latency = 1; }
def : WriteRes<WriteShiftReg, [Nuclei200UnitALU]> { let Latency = 1; }

// LUI/AUIPC - 1 cycle
def : WriteRes<WriteLUI, [Nuclei200UnitALU]> { let Latency = 1; }
def : WriteRes<WriteAUIPC, [Nuclei200UnitALU]> { let Latency = 1; }

// Bit-Manipulation Extensions - 1 cycle
def : WriteRes<WriteBitmanip, [Nuclei200UnitALU]> { let Latency = 1; }

// 整数乘法 (MUL/MULH/MULHSU) - 1 cycle
def : WriteRes<WriteIMul, [Nuclei200UnitIMul]> { let Latency = 1; }
def : WriteRes<WriteIMul32, [Nuclei200UnitIMul]> { let Latency = 1; }

// 整数除法
def : WriteRes<WriteIDiv32, [Nuclei200UnitIDiv]> {
  let Latency = 17; // RV32M division, non-pipelined
  let ReleaseAtCycles = [17];
}
def : WriteRes<WriteIDiv, [Nuclei200UnitIDiv]> {
  let Latency = 33; // RV64M division, non-pipelined
  let ReleaseAtCycles = [33];
}

// 整数余数
def : WriteRes<WriteIRem32, [Nuclei200UnitIDiv]> {
  let Latency = 17; // RV32M remainder
  let ReleaseAtCycles = [17];
}
def : WriteRes<WriteIRem, [Nuclei200UnitIDiv]> {
  let Latency = 33; // RV64M remainder
  let ReleaseAtCycles = [33];
}

// 原子指令 (原子加载为3 cycle, 其他为6 cycle)
def : WriteRes<WriteAtomicW, [Nuclei200UnitMem]> { let Latency = 6; }
def : WriteRes<WriteAtomicD, [Nuclei200UnitMem]> { let Latency = 6; }
def : WriteRes<WriteAtomicLDW, [Nuclei200UnitMem]> { let Latency = 3; }
def : WriteRes<WriteAtomicLDD, [Nuclei200UnitMem]> { let Latency = 3; }
def : WriteRes<WriteAtomicSTW, [Nuclei200UnitMem]> { let Latency = 3; }
def : WriteRes<WriteAtomicSTD, [Nuclei200UnitMem]> { let Latency = 3; }

// 加载指令 - LB/LH/LW/LBU/LHU为2 cycle
def : WriteRes<WriteLDB, [Nuclei200UnitMem]> { let Latency = 2; }
def : WriteRes<WriteLDH, [Nuclei200UnitMem]> { let Latency = 2; }
def : WriteRes<WriteLDW, [Nuclei200UnitMem]> { let Latency = 2; }
def : WriteRes<WriteLDD, [Nuclei200UnitMem]> { let Latency = 2; }

// 存储指令 - SB/SH/SW为1 cycle
def : WriteRes<WriteSTB, [Nuclei200UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTH, [Nuclei200UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTW, [Nuclei200UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTD, [Nuclei200UnitMem]> { let Latency = 1; }

//===----------------------------------------------------------------------===//
// 浮点操作 (根据表格数据调整周期数)

// FMAC类型操作 (FADD/FMUL/FMADD等) - 统一设置为3 cycle 
let Latency = 3 in {
def : WriteRes<WriteFAdd32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFAdd64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMul32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMul64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMA32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMA64, [Nuclei200UnitFPALU]>;
}

// 浮点比较操作 - 根据表格Float/Double Misc设置2 cycle
def : WriteRes<WriteFCmp32, [Nuclei200UnitFPALU]> { let Latency = 2; }
def : WriteRes<WriteFCmp64, [Nuclei200UnitFPALU]> { let Latency = 2; }

// 浮点转换和搬移操作 - 2 cycle
let Latency = 2 in {
def : WriteRes<WriteFCvtI32ToF32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtI32ToF64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToF64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToF32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFClass32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFClass64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMovF32ToI32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMovI32ToF32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMovF64ToI64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMovI64ToF64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFSGNJ32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFSGNJ64, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMinMax32, [Nuclei200UnitFPALU]>;
def : WriteRes<WriteFMinMax64, [Nuclei200UnitFPALU]>;
}

// 浮点除法和平方根 (非流水线)
def : WriteRes<WriteFDiv32, [Nuclei200UnitFPDivSqrt]> { 
  let Latency = 19; // FDIV.S/FSQRT.S: 16-19 cycles (max)
  let ReleaseAtCycles = [19]; 
}
def : WriteRes<WriteFSqrt32, [Nuclei200UnitFPDivSqrt]> { 
  let Latency = 19;
  let ReleaseAtCycles = [19];
}
def : WriteRes<WriteFDiv64, [Nuclei200UnitFPDivSqrt]> { 
  let Latency = 35; // FDIV.D/FSQRT.D: 32-35 cycles (max)
  let ReleaseAtCycles = [35];
}
def : WriteRes<WriteFSqrt64, [Nuclei200UnitFPDivSqrt]> { 
  let Latency = 35;
  let ReleaseAtCycles = [35];
}

//===----------------------------------------------------------------------===//
// 存储/加载浮点操作

// 浮点加载 (FLW) - 2 cycle
def : WriteRes<WriteFLD32, [Nuclei200UnitMem]> { let Latency = 2; }

// 浮点存储 (FSW) - 1 cycle
def : WriteRes<WriteFST32, [Nuclei200UnitMem]> { let Latency = 1; }

// 双精度浮点操作保留但实际N200可能不支持
def : WriteRes<WriteFST64, [Nuclei200UnitMem]> { let Latency = 4; }
def : WriteRes<WriteFLD64, [Nuclei200UnitMem]> { let Latency = 4; }

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
