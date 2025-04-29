//===-- RISCVInstrInfoXxlfbf.td - RISC-V 'xxlfbf' instructions ---*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the RISC-V instructions from the standard 'Xxlfbf'
// BF16 floating-point extension, version 1.0.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// RISC-V specific DAG Nodes.
//===----------------------------------------------------------------------===//

def XxlfbfExt  : ExtInfo<"", "", [HasVendorXxlfbf],
                         bf16, FPR16, FPR32, ?, FPR16>;

defvar Ext = XxlfbfExt;



let Predicates = [HasVendorXxlfbf] in {
  /// Loads
  def : LdPat<load, FLH, bf16>;

  /// Stores
  def : StPat<store, FSH, FPR16, bf16>;

} // Predicates = [HasVendorXxlfbf]


let Predicates = [HasVendorXxlfbf] in {
  defm : PatFprFprDynFrm_m<any_fadd, FADD_H, Ext>;
  defm : PatFprFprDynFrm_m<any_fsub, FSUB_H, Ext>;
  defm : PatFprFprDynFrm_m<any_fmul, FMUL_H, Ext>;
  defm : PatFprFprDynFrm_m<any_fdiv, FDIV_H, Ext>;
}

let Predicates = [HasVendorXxlfbf, HasStdExtD] in {
  /// Float conversion operations
  // f64 -> bf16, bf16 -> f64
  def : Pat<(bf16 (any_fpround FPR64:$rs1)), (FCVT_H_D FPR64:$rs1, FRM_DYN)>;
  def : Pat<(any_fpextend (bf16 FPR16:$rs1)), (FCVT_D_H FPR16:$rs1, FRM_RNE)>;

  /// Float arithmetic operations
  def : Pat<(bf16 (fcopysign FPR16:$rs1, FPR64:$rs2)),
            (FSGNJ_H $rs1, (FCVT_H_D $rs2, FRM_DYN))>;
  def : Pat<(fcopysign FPR64:$rs1, (bf16 FPR16:$rs2)), (FSGNJ_D $rs1, (FCVT_D_H $rs2, FRM_RNE))>;
}

/* flt.h/fle.h/feq.h */
let Predicates = [HasVendorXxlfbf] in {

  def : InstAlias<"fgt.h $rd, $rs, $rt",
                  (FLT_H GPR:$rd, FPR16:$rt, FPR16:$rs), 0>;
  def : InstAlias<"fge.h $rd, $rs, $rt",
                  (FLE_H GPR:$rd, FPR16:$rt, FPR16:$rs), 0>;

  defm : PatSetCC_m<any_fsetcc,    SETEQ,  FEQ_H,            Ext>;
  defm : PatSetCC_m<any_fsetcc,    SETOEQ, FEQ_H,            Ext>;
  defm : PatSetCC_m<strict_fsetcc, SETLT,  PseudoQuietFLT_H, Ext>;
  defm : PatSetCC_m<strict_fsetcc, SETOLT, PseudoQuietFLT_H, Ext>;
  defm : PatSetCC_m<strict_fsetcc, SETLE,  PseudoQuietFLE_H, Ext>;
  defm : PatSetCC_m<strict_fsetcc, SETOLE, PseudoQuietFLE_H, Ext>;

// Match signaling FEQ_H
  def : Pat<(XLenVT (strict_fsetccs (bf16 FPR16:$rs1), FPR16:$rs2, SETEQ)),
            (AND (XLenVT (FLE_H $rs1, $rs2)),
                (XLenVT (FLE_H $rs2, $rs1)))>;
  def : Pat<(XLenVT (strict_fsetccs (bf16 FPR16:$rs1), FPR16:$rs2, SETOEQ)),
            (AND (XLenVT (FLE_H $rs1, $rs2)),
                (XLenVT (FLE_H $rs2, $rs1)))>;
  // If both operands are the same, use a single FLE.
  def : Pat<(XLenVT (strict_fsetccs (bf16 FPR16:$rs1), (bf16 FPR16:$rs1), SETEQ)),
            (FLE_H $rs1, $rs1)>;
  def : Pat<(XLenVT (strict_fsetccs (bf16 FPR16:$rs1), (bf16 FPR16:$rs1), SETOEQ)),
            (FLE_H $rs1, $rs1)>;

  defm : PatSetCC_m<any_fsetccs, SETLT,  FLT_H, Ext>;
  defm : PatSetCC_m<any_fsetccs, SETOLT, FLT_H, Ext>;
  defm : PatSetCC_m<any_fsetccs, SETLE,  FLE_H, Ext>;
  defm : PatSetCC_m<any_fsetccs, SETOLE, FLE_H, Ext>;

  defm Select_FPRbf16 : SelectCC_GPR_rrirr<FPR16, bf16>;
}

/* fmin.h/fmax.h*/
let Predicates = [HasVendorXxlfbf] in {
  defm : PatFprFpr_m<fminnum, FMIN_H, Ext>;
  defm : PatFprFpr_m<fmaxnum, FMAX_H, Ext>;
  defm : PatFprFpr_m<riscv_fmin, FMIN_H, Ext>;
  defm : PatFprFpr_m<riscv_fmax, FMAX_H, Ext>;
}

/* fsqrt.h/fclass.h/fsgnj.h/fsgnjn.h/fsgnjx.h  */
let Predicates = [HasVendorXxlfbf] in {
  def : Pat<(bf16 (any_fsqrt FPR16:$rs1)), (FSQRT_H FPR16:$rs1, FRM_DYN)>;

  def : Pat<(bf16 (fneg FPR16:$rs1)), (FSGNJN_H $rs1, $rs1)>;
  def : Pat<(bf16 (fabs FPR16:$rs1)), (FSGNJX_H $rs1, $rs1)>;

  def : Pat<(riscv_fclass (bf16 FPR16:$rs1)), (FCLASS_H $rs1)>;

  def : PatFprFpr<fcopysign, FSGNJ_H, FPR16, f16>;
  def : Pat<(bf16 (fcopysign FPR16:$rs1, (bf16 (fneg FPR16:$rs2)))), (FSGNJN_H $rs1, $rs2)>;
  def : Pat<(bf16 (fcopysign FPR16:$rs1, FPR32:$rs2)),
          (FSGNJ_H $rs1, (FCVT_H_S $rs2, FRM_DYN))>;
}


let Predicates = [HasVendorXxlfbf] in {
  // fmadd: rs1 * rs2 + rs3
  def : Pat<(bf16 (any_fma FPR16:$rs1, FPR16:$rs2, FPR16:$rs3)),
          (FMADD_H $rs1, $rs2, $rs3, FRM_DYN)>;

  // fmsub: rs1 * rs2 - rs3
  def : Pat<(bf16 (any_fma FPR16:$rs1, FPR16:$rs2, (fneg FPR16:$rs3))),
            (FMSUB_H FPR16:$rs1, FPR16:$rs2, FPR16:$rs3, FRM_DYN)>;

  // fnmsub: -rs1 * rs2 + rs3
  def : Pat<(bf16 (any_fma (fneg FPR16:$rs1), FPR16:$rs2, FPR16:$rs3)),
            (FNMSUB_H FPR16:$rs1, FPR16:$rs2, FPR16:$rs3, FRM_DYN)>;

  // fnmadd: -rs1 * rs2 - rs3
  def : Pat<(bf16 (any_fma (fneg FPR16:$rs1), FPR16:$rs2, (fneg FPR16:$rs3))),
            (FNMADD_H FPR16:$rs1, FPR16:$rs2, FPR16:$rs3, FRM_DYN)>;

  // fnmadd: -(rs1 * rs2 + rs3) (the nsz flag on the FMA)
  def : Pat<(bf16 (fneg (any_fma_nsz FPR16:$rs1, FPR16:$rs2, FPR16:$rs3))),
            (FNMADD_H FPR16:$rs1, FPR16:$rs2, FPR16:$rs3, FRM_DYN)>;
}

let Predicates = [HasVendorXxlfbf] in {
  // f32 -> f16, f16 -> f32
  def : Pat<(bf16 (any_fpround FPR32:$rs1)), (FCVT_H_S FPR32:$rs1, FRM_DYN)>;
  def : Pat<(any_fpextend (bf16 FPR16:$rs1)), (FCVT_S_H FPR16:$rs1, FRM_RNE)>;

  // Moves (no conversion)
  def : Pat<(bf16 (riscv_fmv_h_x GPR:$src)), (FMV_H_X GPR:$src)>;
  def : Pat<(riscv_fmv_x_anyexth (bf16 FPR16:$src)), (FMV_X_H FPR16:$src)>;
  def : Pat<(riscv_fmv_x_signexth (bf16 FPR16:$src)), (FMV_X_H FPR16:$src)>;

  // half->[u]int. Round-to-zero must be used.
  def : Pat<(i32 (any_fp_to_sint (bf16 FPR16:$rs1))), (FCVT_W_H $rs1, 0b001)>;
  def : Pat<(i32 (any_fp_to_uint (bf16 FPR16:$rs1))), (FCVT_WU_H $rs1, 0b001)>;

  // Saturating half->[u]int32.
  def : Pat<(i32 (riscv_fcvt_x (bf16 FPR16:$rs1), timm:$frm)), (FCVT_W_H $rs1, timm:$frm)>;
  def : Pat<(i32 (riscv_fcvt_xu (bf16 FPR16:$rs1), timm:$frm)), (FCVT_WU_H $rs1, timm:$frm)>;

  // half->int32 with current rounding mode.
  def : Pat<(i32 (any_lrint (bf16 FPR16:$rs1))), (FCVT_W_H $rs1, FRM_DYN)>;

  // half->int32 rounded to nearest with ties rounded away from zero.
  def : Pat<(i32 (any_lround (bf16 FPR16:$rs1))), (FCVT_W_H $rs1, FRM_RMM)>;

  // [u]int->half. Match GCC and default to using dynamic rounding mode.
  def : Pat<(bf16 (any_sint_to_fp (i32 GPR:$rs1))), (FCVT_H_W $rs1, FRM_DYN)>;
  def : Pat<(bf16 (any_uint_to_fp (i32 GPR:$rs1))), (FCVT_H_WU $rs1, FRM_DYN)>;
}


let Predicates = [HasVendorXxlfbf, IsRV64] in {
  // Use target specific isd nodes to help us remember the result is sign
  // extended. Matching sext_inreg+fptoui/fptosi may cause the conversion to be
  // duplicated if it has another user that didn't need the sign_extend.
  def : Pat<(riscv_any_fcvt_w_rv64 (bf16 FPR16:$rs1), timm:$frm),  (FCVT_W_H $rs1, timm:$frm)>;
  def : Pat<(riscv_any_fcvt_wu_rv64 (bf16 FPR16:$rs1), timm:$frm), (FCVT_WU_H $rs1, timm:$frm)>;

  // half->[u]int64. Round-to-zero must be used.
  def : Pat<(i64 (any_fp_to_sint (bf16 FPR16:$rs1))), (FCVT_L_H $rs1, 0b001)>;
  def : Pat<(i64 (any_fp_to_uint (bf16 FPR16:$rs1))), (FCVT_LU_H $rs1, 0b001)>;

  // Saturating half->[u]int64.
  def : Pat<(i64 (riscv_fcvt_x (bf16 FPR16:$rs1), timm:$frm)), (FCVT_L_H $rs1, timm:$frm)>;
  def : Pat<(i64 (riscv_fcvt_xu (bf16 FPR16:$rs1), timm:$frm)), (FCVT_LU_H $rs1, timm:$frm)>;

  // half->int64 with current rounding mode.
  def : Pat<(i64 (any_lrint (bf16 FPR16:$rs1))), (FCVT_L_H $rs1, FRM_DYN)>;
  def : Pat<(i64 (any_llrint (bf16 FPR16:$rs1))), (FCVT_L_H $rs1, FRM_DYN)>;

  // half->int64 rounded to nearest with ties rounded away from zero.
  def : Pat<(i64 (any_lround (bf16 FPR16:$rs1))), (FCVT_L_H $rs1, FRM_RMM)>;
  def : Pat<(i64 (any_llround (bf16 FPR16:$rs1))), (FCVT_L_H $rs1, FRM_RMM)>;

  // [u]int->fp. Match GCC and default to using dynamic rounding mode.
  def : Pat<(bf16 (any_sint_to_fp (i64 (sexti32 (i64 GPR:$rs1))))), (FCVT_H_W $rs1, FRM_DYN)>;
  def : Pat<(bf16 (any_uint_to_fp (i64 (zexti32 (i64 GPR:$rs1))))), (FCVT_H_WU $rs1, FRM_DYN)>;
  def : Pat<(bf16 (any_sint_to_fp (i64 GPR:$rs1))), (FCVT_H_L $rs1, FRM_DYN)>;
  def : Pat<(bf16 (any_uint_to_fp (i64 GPR:$rs1))), (FCVT_H_LU $rs1, FRM_DYN)>;
} // Predicates = [HasVendorXxlfbf, IsRV64]
