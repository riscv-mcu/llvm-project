//===- IntrinsicsRISCVXxldsp.td - Xxldsp intrinsics --------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines all of the Nuclei Xxldsp intrinsics for RISC-V.
//
//===----------------------------------------------------------------------===//

let TargetPrefix = "riscv" in {
  def int_riscv_xldsp_rdov_32
      : Intrinsic<[llvm_i32_ty], [],
                  [IntrNoMem, IntrHasSideEffects, IntrWillReturn]>;
  def int_riscv_xldsp_rdov_64
      : Intrinsic<[llvm_i64_ty], [],
                  [IntrNoMem, IntrHasSideEffects, IntrWillReturn]>;
  def int_riscv_xldsp_clrov
      : Intrinsic<[], [],
                  [IntrNoMem, IntrHasSideEffects, IntrWillReturn]>;

  class XxldspGprGpr<LLVMType itype>
      : Intrinsic<[itype], [itype, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspGprGprIntrinsics {
    def _32 : XxldspGprGpr<llvm_i32_ty>;
    def _64 : XxldspGprGpr<llvm_i64_ty>;
  }

//rd = xlen,rs1 = xlen,rs2 = xlen
  defm int_riscv_xldsp_add16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_radd16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_uradd16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kadd16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ukadd16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sub16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_rsub16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ursub16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ksub16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_uksub16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_cras16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_rcras16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_urcras16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kcras16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ukcras16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_crsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_rcrsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_urcrsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kcrsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ukcrsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_stas16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_rstas16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_urstas16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kstas16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ukstas16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_stsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_rstsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_urstsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kstsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ukstsa16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_add8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_radd8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_uradd8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kadd8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ukadd8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sub8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_rsub8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ursub8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ksub8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_uksub8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sra16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sra16_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_srl16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_srl16_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sll16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ksll16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kslra16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kslra16_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sra8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sra8_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_srl8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_srl8_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sll8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ksll8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kslra8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kslra8_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_cmpeq16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_scmplt16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_scmple16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ucmplt16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ucmple16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_cmpeq8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_scmplt8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_scmple8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ucmplt8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ucmple8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_khm16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_khmx16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_khm8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_khmx8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smin16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_umin16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smax16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_umax16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smin8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_umin8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smax8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_umax8 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_pkbb16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_pkbt16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_pktt16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_pktb16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smmul : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smmul_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kwmmul : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kwmmul_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smmwb : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smmwb_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smmwt : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smmwt_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kmmwb2 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kmmwb2_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kmmwt2 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kmmwt2_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smbb16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smbt16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smtt16 : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kmda : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kmxda : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smds : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smdrs : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_smxds : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_pbsad : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kaddh : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ksubh : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_khmbb : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_khmbt : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_khmtt : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ukaddh : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_uksubh : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kaddw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ukaddw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ksubw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_uksubw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kdmbb : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kdmbt : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kdmtt : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kslraw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_kslraw_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ksllw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_raddw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_uraddw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_rsubw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ursubw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_maxw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_minw : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_ave : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_sra_u : XxldspGprGprIntrinsics;
  defm int_riscv_xldsp_bitrev : XxldspGprGprIntrinsics;


//rd = i64, rs1 = i32, rs2 = i32 //[reg pair]

  class XxldspD64GprGpr<LLVMType itype, LLVMType result_ty>
      : Intrinsic<[result_ty], [itype, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspD64GprGprIntrinsics {
    def _32 : XxldspD64GprGpr<llvm_i32_ty, llvm_v2i32_ty>;
    def _64 : XxldspD64GprGpr<llvm_i64_ty, llvm_i64_ty>;
  }

  defm int_riscv_xldsp_smul16 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_smulx16 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_umul16 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_umulx16 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_smul8 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_smulx8 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_umul8 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_umulx8 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_mulr64 : XxldspD64GprGprIntrinsics;
  defm int_riscv_xldsp_mulsr64 : XxldspD64GprGprIntrinsics;

//rd = xlen,rs1 = xlen,rs2 = xlen ACC
  class XxldspGprGprGprACC<LLVMType itype>
      : Intrinsic<[itype], [itype, itype, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspGprGprGprACCIntrinsics {
    def _32 : XxldspGprGprGprACC<llvm_i32_ty>;
    def _64 : XxldspGprGprGprACC<llvm_i64_ty>;
  }

  defm int_riscv_xldsp_kmmac : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmac_u : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmsb : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmsb_u : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmawb : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmawb_u : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmawt : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmawt_u : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmawb2 : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmawb2_u : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmawt2 : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmmawt2_u : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmabb : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmabt : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmatt : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmada : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmaxda : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmads : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmadrs : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmaxds : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmsda : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kmsxda : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_pbsada : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_smaqa : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_umaqa : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_smaqa_su : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kdmabb : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kdmabt : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_kdmatt : XxldspGprGprGprACCIntrinsics;

//rd = xlen,rs1 = i32,rs2 = i32, ACC
  defm int_riscv_xldsp_maddr32 : XxldspGprGprGprACCIntrinsics;
  defm int_riscv_xldsp_msubr32 : XxldspGprGprGprACCIntrinsics;

//rd = i64,rs1 = i64,rs2 = xlen  //[reg pair]
  class XxldspD64S64Gpr<LLVMType itype, LLVMType d64_ty>
      : Intrinsic<[d64_ty], [d64_ty, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspD64S64GprIntrinsics {
    def _32 : XxldspD64S64Gpr<llvm_i32_ty, llvm_v2i32_ty>;
    def _64 : XxldspD64S64Gpr<llvm_i64_ty, llvm_i64_ty>;
  }
// SMAL
  defm int_riscv_xldsp_smal : XxldspD64S64GprIntrinsics;

//rd = i64,rs1 = i64,rs2 = i64  //[reg pair]
  class XxldspD64S64S64<LLVMType itype>
      : Intrinsic<[itype], [itype, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspD64S64S64Intrinsics {
    def _32 : XxldspD64S64S64<llvm_v2i32_ty>;
    def _64 : XxldspD64S64S64<llvm_i64_ty>;
  }

  defm int_riscv_xldsp_add64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_radd64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_uradd64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_kadd64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_ukadd64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_sub64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_rsub64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_ursub64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_ksub64 : XxldspD64S64S64Intrinsics;
  defm int_riscv_xldsp_uksub64 : XxldspD64S64S64Intrinsics;

//rd = i64,rs1 = xlen,rs2 = xlen, ACC  //[reg pair]
  class XxldspD64GPRGPRACC<LLVMType itype, LLVMType d64_ty>
      : Intrinsic<[d64_ty], [d64_ty, itype, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspD64GPRGPRACCIntrinsics {
    def _32 : XxldspD64GPRGPRACC<llvm_i32_ty, llvm_v2i32_ty>;
    def _64 : XxldspD64GPRGPRACC<llvm_i64_ty, llvm_i64_ty>;
  }

  defm int_riscv_xldsp_smar64 : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smsr64 : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_umar64 : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_umsr64 : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_kmar64 : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_kmsr64 : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_ukmar64 : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_ukmsr64 : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smalbb : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smalbt : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smaltt : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smalda : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smalxda : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smalds : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smaldrs : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smalxds : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smslda : XxldspD64GPRGPRACCIntrinsics;
  defm int_riscv_xldsp_smslxda : XxldspD64GPRGPRACCIntrinsics;

//rd = xlen,rs1 = i64,rs2 = i32,  //[reg pair]
  class XxldspGPRS64GPR<LLVMType itype, LLVMType d64_ty>
      : Intrinsic<[itype], [d64_ty, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspGPRS64GPRIntrinsics {
    def _32 : XxldspGPRS64GPR<llvm_i32_ty, llvm_v2i32_ty>;
    def _64 : XxldspGPRS64GPR<llvm_i64_ty, llvm_i64_ty>;
  }
  defm int_riscv_xldsp_wext : XxldspGPRS64GPRIntrinsics;

//rd = xlen,rs1 = i64,shift = i32, //[reg pair]
  class XxldspGPRS64Shift<LLVMType itype, LLVMType d64_ty>
      : Intrinsic<[itype], [d64_ty, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable, ImmArg<ArgIndex<1>>]>;

  multiclass XxldspGPRS64ShiftIntrinsics {
    def _32 : XxldspGPRS64Shift<llvm_i32_ty, llvm_v2i32_ty>;
    def _64 : XxldspGPRS64Shift<llvm_i64_ty, llvm_i64_ty>;
  }
  defm int_riscv_xldsp_wexti : XxldspGPRS64ShiftIntrinsics;

//rd = xlen,rs1 = xlen
  class XxldspGpr<LLVMType itype>
      : Intrinsic<[itype], [itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspGprIntrinsics {
    def _32 : XxldspGpr<llvm_i32_ty>;
    def _64 : XxldspGpr<llvm_i64_ty>;
  }

  defm int_riscv_xldsp_kabs16 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clrs16 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clz16 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clo16 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_kabs8 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clrs8 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clz8 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clo8 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_swap8 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_swap16 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_sunpkd810 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_sunpkd820 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_sunpkd830 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_sunpkd831 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_sunpkd832 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_zunpkd810 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_zunpkd820 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_zunpkd830 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_zunpkd831 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_zunpkd832 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clrs32 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clz32 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_clo32 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_kabsw : XxldspGprIntrinsics;
  defm int_riscv_xldsp_expd80 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_expd81 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_expd82 : XxldspGprIntrinsics;
  defm int_riscv_xldsp_expd83 : XxldspGprIntrinsics;

//rd = xlen,rs1 = xlen, shift = i32
  class XxldspGprShift<LLVMType itype>
      : Intrinsic<[itype], [itype, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable, ImmArg<ArgIndex<1>>]>;

  multiclass XxldspGprShiftIntrinsics {
    def _32 : XxldspGprShift<llvm_i32_ty>;
    def _64 : XxldspGprShift<llvm_i64_ty>;
  }
  defm int_riscv_xldsp_srai8 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_srai8_u : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_srli8 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_srli8_u : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_slli8 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_kslli8 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_sclip8 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_uclip8 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_srai16 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_srai16_u : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_srli16 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_srli16_u : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_slli16 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_kslli16 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_sclip16 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_uclip16 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_sclip32 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_uclip32 : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_kslliw : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_srai_u : XxldspGprShiftIntrinsics;
  defm int_riscv_xldsp_bitrevi : XxldspGprShiftIntrinsics;

//rd = xlen,rs1 = xlen,rs2 = xlen,rs3 = xlen
  class XxldspGprGprGpr<LLVMType itype>
      : Intrinsic<[itype], [itype, itype, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  multiclass XxldspGprGprGprIntrinsics {
    def _32 : XxldspGprGprGpr<llvm_i32_ty>;
    def _64 : XxldspGprGprGpr<llvm_i64_ty>;
  }

  defm int_riscv_xldsp_bpick : XxldspGprGprGprIntrinsics;

//rd = xlen,rs1 = xlen,rs2 = imm, ACC
  class XxldspGprShiftACC<LLVMType itype>
      : Intrinsic<[itype], [itype, itype, itype],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable, ImmArg<ArgIndex<2>>]>;

  multiclass XxldspGprShiftACCIntrinsics {
    def _32 : XxldspGprShiftACC<llvm_i32_ty>;
    def _64 : XxldspGprShiftACC<llvm_i64_ty>;
  }

  defm int_riscv_xldsp_insb : XxldspGprShiftACCIntrinsics;


//rd = i64,rs1 = i64,rs2 = i64  RV64 ONLY
  class XxldspGpr64Gpr64Gpr64Intrinsic
      : Intrinsic<[llvm_i64_ty], [llvm_i64_ty, llvm_i64_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  def int_riscv_xldsp_add32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_radd32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_uradd32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kadd32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_ukadd32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_sub32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_rsub32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_ursub32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_ksub32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_uksub32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_cras32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_rcras32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_urcras32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kcras32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_ukcras32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_crsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_rcrsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_urcrsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kcrsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_ukcrsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_stas32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_rstas32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_urstas32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kstas32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_ukstas32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_stsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_rstsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_urstsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kstsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_ukstsa32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_sra32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_sra32_u : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_srl32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_srl32_u : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_sll32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_ksll32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kslra32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kslra32_u : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_smin32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_umin32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_smax32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_umax32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_khmbb16 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_khmbt16 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_khmtt16 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kdmbb16 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kdmbt16 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kdmtt16 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_smbt32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_smtt32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kmda32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_kmxda32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_smds32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_smdrs32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_smxds32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_pkbb32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_pkbt32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_pktt32 : XxldspGpr64Gpr64Gpr64Intrinsic;
  def int_riscv_xldsp_pktb32 : XxldspGpr64Gpr64Gpr64Intrinsic;



//rd = i64,rs1 = i64,rs2 = i64,ACC RV64 ONLY
  class XxldspGpr64Gpr64Gpr64ACCIntrinsic
      : Intrinsic<[llvm_i64_ty], [llvm_i64_ty, llvm_i64_ty, llvm_i64_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  def int_riscv_xldsp_kdmabb16 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kdmabt16 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kdmatt16 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmabb32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmabt32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmatt32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmaxda32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmads32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmadrs32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmaxds32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmsda32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;
  def int_riscv_xldsp_kmsxda32 : XxldspGpr64Gpr64Gpr64ACCIntrinsic;

//rd = i64,rs1 = i64  RV64 ONLY
  class XxldspGpr64Gpr64Intrinsic
      : Intrinsic<[llvm_i64_ty], [llvm_i64_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

  def int_riscv_xldsp_kabs32 : XxldspGpr64Gpr64Intrinsic;
  def int_riscv_xldsp_expd84 : XxldspGpr64Gpr64Intrinsic;
  def int_riscv_xldsp_expd85 : XxldspGpr64Gpr64Intrinsic;
  def int_riscv_xldsp_expd86 : XxldspGpr64Gpr64Intrinsic;
  def int_riscv_xldsp_expd87 : XxldspGpr64Gpr64Intrinsic;

//rd = i64,rs1 = i64,shift = i32 RV64 ONLY
  class XxldspGpr64Gpr64ShiftIntrinsic
      : Intrinsic<[llvm_i64_ty], [llvm_i64_ty, llvm_i64_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable, ImmArg<ArgIndex<1>>]>;
  def int_riscv_xldsp_srai32 : XxldspGpr64Gpr64ShiftIntrinsic;
  def int_riscv_xldsp_srai32_u : XxldspGpr64Gpr64ShiftIntrinsic;
  def int_riscv_xldsp_srli32 : XxldspGpr64Gpr64ShiftIntrinsic;
  def int_riscv_xldsp_srli32_u : XxldspGpr64Gpr64ShiftIntrinsic;
  def int_riscv_xldsp_slli32 : XxldspGpr64Gpr64ShiftIntrinsic;
  def int_riscv_xldsp_kslli32 : XxldspGpr64Gpr64ShiftIntrinsic;
  def int_riscv_xldsp_sraiw_u : XxldspGpr64Gpr64ShiftIntrinsic;

  class XxldspD64S64S64Intrinsic
      : Intrinsic<[llvm_v2i32_ty], [llvm_v2i32_ty, llvm_v2i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;

// R[pair] type
  // N1
  def int_riscv_xldsp_dkhm8 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkhm16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkadd8 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkadd16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dksub8 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dksub16 : XxldspD64S64S64Intrinsic;

  // N2
  def int_riscv_xldsp_dkhmx8 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkhmx16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmmul : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmmul_u : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkwmmul : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkwmmul_u : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkadd32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dksub32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dradd16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsub16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dradd32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsub32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkmda : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkmxda : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmdrs : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmxds : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmbb32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmbb32_sra14 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmbb32_sra32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmbt32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmbt32_sra14 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmbt32_sra32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmtt32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmtt32_sra14 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmtt32_sra32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dpkbb32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dpkbt32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dpktt32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dpktb32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dpktb16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dpkbb16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dpkbt16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dpktt16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsra16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dadd16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dadd32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmbb16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmbt16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmtt16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_drcrsa16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_drcras16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkcrsa16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkcras16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_drsub16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_drsub32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dstsa32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dstas32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkcras32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkcrsa32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dcrsa32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dcras32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkstsa16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkstas16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_drcrsa32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_drcras32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dmsr16 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dmsr17 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dmsr33 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dmxsr33 : XxldspD64S64S64Intrinsic;

  // N3
  def int_riscv_xldsp_dkmda32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dkmxda32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmds32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmdrs32 : XxldspD64S64S64Intrinsic;
  def int_riscv_xldsp_dsmxds32 : XxldspD64S64S64Intrinsic;

  class XxldspD64S64Intrinsic
      : Intrinsic<[llvm_v2i32_ty], [llvm_v2i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;
// R2[pair] type
  // N1
  def int_riscv_xldsp_dkabs8 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dkabs16 : XxldspD64S64Intrinsic;

  // N2
  def int_riscv_xldsp_dkabs32 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dsunpkd810 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dsunpkd820 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dsunpkd830 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dsunpkd831 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dsunpkd832 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dzunpkd810 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dzunpkd820 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dzunpkd830 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dzunpkd831 : XxldspD64S64Intrinsic;
  def int_riscv_xldsp_dzunpkd832 : XxldspD64S64Intrinsic;

// D64_S64_S32
  class XxldspD64S64S32Intrinsic
      : Intrinsic<[llvm_v2i32_ty], [llvm_v2i32_ty, llvm_i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;
  // N1
  def int_riscv_xldsp_dkslra8 : XxldspD64S64S32Intrinsic;
  def int_riscv_xldsp_dkslra16 : XxldspD64S64S32Intrinsic;
  // N2
  def int_riscv_xldsp_dkslra32 : XxldspD64S64S32Intrinsic;


// D32_S64
  class XxldspD32S64Intrinsic
      : Intrinsic<[llvm_i32_ty], [llvm_v2i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;
  // N2
  def int_riscv_xldsp_dkclip64 : XxldspD32S64Intrinsic;
  def int_riscv_xldsp_dredas16 : XxldspD32S64Intrinsic;
  def int_riscv_xldsp_dredsa16 : XxldspD32S64Intrinsic;

// shifti
  class XxldspD64S64ShiftIntrinsic
      : Intrinsic<[llvm_v2i32_ty], [llvm_v2i32_ty, llvm_i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable, ImmArg<ArgIndex<1>>]>;
  // N2 
  def int_riscv_xldsp_dsclip8 : XxldspD64S64ShiftIntrinsic;
  def int_riscv_xldsp_dsclip16 : XxldspD64S64ShiftIntrinsic;
  def int_riscv_xldsp_dsclip32 : XxldspD64S64ShiftIntrinsic;

// D64_S32_S32
  class XxldspD64S32S32Intrinsic
      : Intrinsic<[llvm_v2i32_ty], [llvm_i32_ty, llvm_i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;
  // N2
  def int_riscv_xldsp_dpack32 : XxldspD64S32S32Intrinsic;


// R_ACC[Reg pair]
  class XxldspD64S64S64ACCIntrinsic
      : Intrinsic<[llvm_v2i32_ty],
                  [llvm_v2i32_ty, llvm_v2i32_ty, llvm_v2i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;
  // N3
  def int_riscv_xldsp_dkmmac: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmmac_u: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmmsb: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmmsb_u: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmada: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmaxda: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmads: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmadrs: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmaxds: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmsda: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmsxda: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmaqa: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmaqa_su: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dumaqa: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmada32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmaxda32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmads32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmadrs32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmaxds32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmsda32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmsxda32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmalda: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmalxda: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmalds: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmaldrs: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmalxds: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmslda: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmslxda: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_ddsmaqa: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_ddsmaqa_su: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_ddumaqa: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dksms32_u: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmalbb: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmalbt: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmaltt: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmabb32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmabt32: XxldspD64S64S64ACCIntrinsic;
  def int_riscv_xldsp_dkmatt32: XxldspD64S64S64ACCIntrinsic;


// R_ACC_D32_S64_S64
  class XxldspD32S64S64ACCIntrinsic
      : Intrinsic<[llvm_i32_ty],
                  [llvm_i32_ty, llvm_v2i32_ty, llvm_v2i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;
  // N3
  def int_riscv_xldsp_dsmada16: XxldspD32S64S64ACCIntrinsic;
  def int_riscv_xldsp_dsmaxda16: XxldspD32S64S64ACCIntrinsic;
  def int_riscv_xldsp_dmada32: XxldspD32S64S64ACCIntrinsic;

// R_D32_S64_S64
  class XxldspD32S64S64Intrinsic
      : Intrinsic<[llvm_i32_ty], [llvm_v2i32_ty, llvm_v2i32_ty],
                  [IntrNoMem, IntrWillReturn, IntrSpeculatable]>;
  // N3
  def int_riscv_xldsp_dsma32_u : XxldspD32S64S64Intrinsic;
  def int_riscv_xldsp_dsmxs32_u : XxldspD32S64S64Intrinsic;
  def int_riscv_xldsp_dsmxa32_u : XxldspD32S64S64Intrinsic;
  def int_riscv_xldsp_dsms32_u : XxldspD32S64S64Intrinsic;
}
