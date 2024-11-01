//===- IntrinsicsRISCVXsf.td - SiFive intrinsics -----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines all of the SiFive vendor intrinsics for RISC-V.
//
//===----------------------------------------------------------------------===//

let TargetPrefix = "riscv" in {
  class RISCVXLCustomVQMACC
      : DefaultAttrsIntrinsic< [llvm_anyvector_ty],
                   [LLVMMatchType<0>, llvm_anyvector_ty, llvm_anyvector_ty,
                    llvm_anyint_ty, LLVMMatchType<3>],
                   [ImmArg<ArgIndex<4>>, IntrNoMem] >, RISCVVIntrinsic {
    let VLOperand = 3;
  }

  def int_riscv_xl_vqmaccu_4x4x4  : RISCVXLCustomVQMACC;
  def int_riscv_xl_vqmacc_4x4x4   : RISCVXLCustomVQMACC;
  def int_riscv_xl_vqmaccus_4x4x4 : RISCVXLCustomVQMACC;
  def int_riscv_xl_vqmaccsu_4x4x4 : RISCVXLCustomVQMACC;
} // TargetPrefix = "riscv"
