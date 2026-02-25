//===-- RISCVInstrInfoXxlvfbf.td - 'Xxlvfbf*' instructions -----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the RISC-V instructions from the Nuclei custom 'Xxlvfbf'
// extension, providing vector arithmetic instructions for BFloat16.
// This version is still experimental as the vector arithmetic instructions for
// BFloat16 hasn't been ratified yet.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//
multiclass VPatConversionVI_VBF<string intrinsic,
                               string instruction> {
  foreach fvti = AllBFloatVectors in {
    defvar ivti = GetIntVTypeInfo<fvti>.Vti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<ivti>.Predicates) in
    defm : VPatConversion<intrinsic, instruction, "V",
                          ivti.Vector, fvti.Vector, ivti.Mask, fvti.Log2SEW,
                          fvti.LMul, ivti.RegClass, fvti.RegClass>;
  }
}

multiclass VPatConversionVI_VBF_RM<string intrinsic, string instruction> {
  foreach fvti = AllBFloatVectors in {
    defvar ivti = GetIntVTypeInfo<fvti>.Vti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<ivti>.Predicates) in
    defm : VPatConversionRoundingMode<intrinsic, instruction, "V",
                                      ivti.Vector, fvti.Vector, ivti.Mask, fvti.Log2SEW,
                                      fvti.LMul, ivti.RegClass, fvti.RegClass>;
  }
}

multiclass VPatConversionVI_VBF_RTZ<string intrinsic, string instruction> {
  foreach fvti = AllBFloatVectors in {
    defvar ivti = GetIntVTypeInfo<fvti>.Vti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<ivti>.Predicates) in
    defm : VPatConversionRTZ<intrinsic, instruction, "V",
                                              ivti.Vector, fvti.Vector, ivti.Mask, fvti.Log2SEW,
                                              fvti.LMul, ivti.RegClass, fvti.RegClass>;
  }
}

multiclass VPatConversionVBF_VI_RM<string intrinsic, string instruction,
                                  bit isSEWAware = 0> {
  foreach fvti = AllBFloatVectors in {
    defvar ivti = GetIntVTypeInfo<fvti>.Vti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<ivti>.Predicates) in
    defm : VPatConversionRoundingMode<intrinsic, instruction, "V",
                                      fvti.Vector, ivti.Vector, fvti.Mask, ivti.Log2SEW,
                                      ivti.LMul, fvti.RegClass, ivti.RegClass,
                                      isSEWAware>;
  }
}

multiclass VPatConversionWI_VBF<string intrinsic, string instruction> {
  foreach fvtiToFWti = AllWidenableBFloatToFloatVectors in {
    defvar fvti = fvtiToFWti.Vti;
    defvar iwti = GetIntVTypeInfo<fvtiToFWti.Wti>.Vti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<iwti>.Predicates) in
    defm : VPatConversion<intrinsic, instruction, "V",
                          iwti.Vector, fvti.Vector, iwti.Mask, fvti.Log2SEW,
                          fvti.LMul, iwti.RegClass, fvti.RegClass>;
  }
}

multiclass VPatConversionWI_VBF_RM<string intrinsic, string instruction> {
  foreach fvtiToFWti = AllWidenableBFloatToFloatVectors in {
    defvar fvti = fvtiToFWti.Vti;
    defvar iwti = GetIntVTypeInfo<fvtiToFWti.Wti>.Vti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<iwti>.Predicates) in
    defm : VPatConversionRoundingMode<intrinsic, instruction, "V",
                                      iwti.Vector, fvti.Vector, iwti.Mask, fvti.Log2SEW,
                                      fvti.LMul, iwti.RegClass, fvti.RegClass>;
  }
}

multiclass VPatConversionWI_VBF_RTZ<string intrinsic, string instruction> {
  foreach fvtiToFWti = AllWidenableBFloatToFloatVectors in {
    defvar fvti = fvtiToFWti.Vti;
    defvar iwti = GetIntVTypeInfo<fvtiToFWti.Wti>.Vti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<iwti>.Predicates) in
    defm : VPatConversionRTZ<intrinsic, instruction, "V",
                             iwti.Vector, fvti.Vector, iwti.Mask, fvti.Log2SEW,
                             fvti.LMul, iwti.RegClass, fvti.RegClass>;
  }
}

multiclass VPatConversionWBF_VI<string intrinsic, string instruction,
                               bit isSEWAware = 0> {
  foreach vtiToWti = AllWidenableIntToBFloatVectors in {
    defvar vti = vtiToWti.Vti;
    defvar fwti = vtiToWti.Wti;
    let Predicates = !listconcat(GetVTypePredicates<vti>.Predicates,
                                 GetVTypePredicates<fwti>.Predicates) in
    defm : VPatConversion<intrinsic, instruction, "V",
                          fwti.Vector, vti.Vector, fwti.Mask, vti.Log2SEW,
                          vti.LMul, fwti.RegClass, vti.RegClass, isSEWAware>;
  }
}

multiclass VPatConversionVI_WBF<string intrinsic, string instruction> {
  foreach vtiToWti = AllWidenableIntToBFloatVectors in {
    defvar vti = vtiToWti.Vti;
    defvar fwti = vtiToWti.Wti;
    let Predicates = !listconcat(GetVTypePredicates<vti>.Predicates,
                                 GetVTypePredicates<fwti>.Predicates) in
    defm : VPatConversion<intrinsic, instruction, "W",
                          vti.Vector, fwti.Vector, vti.Mask, vti.Log2SEW,
                          vti.LMul, vti.RegClass, fwti.RegClass>;
  }
}

multiclass VPatConversionVI_WBF_RM <string intrinsic, string instruction> {
  foreach vtiToWti = AllWidenableIntToBFloatVectors in {
    defvar vti = vtiToWti.Vti;
    defvar fwti = vtiToWti.Wti;
    let Predicates = !listconcat(GetVTypePredicates<vti>.Predicates,
                                 GetVTypePredicates<fwti>.Predicates) in
    defm : VPatConversionRoundingMode<intrinsic, instruction, "W",
                                      vti.Vector, fwti.Vector, vti.Mask, vti.Log2SEW,
                                      vti.LMul, vti.RegClass, fwti.RegClass>;
  }
}

multiclass VPatConversionVI_WBF_RTZ <string intrinsic, string instruction> {
  foreach vtiToWti = AllWidenableIntToBFloatVectors in {
    defvar vti = vtiToWti.Vti;
    defvar fwti = vtiToWti.Wti;
    let Predicates = !listconcat(GetVTypePredicates<vti>.Predicates,
                                 GetVTypePredicates<fwti>.Predicates) in
    defm : VPatConversionRTZ<intrinsic, instruction, "W",
                             vti.Vector, fwti.Vector, vti.Mask, vti.Log2SEW,
                             vti.LMul, vti.RegClass, fwti.RegClass>;
  }
}

multiclass VPatConversionVBF_WI_RM <string intrinsic, string instruction,
                                   bit isSEWAware = 0> {
  foreach fvtiToFWti = AllWidenableBFloatToFloatVectors in {
    defvar fvti = fvtiToFWti.Vti;
    defvar iwti = GetIntVTypeInfo<fvtiToFWti.Wti>.Vti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<iwti>.Predicates) in
    defm : VPatConversionRoundingMode<intrinsic, instruction, "W",
                                      fvti.Vector, iwti.Vector, fvti.Mask, fvti.Log2SEW,
                                      fvti.LMul, fvti.RegClass, iwti.RegClass,
                                      isSEWAware>;
  }
}

multiclass VPatConversionVBF_WF<string intrinsic, string instruction,
                               bit isSEWAware = 0> {
  foreach fvtiToFWti = AllWidenableBFloatToFloatVectors in {
    defvar fvti = fvtiToFWti.Vti;
    defvar fwti = fvtiToFWti.Wti;
    let Predicates = !listconcat(GetVTypePredicates<fvti>.Predicates,
                                 GetVTypePredicates<fwti>.Predicates) in
    defm : VPatConversion<intrinsic, instruction, "W",
                          fvti.Vector, fwti.Vector, fvti.Mask, fvti.Log2SEW,
                          fvti.LMul, fvti.RegClass, fwti.RegClass, isSEWAware>;
  }
}

multiclass VPatReductionVBF_VS<string intrinsic, string instruction> {
  foreach vti = NoGroupBFloatVectors in {
    defvar vectorM1 = !cast<VTypeInfo>("VBF" # vti.SEW # "M1");
    let Predicates = GetVTypePredicates<vti>.Predicates in
    defm : VPatTernaryTU<intrinsic, instruction, "VS",
                         vectorM1.Vector, vti.Vector,
                         vectorM1.Vector, vti.Mask,
                         vti.Log2SEW, vti.LMul,
                         VR, vti.RegClass, VR>;
  }
  foreach gvti = GroupBFloatVectors in {
    let Predicates = GetVTypePredicates<gvti>.Predicates in
    defm : VPatTernaryTU<intrinsic, instruction, "VS",
                         gvti.VectorM1, gvti.Vector,
                         gvti.VectorM1, gvti.Mask,
                         gvti.Log2SEW, gvti.LMul,
                         VR, gvti.RegClass, VR>;
  }
}

multiclass VPatReductionVBF_VS_RM<string intrinsic, string instruction> {
  foreach vti = NoGroupBFloatVectors in {
    defvar vectorM1 = !cast<VTypeInfo>( "VBF" # vti.SEW # "M1");
    let Predicates = GetVTypePredicates<vti>.Predicates in
    defm : VPatTernaryTURoundingMode<intrinsic, instruction, "VS",
                                     vectorM1.Vector, vti.Vector,
                                     vectorM1.Vector, vti.Mask,
                                     vti.Log2SEW, vti.LMul,
                                     VR, vti.RegClass, VR>;
  }
  foreach gvti = GroupBFloatVectors in {
    let Predicates = GetVTypePredicates<gvti>.Predicates in
    defm : VPatTernaryTURoundingMode<intrinsic, instruction, "VS",
                                     gvti.VectorM1, gvti.Vector,
                                     gvti.VectorM1, gvti.Mask,
                                     gvti.Log2SEW, gvti.LMul,
                                     VR, gvti.RegClass, VR>;
  }
}

multiclass VPatReductionWBF_VS_RM<string intrinsic, string instruction> {
  foreach vti = AllBFloatVectors in {
    defvar wtiSEW = !mul(vti.SEW, 2);
    if !le(wtiSEW, 64) then {
      defvar wtiM1 = !cast<VTypeInfo>("VF" # wtiSEW # "M1");
      let Predicates = GetVTypePredicates<vti>.Predicates in
      defm : VPatTernaryTURoundingMode<intrinsic, instruction, "VS",
                                       wtiM1.Vector, vti.Vector,
                                       wtiM1.Vector, vti.Mask,
                                       vti.Log2SEW, vti.LMul,
                                       wtiM1.RegClass, vti.RegClass,
                                       wtiM1.RegClass>;
    }
  }
}

let Predicates = [HasVendorXxlvfbf] in {
  defm : VPatBinaryV_VV_VX_RM<"int_riscv_vfadd", "PseudoVFADD", AllBFloatVectors,isSEWAware = 1>;
  defm : VPatBinaryV_VV_VX_RM<"int_riscv_vfsub", "PseudoVFSUB", AllBFloatVectors,isSEWAware = 1>;
  defm : VPatBinaryV_VX_RM<"int_riscv_vfrsub", "PseudoVFRSUB", AllBFloatVectors,isSEWAware = 1>;

  //===----------------------------------------------------------------------===//
  // 13.3. Vector Widening Floating-Point Add/Subtract Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatBinaryW_VV_VX_RM<"int_riscv_vfwadd", "PseudoVFWADD", AllWidenableBFloatToFloatVectors, isSEWAware=1>;
  defm : VPatBinaryW_VV_VX_RM<"int_riscv_vfwsub", "PseudoVFWSUB", AllWidenableBFloatToFloatVectors, isSEWAware=1>;
  defm : VPatBinaryW_WV_WX_RM<"int_riscv_vfwadd_w", "PseudoVFWADD", AllWidenableBFloatToFloatVectors, isSEWAware=1>;
  defm : VPatBinaryW_WV_WX_RM<"int_riscv_vfwsub_w", "PseudoVFWSUB", AllWidenableBFloatToFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.4. Vector Single-Width Floating-Point Multiply/Divide Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatBinaryV_VV_VX_RM<"int_riscv_vfmul", "PseudoVFMUL", AllBFloatVectors, isSEWAware=1>;
  defm : VPatBinaryV_VV_VX_RM<"int_riscv_vfdiv", "PseudoVFDIV", AllBFloatVectors, isSEWAware=1>;
  defm : VPatBinaryV_VX_RM<"int_riscv_vfrdiv", "PseudoVFRDIV", AllBFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.5. Vector Widening Floating-Point Multiply
  //===----------------------------------------------------------------------===//
  defm : VPatBinaryW_VV_VX_RM<"int_riscv_vfwmul", "PseudoVFWMUL",AllWidenableBFloatToFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.6. Vector Single-Width Floating-Point Fused Multiply-Add Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatTernaryV_VV_VX_AAXA_RM<"int_riscv_vfmacc", "PseudoVFMACC",AllBFloatVectors, isSEWAware=1>;
  defm : VPatTernaryV_VV_VX_AAXA_RM<"int_riscv_vfnmacc", "PseudoVFNMACC",AllBFloatVectors, isSEWAware=1>;
  defm : VPatTernaryV_VV_VX_AAXA_RM<"int_riscv_vfmsac", "PseudoVFMSAC",AllBFloatVectors, isSEWAware=1>;
  defm : VPatTernaryV_VV_VX_AAXA_RM<"int_riscv_vfnmsac", "PseudoVFNMSAC",AllBFloatVectors, isSEWAware=1>;
  defm : VPatTernaryV_VV_VX_AAXA_RM<"int_riscv_vfmadd", "PseudoVFMADD",AllBFloatVectors, isSEWAware=1>;
  defm : VPatTernaryV_VV_VX_AAXA_RM<"int_riscv_vfnmadd", "PseudoVFNMADD",AllBFloatVectors, isSEWAware=1>;
  defm : VPatTernaryV_VV_VX_AAXA_RM<"int_riscv_vfmsub", "PseudoVFMSUB",AllBFloatVectors, isSEWAware=1>;
  defm : VPatTernaryV_VV_VX_AAXA_RM<"int_riscv_vfnmsub", "PseudoVFNMSUB",AllBFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.7. Vector Widening Floating-Point Fused Multiply-Add Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatTernaryW_VV_VX_RM<"int_riscv_vfwmacc", "PseudoVFWMACC",AllWidenableBFloatToFloatVectors, isSEWAware=1>;
  defm : VPatTernaryW_VV_VX_RM<"int_riscv_vfwnmacc", "PseudoVFWNMACC",AllWidenableBFloatToFloatVectors, isSEWAware=1>;
  defm : VPatTernaryW_VV_VX_RM<"int_riscv_vfwmsac", "PseudoVFWMSAC",AllWidenableBFloatToFloatVectors, isSEWAware=1>;
  defm : VPatTernaryW_VV_VX_RM<"int_riscv_vfwnmsac", "PseudoVFWNMSAC",AllWidenableBFloatToFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.8. Vector Floating-Point Square-Root Instruction
  //===----------------------------------------------------------------------===//
  defm : VPatUnaryV_V_RM<"int_riscv_vfsqrt", "PseudoVFSQRT", AllBFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.9. Vector Floating-Point Reciprocal Square-Root Estimate Instruction
  //===----------------------------------------------------------------------===//
  defm : VPatUnaryV_V<"int_riscv_vfrsqrt7", "PseudoVFRSQRT7", AllBFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.10. Vector Floating-Point Reciprocal Estimate Instruction
  //===----------------------------------------------------------------------===//
  defm : VPatUnaryV_V_RM<"int_riscv_vfrec7", "PseudoVFREC7", AllBFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.11. Vector Floating-Point Min/Max Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatBinaryV_VV_VX<"int_riscv_vfmin", "PseudoVFMIN", AllBFloatVectors, isSEWAware=1>;
  defm : VPatBinaryV_VV_VX<"int_riscv_vfmax", "PseudoVFMAX", AllBFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.12. Vector Floating-Point Sign-Injection Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatBinaryV_VV_VX<"int_riscv_vfsgnj", "PseudoVFSGNJ", AllBFloatVectors, isSEWAware=1>;
  defm : VPatBinaryV_VV_VX<"int_riscv_vfsgnjn", "PseudoVFSGNJN", AllBFloatVectors, isSEWAware=1>;
  defm : VPatBinaryV_VV_VX<"int_riscv_vfsgnjx", "PseudoVFSGNJX", AllBFloatVectors, isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.13. Vector Floating-Point Compare Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatBinaryM_VV_VX<"int_riscv_vmfeq", "PseudoVMFEQ", AllBFloatVectors>;
  defm : VPatBinaryM_VV_VX<"int_riscv_vmfle", "PseudoVMFLE", AllBFloatVectors>;
  defm : VPatBinaryM_VV_VX<"int_riscv_vmflt", "PseudoVMFLT", AllBFloatVectors>;
  defm : VPatBinaryM_VV_VX<"int_riscv_vmfne", "PseudoVMFNE", AllBFloatVectors>;
  defm : VPatBinaryM_VX<"int_riscv_vmfgt", "PseudoVMFGT", AllBFloatVectors>;
  defm : VPatBinaryM_VX<"int_riscv_vmfge", "PseudoVMFGE", AllBFloatVectors>;
  defm : VPatBinarySwappedM_VV<"int_riscv_vmfgt", "PseudoVMFLT", AllBFloatVectors>;
  defm : VPatBinarySwappedM_VV<"int_riscv_vmfge", "PseudoVMFLE", AllBFloatVectors>;

  //===----------------------------------------------------------------------===//
  // 13.14. Vector Floating-Point Classify Instruction
  //===----------------------------------------------------------------------===//
  defm : VPatConversionVI_VBF<"int_riscv_vfclass", "PseudoVFCLASS">;

  //===----------------------------------------------------------------------===//
  // 13.17. Single-Width Floating-Point/Integer Type-Convert Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatConversionVI_VBF_RTZ<"int_riscv_vfcvt_x_f_v", "PseudoVFCVT_RTZ_X_F">;
  defm : VPatConversionVI_VBF_RTZ<"int_riscv_vfcvt_xu_f_v", "PseudoVFCVT_RTZ_XU_F">;
  defm : VPatConversionVI_VBF_RM<"int_riscv_vfcvt_x_f_v", "PseudoVFCVT_X_F">;
  defm : VPatConversionVI_VBF_RM<"int_riscv_vfcvt_xu_f_v", "PseudoVFCVT_XU_F">;
  defm : VPatConversionVI_VBF<"int_riscv_vfcvt_rtz_xu_f_v", "PseudoVFCVT_RTZ_XU_F">;
  defm : VPatConversionVI_VBF<"int_riscv_vfcvt_rtz_x_f_v", "PseudoVFCVT_RTZ_X_F">;
  defm : VPatConversionVBF_VI_RM<"int_riscv_vfcvt_f_x_v", "PseudoVFCVT_F_X",isSEWAware=1>;
  defm : VPatConversionVBF_VI_RM<"int_riscv_vfcvt_f_xu_v", "PseudoVFCVT_F_XU",isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.18. Widening Floating-Point/Integer Type-Convert Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatConversionWI_VBF_RTZ<"int_riscv_vfwcvt_xu_f_v", "PseudoVFWCVT_RTZ_XU_F">;
  defm : VPatConversionWI_VBF_RTZ<"int_riscv_vfwcvt_x_f_v", "PseudoVFWCVT_RTZ_X_F">;
  defm : VPatConversionWI_VBF_RM<"int_riscv_vfwcvt_xu_f_v", "PseudoVFWCVT_XU_F">;
  defm : VPatConversionWI_VBF_RM<"int_riscv_vfwcvt_x_f_v", "PseudoVFWCVT_X_F">;
  defm : VPatConversionWI_VBF<"int_riscv_vfwcvt_rtz_xu_f_v", "PseudoVFWCVT_RTZ_XU_F">;
  defm : VPatConversionWI_VBF<"int_riscv_vfwcvt_rtz_x_f_v", "PseudoVFWCVT_RTZ_X_F">;
  defm : VPatConversionWBF_VI<"int_riscv_vfwcvt_f_xu_v", "PseudoVFWCVT_F_XU",isSEWAware=1>;
  defm : VPatConversionWBF_VI<"int_riscv_vfwcvt_f_x_v", "PseudoVFWCVT_F_X",isSEWAware=1>;
  defm : VPatConversionWF_VF_BF<"int_riscv_vfwcvt_f_f_v", "PseudoVFWCVT_F_F",isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 13.19. Narrowing Floating-Point/Integer Type-Convert Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatConversionVI_WBF_RTZ<"int_riscv_vfncvt_xu_f_w", "PseudoVFNCVT_RTZ_XU_F">;
  defm : VPatConversionVI_WBF_RTZ<"int_riscv_vfncvt_x_f_w", "PseudoVFNCVT_RTZ_X_F">;
  defm : VPatConversionVI_WBF_RM<"int_riscv_vfncvt_xu_f_w", "PseudoVFNCVT_XU_F">;
  defm : VPatConversionVI_WBF_RM<"int_riscv_vfncvt_x_f_w", "PseudoVFNCVT_X_F">;
  defm : VPatConversionVI_WBF<"int_riscv_vfncvt_rtz_xu_f_w", "PseudoVFNCVT_RTZ_XU_F">;
  defm : VPatConversionVI_WBF<"int_riscv_vfncvt_rtz_x_f_w", "PseudoVFNCVT_RTZ_X_F">;
  defm : VPatConversionVBF_WI_RM<"int_riscv_vfncvt_f_xu_w", "PseudoVFNCVT_F_XU",isSEWAware=1>;
  defm : VPatConversionVBF_WI_RM<"int_riscv_vfncvt_f_x_w", "PseudoVFNCVT_F_X",isSEWAware=1>;
  defm : VPatConversionVF_WF_RM<"int_riscv_vfncvt_f_f_w", "PseudoVFNCVT_F_F", AllWidenableBFloatToFloatVectors, isSEWAware=1>;
  defm : VPatConversionVBF_WF<"int_riscv_vfncvt_rod_f_f_w", "PseudoVFNCVT_ROD_F_F",isSEWAware=1>;

  //===----------------------------------------------------------------------===//
  // 14.3. Vector Single-Width Floating-Point Reduction Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatReductionVBF_VS_RM<"int_riscv_vfredosum", "PseudoVFREDOSUM">;
  defm : VPatReductionVBF_VS_RM<"int_riscv_vfredusum", "PseudoVFREDUSUM">;
  defm : VPatReductionVBF_VS<"int_riscv_vfredmin", "PseudoVFREDMIN">;
  defm : VPatReductionVBF_VS<"int_riscv_vfredmax", "PseudoVFREDMAX">;

  //===----------------------------------------------------------------------===//
  // 14.4. Vector Widening Floating-Point Reduction Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatReductionWBF_VS_RM<"int_riscv_vfwredusum", "PseudoVFWREDUSUM">;
  defm : VPatReductionWBF_VS_RM<"int_riscv_vfwredosum", "PseudoVFWREDOSUM">;

  //===----------------------------------------------------------------------===//
  // 16.3. Vector Slide Instructions
  //===----------------------------------------------------------------------===//
  defm : VPatBinaryV_VX<"int_riscv_vfslide1up", "PseudoVFSLIDE1UP", AllBFloatVectors>;
  defm : VPatBinaryV_VX<"int_riscv_vfslide1down", "PseudoVFSLIDE1DOWN", AllBFloatVectors>;

}
