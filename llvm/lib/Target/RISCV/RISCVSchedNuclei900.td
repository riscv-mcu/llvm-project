//==- RISCVSchedNuclei900.td - Nuclei900 Scheduling Definitions ----*- tablegen -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// ===---------------------------------------------------------------------===//
// The following definitions describe the simpler per-operand machine model.
// This works with MachineScheduler. See MCSchedule.h for details.

// Nuclei900 machine model for scheduling and other instruction cost heuristics.
def Nuclei900Model : SchedMachineModel {
  let MicroOpBufferSize = 0; // Nuclei900 is in-order.
  let IssueWidth = 2;        // 2 micro-op is dispatched per cycle.
  let LoadLatency = 4;       // Memory latency part (X in 4+X)
  let MispredictPenalty = 3;
  let CompleteModel = false;
  let EnableIntervals = true;
  let UnsupportedFeatures = [HasStdExtZbkb, HasStdExtZbkc, HasStdExtZbkx,
                             HasStdExtZcmt, HasStdExtZknd, HasStdExtZkne,
                             HasStdExtZknh, HasStdExtZksed, HasStdExtZksh,
                             HasStdExtZkr, HasVInstructions, HasVInstructionsI64,HasVendorXxldspn3x];
}

def Nuclei900PipeA : ProcResource<1>;
def Nuclei900PipeB : ProcResource<1>;
def Nuclei900FDiv  : ProcResource<1>;
def Nuclei900IDiv  : ProcResource<1>;
def Nuclei900UnitIMul       : ProcResource<1>; // Int Multiply
def Nuclei900UnitMem        : ProcResource<1>; // Load/Store
def Nuclei900UnitB          : ProcResource<1>; // Branch

def Nuclei900UnitFPALU      : ProcResource<1>; // FP ALU
def Nuclei900UnitFPDivSqrt  : ProcResource<1>; // FP Divide/Sqrt

def Nuclei900UnitIDiv       : ProcResource<1>; // Int Division

def : ProcWriteResources<[Nuclei900PipeA]>;  // PipeA: ALU/加载/分支
def : ProcWriteResources<[Nuclei900PipeB]>;  // PipeB: ALU/乘法/存储

def Nuclei900DispatchRules : SchedPredicate<"(!isLoad(Instr.SchedClass) && !isStore(Instr.SchedClass)) || (isLoad(Instr.SchedClass) ^ isStore(Instr.SchedClass))">;

def : Predicate<"TM.Options.BranchPredictionEnabled">;

//===----------------------------------------------------------------------===//

let SchedModel = Nuclei900Model in {

// Branching - 1 cycle
def : WriteRes<WriteJmp, [Nuclei900UnitB]> { let Latency = 1; }
def : WriteRes<WriteJal, [Nuclei900UnitB]> { let Latency = 1; }
def : WriteRes<WriteJalr, [Nuclei900UnitB]> { let Latency = 1; }

// Integer arithmetic and logic - 1 cycle
def : WriteRes<WriteIALU32, [Nuclei900PipeA]> { let Latency = 1; }
def : WriteRes<WriteIALU, [Nuclei900PipeA]> { let Latency = 1; }
def : WriteRes<WriteShiftImm32, [Nuclei900PipeA]> { let Latency = 1; }
def : WriteRes<WriteShiftImm, [Nuclei900PipeA]> { let Latency = 1; }
def : WriteRes<WriteShiftReg32, [Nuclei900PipeA]> { let Latency = 1; }
def : WriteRes<WriteShiftReg, [Nuclei900PipeA]> { let Latency = 1; }

// Integer multiplication - 3 cycles (configurable)
let Latency = 3 in {
def : WriteRes<WriteIMul, [Nuclei900UnitIMul]>;
def : WriteRes<WriteIMul32, [Nuclei900UnitIMul]>;
}

// Integer division - Radix 4 configuration
def : WriteRes<WriteIDiv32, [Nuclei900UnitIDiv]> {
  let Latency = 17;
  let ReleaseAtCycles = [17];
}
def : WriteRes<WriteIDiv, [Nuclei900UnitIDiv]> {
  let Latency = 33;
  let ReleaseAtCycles = [33];
}

// Integer remainder - same as division
def : WriteRes<WriteIRem32, [Nuclei900UnitIDiv]> {
  let Latency = 17;
  let ReleaseAtCycles = [17];
}
def : WriteRes<WriteIRem, [Nuclei900UnitIDiv]> {
  let Latency = 33;
  let ReleaseAtCycles = [33];
}

// Store instructions - 1 cycle
def : WriteRes<WriteSTB, [Nuclei900UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTH, [Nuclei900UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTW, [Nuclei900UnitMem]> { let Latency = 1; }
def : WriteRes<WriteSTD, [Nuclei900UnitMem]> { let Latency = 1; }
def : WriteRes<WriteFST32, [Nuclei900UnitMem]> { let Latency = 1; }
def : WriteRes<WriteFST64, [Nuclei900UnitMem]> { let Latency = 1; }

// Load instructions - 4+X cycles (X is memory latency, set to 4 in model)
def : WriteRes<WriteLDB, [Nuclei900UnitMem]> { let Latency = 8; } // 4+X where X=4
def : WriteRes<WriteLDH, [Nuclei900UnitMem]> { let Latency = 8; } // 4+X where X=4
def : WriteRes<WriteLDW, [Nuclei900UnitMem]> { let Latency = 8; } // 4+X where X=4
def : WriteRes<WriteLDD, [Nuclei900UnitMem]> { let Latency = 8; } // 4+X where X=4
def : WriteRes<WriteFLD32, [Nuclei900UnitMem]> { let Latency = 8; } // 4+X where X=4
def : WriteRes<WriteFLD64, [Nuclei900UnitMem]> { let Latency = 8; } // 4+X where X=4

// Atomic memory
def : WriteRes<WriteAtomicW, [Nuclei900UnitMem]> { let Latency = 8; } // Assume same as load
def : WriteRes<WriteAtomicD, [Nuclei900UnitMem]> { let Latency = 8; } // Assume same as load
def : WriteRes<WriteAtomicLDW, [Nuclei900UnitMem]> { let Latency = 8; } // Assume same as load
def : WriteRes<WriteAtomicLDD, [Nuclei900UnitMem]> { let Latency = 8; } // Assume same as load
def : WriteRes<WriteAtomicSTW, [Nuclei900UnitMem]> { let Latency = 1; }
def : WriteRes<WriteAtomicSTD, [Nuclei900UnitMem]> { let Latency = 1; }

// FP Misc instructions - 3 cycles
let Latency = 3 in {
def : WriteRes<WriteFSGNJ32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFMinMax32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFSGNJ64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFMinMax64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFClass32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFClass64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCmp32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCmp64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFMovF32ToI32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFMovI32ToF32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFMovF64ToI64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFMovI64ToF64, [Nuclei900UnitFPALU]>;
}

// FP Conversions - 3 cycles
let Latency = 3 in {
def : WriteRes<WriteFCvtI32ToF32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtI32ToF64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtI64ToF64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToI64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI32, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToI64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtF32ToF64, [Nuclei900UnitFPALU]>;
def : WriteRes<WriteFCvtF64ToF32, [Nuclei900UnitFPALU]>;
}

// FPU resource definitions
def Nuclei900UnitFPAdd : ProcResource<2> { let BufferSize = 4; }
def Nuclei900UnitFPMul : ProcResource<1> { let BufferSize = 2; }

// FP Arithmetic operations
def : WriteRes<WriteFAdd32, [Nuclei900UnitFPAdd]> { let Latency = 3; }
def : WriteRes<WriteFAdd64, [Nuclei900UnitFPAdd]> { let Latency = 5; }

def : WriteRes<WriteFMul32, [Nuclei900UnitFPMul]> { let Latency = 4; }
def : WriteRes<WriteFMul64, [Nuclei900UnitFPMul]> { let Latency = 5; }

def : WriteRes<WriteFMA32, [Nuclei900UnitFPMul]> { let Latency = 4; }
def : WriteRes<WriteFMA64, [Nuclei900UnitFPMul]> { let Latency = 5; }

// FP division - Radix 4 configuration
def : WriteRes<WriteFDiv32, [Nuclei900UnitFPDivSqrt]> {
  let Latency = 20;
  let ReleaseAtCycles = [20];
}
def : WriteRes<WriteFDiv64, [Nuclei900UnitFPDivSqrt]> {
  let Latency = 34;
  let ReleaseAtCycles = [34];
}

// FP square root - Radix 4 configuration
def : WriteRes<WriteFSqrt32, [Nuclei900UnitFPDivSqrt]> {
  let Latency = 20;
  let ReleaseAtCycles = [20];
}
def : WriteRes<WriteFSqrt64, [Nuclei900UnitFPDivSqrt]> {
  let Latency = 34;
  let ReleaseAtCycles = [34];
}

// Others
def : WriteRes<WriteCSR, []> { let Latency = 1; }
def : WriteRes<WriteNop, []> { let Latency = 0; }

def : InstRW<[WriteIALU], (instrs COPY)>;

//===----------------------------------------------------------------------===//
// Bypass and advance
def : ReadAdvance<ReadJmp, 0>;
def : ReadAdvance<ReadJalr, 1>;
def : ReadAdvance<ReadCSR, 0>;
def : ReadAdvance<ReadStoreData, 0>;
def : ReadAdvance<ReadMemBase, 1>;
def : ReadAdvance<ReadIALU, 1>;
def : ReadAdvance<ReadIALU32, 1>;
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

// FPU read advances
def : ReadAdvance<ReadFAdd32, 2>;
def : ReadAdvance<ReadFAdd64, 4>;
def : ReadAdvance<ReadFMul32, 2>;
def : ReadAdvance<ReadFMul64, 4>;
def : ReadAdvance<ReadFMA32, 2>;
def : ReadAdvance<ReadFMA32Addend, 3>;
def : ReadAdvance<ReadFMA64, 4>;
def : ReadAdvance<ReadFMA64Addend, 5>;
def : ReadAdvance<ReadFDiv32, 0>;
def : ReadAdvance<ReadFDiv64, 0>;
def : ReadAdvance<ReadFSqrt32, 0>;
def : ReadAdvance<ReadFSqrt64, 0>;
def : ReadAdvance<ReadFCmp32, 2>;
def : ReadAdvance<ReadFCmp64, 4>;
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
