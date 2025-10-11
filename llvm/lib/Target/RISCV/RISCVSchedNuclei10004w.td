//==- RISCVSchedNuclei10004w.td - Nuclei10004w Scheduling Definitions ----*- tablegen -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// ===---------------------------------------------------------------------===//
// The following definitions describe the simpler per-operand machine model.
// This works with MachineScheduler. See MCSchedule.h for details.

// Nuclei10004w machine model for scheduling and other instruction cost heuristics.
def Nuclei10004wModel : SchedMachineModel {
  let MicroOpBufferSize = 180; // Nuclei10004w is out-of-order.
  let IssueWidth = 4;        // 3 micro-op is dispatched per cycle.
  let LoadLatency = 3;       // rv32:3  rv64:2
  let MispredictPenalty = 3;
  let CompleteModel = false;
  let LoopMicroOpBufferSize = 200;
  let PostRAScheduler = true;
  let UnsupportedFeatures = [HasStdExtZbkb, HasStdExtZbkc, HasStdExtZbkx,
                             HasStdExtZcmt, HasStdExtZknd, HasStdExtZkne,
                             HasStdExtZknh, HasStdExtZksed, HasStdExtZksh,
                             HasStdExtZkr, HasVInstructions, HasVInstructionsI64,HasVendorXxldspn3x];
}

//===----------------------------------------------------------------------===//
// Define each kind of processor resource and number available.

// Modeling each pipeline as a ProcResource using the BufferSize = 0 since
// Nuclei10004w is out-of-order.

let BufferSize = 0 in {
def Nuclei10004wUnitALU        : ProcResource<1>; // Int ALU
def Nuclei10004wUnitIMul       : ProcResource<1>; // Int Multiply
def Nuclei10004wUnitMem        : ProcResource<1>; // Load/Store
def Nuclei10004wUnitB          : ProcResource<1>; // Branch

def Nuclei10004wUnitFPALU      : ProcResource<1>; // FP ALU

def Nuclei10004wUnitLoad  : ProcResource<1>;
def Nuclei10004wUnitStore : ProcResource<1>;
}

let BufferSize = 1 in {
def Nuclei10004wUnitIDiv       : ProcResource<1>; // Int Division
def Nuclei10004wUnitFPDivSqrt  : ProcResource<1>; // FP Divide/Sqrt
}

//===----------------------------------------------------------------------===//

let SchedModel = Nuclei10004wModel in {

// Branching
def : WriteRes<WriteJmp, [Nuclei10004wUnitB]>;
def : WriteRes<WriteJal, [Nuclei10004wUnitB]>;
def : WriteRes<WriteJalr, [Nuclei10004wUnitB]>;

// Integer arithmetic and logic
def : WriteRes<WriteIALU32, [Nuclei10004wUnitALU]>;
def : WriteRes<WriteIALU, [Nuclei10004wUnitALU]>;
def : WriteRes<WriteShiftImm32, [Nuclei10004wUnitALU]>;
def : WriteRes<WriteShiftImm, [Nuclei10004wUnitALU]>;
def : WriteRes<WriteShiftReg32, [Nuclei10004wUnitALU]>;
def : WriteRes<WriteShiftReg, [Nuclei10004wUnitALU]>;

// Integer multiplication
let Latency = 4 in {
def : WriteRes<WriteIMul, [Nuclei10004wUnitIMul]>;
def : WriteRes<WriteIMul32, [Nuclei10004wUnitIMul]>;
}

// Integer division
// Worst case latency is used.
def : WriteRes<WriteIDiv32, [Nuclei10004wUnitIDiv]> {
  let Latency = 16;
  let ReleaseAtCycles = [16];
}
def : WriteRes<WriteIDiv, [Nuclei10004wUnitIDiv]> {
  let Latency = 16;
  let ReleaseAtCycles = [16];
}

// Integer remainder
def : WriteRes<WriteIRem32, [Nuclei10004wUnitIDiv]> {
  let Latency = 34;
  let ReleaseAtCycles = [34];
}
def : WriteRes<WriteIRem, [Nuclei10004wUnitIDiv]> {
  let Latency = 33;
  let ReleaseAtCycles = [33];
}

// Memory
def : WriteRes<WriteSTB, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteSTH, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteSTW, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteSTD, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteFST32, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteFST64, [Nuclei10004wUnitMem]>;

let Latency = 3 in {
def : WriteRes<WriteLDB, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteLDH, [Nuclei10004wUnitMem]>;
}

let Latency = 2 in {
def : WriteRes<WriteLDW, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteLDD, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteFLD32, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteFLD64, [Nuclei10004wUnitMem]>;

// Atomic memory
def : WriteRes<WriteAtomicW, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteAtomicD, [Nuclei10004wUnitMem]>;

def : WriteRes<WriteAtomicLDW, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteAtomicLDD, [Nuclei10004wUnitMem]>;
}

def : WriteRes<WriteAtomicSTW, [Nuclei10004wUnitMem]>;
def : WriteRes<WriteAtomicSTD, [Nuclei10004wUnitMem]>;

// Single precision.
let Latency = 4 in {
def : WriteRes<WriteFAdd32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFSGNJ32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFMinMax32, [Nuclei10004wUnitFPALU]>;
}

// Double precision
let Latency = 6 in {
def : WriteRes<WriteFAdd64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFSGNJ64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFMinMax64, [Nuclei10004wUnitFPALU]>;
}

// Conversions
let Latency = 2 in {
def : WriteRes<WriteFCvtI32ToF32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtI32ToF64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtF32ToF64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCvtF64ToF32, [Nuclei10004wUnitFPALU]>;

def : WriteRes<WriteFClass32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFClass64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCmp32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFCmp64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFMovF32ToI32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFMovI32ToF32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFMovF64ToI64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFMovI64ToF64, [Nuclei10004wUnitFPALU]>;
}

// FP multiplication
let Latency = 5 in {
def : WriteRes<WriteFMul32, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFMA32, [Nuclei10004wUnitFPALU]>;
}

let Latency = 7 in {
def : WriteRes<WriteFMul64, [Nuclei10004wUnitFPALU]>;
def : WriteRes<WriteFMA64, [Nuclei10004wUnitFPALU]>;
}

// FP division
// FP division unit on Nuclei10004w is not pipelined, so set resource cycles to latency.
let Latency = 20, ReleaseAtCycles = [20] in {
def : WriteRes<WriteFDiv32, [Nuclei10004wUnitFPDivSqrt]>;
def : WriteRes<WriteFDiv64, [Nuclei10004wUnitFPDivSqrt]>;
}

// FP square root unit on Nuclei10004w is not pipelined, so set resource cycles to latency.
def : WriteRes<WriteFSqrt32, [Nuclei10004wUnitFPDivSqrt]> { let Latency = 20;
                                                      let ReleaseAtCycles = [20]; }
def : WriteRes<WriteFSqrt64, [Nuclei10004wUnitFPDivSqrt]> { let Latency = 25;
                                                      let ReleaseAtCycles = [25]; }

// Others
def : WriteRes<WriteCSR, []>;
def : WriteRes<WriteNop, []>;

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
