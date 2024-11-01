//==--- riscv_xlvqmacc.td - RISC-V Nuclei custom VPU instructions list -----===//
//
//  Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
//  See https://llvm.org/LICENSE.txt for license information.
//  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//
// Instruction definitions
//===----------------------------------------------------------------------===//

multiclass RVVVQMACCBuiltinSet<list<list<string>> suffixes_prototypes> {
  let OverloadedName = NAME,
      Name = NAME,
      HasMasked = false,
      Log2LMUL = [-2, -1, 0, 1] in
    defm NAME : RVVOutOp1Op2BuiltinSet<NAME, "c", suffixes_prototypes>;
}

let UnMaskedPolicyScheme = HasPolicyOperand in
  let RequiredFeatures = ["Xxlvqmacc"] in {
    defm xl_vqmaccu_4x4x4  : RVVVQMACCBuiltinSet<[["", "q", "qqSUvUv"]]>;
    defm xl_vqmacc_4x4x4   : RVVVQMACCBuiltinSet<[["", "q", "qqSvv"]]>;
    defm xl_vqmaccus_4x4x4 : RVVVQMACCBuiltinSet<[["", "q", "qqSUvv"]]>;
    defm xl_vqmaccsu_4x4x4 : RVVVQMACCBuiltinSet<[["", "q", "qqSvUv"]]>;
  }
