//===-- RISCVInstrInfoXxlvqmacc.td - Nuclei custom instructions --*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the Nuclei custom vpu instructions.
//
//===----------------------------------------------------------------------===//

let hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
class XxlvqmaccInstr<bits<6> funct6, bits<3> funct3, string opcodestr>
    : RVInst<(outs VR:$vd), (ins VR:$vs1, VR:$vs2, VMaskOp:$vm),
              opcodestr, "$vd, $vs1, $vs2$vm", [], InstFormatR> {
  bits<5> vs2;
  bits<5> vs1;
  bits<5> vd;
  bit vm;

  let Inst{31-26} = funct6;
  let Inst{25} = vm;
  let Inst{24-20} = vs2;
  let Inst{19-15} = vs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = vd;
  let Inst{6-0} = OPC_CUSTOM_3.Value;

  let Uses = [VTYPE, VL];
  let RVVConstraint = NoConstraint;
}
}

let Predicates = [HasVendorXxlvqmacc], DecoderNamespace = "Xxlvqmacc" in {
let vm = 1 in {
  def XL_VQMACCU_4x4x4  : XxlvqmaccInstr<0b101110, 0b001, "xl.vqmaccu.vv">;
  def XL_VQMACC_4x4x4   : XxlvqmaccInstr<0b101111, 0b001, "xl.vqmacc.vv">;
  def XL_VQMACCUS_4x4x4 : XxlvqmaccInstr<0b111101, 0b001, "xl.vqmaccus.vv">;
  def XL_VQMACCSU_4x4x4 : XxlvqmaccInstr<0b111110, 0b001, "xl.vqmaccsu.vv">;
}
}

multiclass VPseudoXlVMACC<string mx, VReg vd_type, VReg vs2_type,
                              string Constraint = ""> {
  def "Pseudo" # NAME # "_" # mx
      : VPseudoTernaryNoMaskWithPolicy<vd_type, V_M1.vrclass, vs2_type, Constraint>;
}

multiclass VPseudoXlVQMACC<string Constraint = ""> {
  foreach i = 1-4 in
    let VLMul = MxListW[i].value in
    defm NAME : VPseudoXlVMACC<MxListW[i].MX,  MxListVF4[i].vrclass, MxListW[i].vrclass, Constraint>;
}

let Predicates = [HasVendorXxlvqmacc], DecoderNamespace = "Xxlvqmacc" in {
  defm XL_VQMACCU_4x4x4  : VPseudoXlVQMACC;
  defm XL_VQMACC_4x4x4   : VPseudoXlVQMACC;
  defm XL_VQMACCUS_4x4x4 : VPseudoXlVQMACC;
  defm XL_VQMACCSU_4x4x4 : VPseudoXlVQMACC;
}

multiclass VPatXlVMACC<string intrinsic, string instruction, string kind,
                     list<VTypeInfoToWide> info_pairs, ValueType vec_m1> {
  foreach pair = info_pairs in {
    defvar VdInfo = pair.Wti;
    defvar Vs2Info = pair.Vti;
    let Predicates = [HasVInstructions] in
    def : VPatTernaryNoMaskWithPolicy<"int_riscv_xl_" # intrinsic,
                                      "Pseudo" # instruction, kind, VdInfo.Vector,
                                      vec_m1, Vs2Info.Vector,
                                      Vs2Info.Log2SEW, Vs2Info.LMul,
                                      VdInfo.RegClass, VR, Vs2Info.RegClass>;
  }
}

defset list<VTypeInfoToWide> VQMACCInfoPairs = {
  def : VTypeInfoToWide<VI8MF4, VI32M1>;
  def : VTypeInfoToWide<VI8MF2, VI32M2>;
  def : VTypeInfoToWide<VI8M1, VI32M4>;
  def : VTypeInfoToWide<VI8M2, VI32M8>;
}

multiclass VPatXlVQMACC<string intrinsic, string instruction, string kind>
    : VPatXlVMACC<intrinsic, instruction, kind, VQMACCInfoPairs, vint8m1_t>;


let Predicates = [HasVendorXxlvqmacc] in {
  defm : VPatXlVQMACC<"vqmaccu_4x4x4", "XL_VQMACCU", "4x4x4">;
  defm : VPatXlVQMACC<"vqmacc_4x4x4", "XL_VQMACC", "4x4x4">;
  defm : VPatXlVQMACC<"vqmaccus_4x4x4", "XL_VQMACCUS", "4x4x4">;
  defm : VPatXlVQMACC<"vqmaccsu_4x4x4", "XL_VQMACCSU", "4x4x4">;
}

