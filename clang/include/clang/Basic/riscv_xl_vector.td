//==--- riscv_xl_vector.td - RISC-V V-ext Builtin function list --------------===//
//
//  Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
//  See https://llvm.org/LICENSE.txt for license information.
//  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the builtins for Nuclei Xxlvfbf extension. See:
//
//     https://github.com/riscv/rvv-intrinsic-doc
//
//===----------------------------------------------------------------------===//

let RequiredFeatures = ["Xxlvfbf"] in {
  // vfadd/vfsub/vfmul/vfdiv
  // vfmin/vfmax/vfsgnj/vfsgnjn/vfsgnjx
  multiclass RVVBFloatingBinBuiltinSet_XL {
      let OverloadedName = NAME in
      defm "" : RVVOutOp1BuiltinSet<!substr(NAME, 3), "y",
                            [["vv", "v", "vvv"],
                            ["vf", "v", "vve"]]>;
  }

  multiclass RVVBFloatingBinBuiltinSetRoundingMode_XL {
      let OverloadedName = NAME in
      defm "" : RVVOutOp1BuiltinSet<!substr(NAME, 3), "y",
                            [["vv", "v", "vvvu"],
                            ["vf", "v", "vveu"]]>;

  }

  // vfrsub/vfrdiv/vfslide1up/vfslide1down
  multiclass RVVBFloatingBinVFBuiltinSet_XL {
    let OverloadedName = NAME in
    defm "" : RVVOutOp1BuiltinSet<!substr(NAME, 3), "y",
                            [["vf", "v", "vve"]]>;

  }

  multiclass RVVBFloatingBinVFBuiltinSetRoundingMode_XL {
    let OverloadedName = NAME in
    defm "" : RVVOutOp1BuiltinSet<!substr(NAME, 3), "y",
                            [["vf", "v", "vveu"]]>;
  }

  // vfwadd/vfwsub
  multiclass RVVBFloatingWidenOp0BinBuiltinSet_XL {
    let OverloadedName = NAME in
    defm "" : RVVWidenWOp0BuiltinSet<!substr(NAME, 3) # "_w", "y",
                              [["wv", "w", "wwv"],
                                ["wf", "w", "wwe"]]>;
  }

  multiclass RVVBFloatingWidenOp0BinBuiltinSetRoundingMode_XL {
    let OverloadedName = NAME in
    defm "" : RVVWidenWOp0BuiltinSet<!substr(NAME, 3) # "_w", "y",
                              [["wv", "w", "wwvu"],
                                ["wf", "w", "wweu"]]>;
  }
  // vfwadd/vfwsub
  multiclass RVVBFloatingWidenBinBuiltinSet_XL {
    let OverloadedName = NAME in
    defm "" : RVVWidenBuiltinSet<!substr(NAME, 3), "y",
                          [["vv", "w", "wvv"],
                            ["vf", "w", "wve"]]>;
  }

  multiclass RVVBFloatingWidenBinBuiltinSetRoundingMode_XL {
    let OverloadedName = NAME in
    defm "" : RVVWidenBuiltinSet<!substr(NAME, 3), "y",
                          [["vv", "w", "wvvu"],
                            ["vf", "w", "wveu"]]>;
  }

  // vfmacc/vfnmacc/vfmsac/vfmadd/vfnmadd/vfmsub/vfnmsub
  let HasMaskedOffOperand = false in {
      multiclass RVVBFloatingTerBuiltinSet_XL {
        let OverloadedName = NAME in
        defm "" : RVVOutOp1BuiltinSet<!substr(NAME, 3), "y",
                                    [["vv", "v", "vvvv"],
                                    ["vf", "v", "vvev"]]>;

      }
      multiclass RVVBFloatingTerBuiltinSetRoundingMode_XL {
        let OverloadedName = NAME in
        defm "" : RVVOutOp1BuiltinSet<!substr(NAME, 3), "y",
                                    [["vv", "v", "vvvvu"],
                                    ["vf", "v", "vvevu"]]>;
      }
  }

  // vfwmacc/vfwnmacc/vfwmsac/vfwnmsac
  let HasMaskedOffOperand = false, Log2LMUL = [-2, -1, 0, 1, 2] in {
    multiclass RVVBFloatingWidenTerBuiltinSet_XL {
      let OverloadedName = NAME in
      defm ""  : RVVOutOp1Op2BuiltinSet<!substr(NAME, 3), "y",
                                        [["vv", "Fw", "FwFwvv"],
                                        ["vf", "Fw", "FwFwev"]]>;
    }
    multiclass RVVBFloatingWidenTerBuiltinSetRoundingMode_XL {
      let OverloadedName = NAME in
      defm ""  : RVVOutOp1Op2BuiltinSet<!substr(NAME, 3), "y",
                                        [["vv", "Fw", "FwFwvvu"],
                                        ["vf", "Fw", "FwFwevu"]]>;
    }
  }

  // 11.16. Vector Integer Move Instructions
  let HasMasked = false, UnMaskedPolicyScheme = HasPassthruOperand,
      MaskedPolicyScheme = NonePolicy, OverloadedName = "xl_vmv_v" in {
      defm xl_vmv_v : RVVOutBuiltinSet<"vmv_v_v", "y", [["v", "v", "vv"]]>;
  }

  let UnMaskedPolicyScheme = HasPassthruOperand in {
    // 13.11. Vector Floating-Point MIN/MAX Instructions
    defm xl_vfmin : RVVBFloatingBinBuiltinSet_XL;
    defm xl_vfmax : RVVBFloatingBinBuiltinSet_XL;

    // 13.12. Vector Floating-Point Sign-Injection Instructions
    defm xl_vfsgnj  : RVVBFloatingBinBuiltinSet_XL;
    defm xl_vfsgnjn : RVVBFloatingBinBuiltinSet_XL;
    defm xl_vfsgnjx : RVVBFloatingBinBuiltinSet_XL;
  }

  // 13.13. Vector Floating-Point Compare Instructions
  // vmfeq/vmfne/vmflt/vmfle/vmfgt/vmfge
  multiclass RVVBFloatingMaskOutBuiltinSet_XL {
    let OverloadedName = NAME in
    defm "" : RVVOp0Op1BuiltinSet<!substr(NAME, 3), "y",
                            [["vv", "vm", "mvv"],
                            ["vf", "vm", "mve"]]>;
  }

  // 13.16. Vector Floating-Point Move Instruction
  let HasMasked = false,
      UnMaskedPolicyScheme = HasPassthruOperand,
      SupportOverloading = false,
      MaskedPolicyScheme = NonePolicy,
      OverloadedName = "xl_vfmv_v" in
    defm xl_vfmv_v : RVVOutBuiltinSet<"vfmv_v_f", "y",
                                    [["f", "v", "ve"]]>;

  // 13.17. Single-Width Floating-Point/Integer Type-Convert Instructions
  // 13.18. Widening Floating-Point/Integer Type-Convert Instructions
  // 13.19. Narrowing Floating-Point/Integer Type-Convert Instructions
  // vfcvt_rtz_xu_f/vfcvt_rtz_x_f/vfcvt_x_f/vfcvt_xu_f/vfcvt_f_x/vfcvt_f_xu
  // vfwcvt_rtz_xu_f/vfwcvt_rtz_x_f/vfwcvt_f_xu/vfwcvt_f_x/vfwcvt_f_f/vfwcvt_x_f/vfwcvt_xu_f
  // vfncvt_rtz_xu_f/vfncvt_rtz_x_f/vfncvt_rod_f_f/vfncvt_x_f_w/vfncvt_xu_f_w/vfncvt_f_x_w/vfncvt_f_xu_w/vfncvt_f_f_w
  multiclass RVVConvBuiltinSet_XL<string intrinsic_name, string type_range,
                          list<list<string>> suffixes_prototypes, string overloaded_name>{
    let Name = intrinsic_name, OverloadedName = overloaded_name in
    defm : RVVConvBuiltinSet<!substr(intrinsic_name,3), type_range, suffixes_prototypes>;
  }

  // 14. Vector Reduction Operations
  let HasMaskedOffOperand = true in {
    // vfredmax/vfredmin/vfredusum/vfredosum
    multiclass RVVFloatingReductionBuiltin_XL {
      let OverloadedName = NAME in
      defm "" : RVVOutOp0BuiltinSet<!substr(NAME, 3), "y",
                                        [["vs", "vSv", "SvvSv"]]>;
    }
    multiclass RVVFloatingReductionBuiltinRoundingMode_XL {
      let OverloadedName = NAME in
      defm "" : RVVOutOp0BuiltinSet<!substr(NAME, 3), "y",
                                        [["vs", "vSv", "SvvSvu"]]>;
    }
    // vfwredusum/vfredosum
    multiclass RVVFloatingWidenReductionBuiltin_XL {
      let OverloadedName = NAME in
      defm "" : RVVOutOp0BuiltinSet<!substr(NAME, 3), "y",
                                        [["vs", "vSw", "SwvSw"]]>;
    }
    multiclass RVVFloatingWidenReductionBuiltinRoundingMode_XL {
      let OverloadedName = NAME in
      defm "" : RVVOutOp0BuiltinSet<!substr(NAME, 3), "y",
                                        [["vs", "vSw", "SwvSwu"]]>;
    }
  }

  // 16.2. Floating-Point Scalar Move Instructions
  let HasMasked = false, MaskedPolicyScheme = NonePolicy in {
    let HasVL = false, OverloadedName = "xl_vfmv_f" in
      defm xl_vfmv_f : RVVOp0BuiltinSet<"vfmv_f_s", "y",
                                      [["s", "ve", "ev"]]>;
    let UnMaskedPolicyScheme = HasPassthruOperand,
        SupportOverloading = false, OverloadedName = "xl_vfmv_s" in
      defm xl_vfmv_s : RVVOutBuiltinSet<"vfmv_s_f", "y",
                                      [["f", "v", "ve"]]>;
  }

  // 16.3.1. Vector Slideup Instructions
  let UnMaskedPolicyScheme = HasPolicyOperand,
      HasMaskedOffOperand = false in {
    multiclass RVVSlideUpBuiltinSet_XL {
      let OverloadedName = "xl_vslideup" in
      defm "" : RVVOutBuiltinSet<!substr(NAME, 3), "y", [["vx","v", "vvvz"]]>;
    }
  }

  // 16.4. Vector Register Gather Instructions
  // signed and floating type
  let OverloadedName = "xl_vrgather_vv" in
    defm xl_vrgather : RVVOutBuiltinSet<"vrgather_vv", "y", [["vv", "v", "vvUv"]]>;
  let OverloadedName = "xl_vrgather_vx" in
    defm xl_vrgather : RVVOutBuiltinSet<"vrgather_vx", "y", [["vx", "v", "vvz"]]>;
  let OverloadedName = "xl_vrgatherei16_vv" in
    defm xl_vrgatherei16 : RVVOutBuiltinSet<"vrgatherei16_vv", "y", [["vv", "v", "vv(Log2EEW:4)Uv"]]>;
}
