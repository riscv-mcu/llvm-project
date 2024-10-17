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
    : RVInst<(outs VR:$vd), (ins VR:$vs2, VR:$vs1, VMaskOp:$vm),
              opcodestr, "$vd, $vs2, $vs1$vm", [], InstFormatR> {
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
  let RVVConstraint = VMConstraint;
}
}

let Predicates = [HasVendorXxlvqmacc], DecoderNamespace = "Xxlvqmacc" in {
  def VQMACCU  : XxlvqmaccInstr<0b101110, 0b001, "xl.vqmaccu.vv">;
  def VQMACC   : XxlvqmaccInstr<0b101111, 0b001, "xl.vqmacc.vv">;
  def VQMACCUS : XxlvqmaccInstr<0b111101, 0b001, "xl.vqmaccus.vv">;
  def VQMACCSU : XxlvqmaccInstr<0b111110, 0b001, "xl.vqmaccsu.vv">;
}

