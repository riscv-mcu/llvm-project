//===-- RISCVInstrInfoXxldsp.td ----------------------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the P-spec-0.54 and Nuclei Xxldsp N1/N2/N3 extensions.
//
//===----------------------------------------------------------------------===//

def xl_uimm3: TImmLeaf<XLenVT, [{return isUInt<3>(Imm);}]>;
def xl_uimm4: TImmLeaf<XLenVT, [{return isUInt<4>(Imm);}]>;
def xl_uimm5: TImmLeaf<XLenVT, [{return isUInt<5>(Imm);}]>;
def xl_uimm6: TImmLeaf<XLenVT, [{return isUInt<6>(Imm);}]>;

class XxldspRR<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_DSP, (outs GPR:$rd),
              (ins GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

let Constraints = "$rd = $rd_wb" in {
class XxldspRRACC<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_DSP, (outs GPR:$rd_wb),
              (ins GPR:$rd, GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;
}

class XxldspR<bits<7> funct7, bits<5> funct5, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_DSP, (outs GPR:$rd), (ins GPR:$rs1),
              opcodestr, "$rd, $rs1"> {
  let rs2 = funct5;
}

class XxldspR_cust3<bits<7> funct7, bits<5> funct5, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd), (ins GPR:$rs1),
              opcodestr, "$rd, $rs1"> {
  let rs2 = funct5;
}

class XxldspR4<bits<2> funct2, bits<3> funct3, string opcodestr>
    : RVInstR4<funct2, funct3, OPC_DSP, (outs GPR:$rd),
              (ins GPR:$rs1, GPR:$rs2, GPR:$rs3),
               opcodestr, "$rd, $rs1, $rs2, $rs3">;

class XxldspR_i3<bits<7> funct7, bits<2> funct2, bits<3> funct3, string opcodestr>
    : RVInstIBase<funct3, OPC_DSP, (outs GPR:$rd), (ins GPR:$rs1, uimm3:$imm),
                  opcodestr, "$rd, $rs1, $imm"> {
  bits<3> imm;

  let Inst{31-25} = funct7;
  let Inst{24-23} = funct2;
  let Inst{22-20} = imm;
}

let Constraints = "$rd = $rd_wb" in {
class XxldspR_i3_ACC<bits<7> funct7, bits<2> funct2, bits<3> funct3, string opcodestr>
    : RVInstIBase<funct3, OPC_DSP, (outs GPR:$rd_wb), (ins GPR:$rd, GPR:$rs1, uimm3:$imm),
                  opcodestr, "$rd, $rs1, $imm"> {
  bits<3> imm;

  let Inst{31-25} = funct7;
  let Inst{24-23} = funct2;
  let Inst{22-20} = imm;
}
}

class XxldspR_i4<bits<7> funct7, bit F, bits<3> funct3, string opcodestr>
    : RVInstIBase<funct3, OPC_DSP, (outs GPR:$rd), (ins GPR:$rs1, uimm4:$imm),
                  opcodestr, "$rd, $rs1, $imm"> {
  bits<4> imm;

  let Inst{31-25} = funct7;
  let Inst{24} = F;
  let Inst{23-20} = imm;
}

class XxldspR_i5<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstIBase<funct3, OPC_DSP, (outs GPR:$rd), (ins GPR:$rs1, uimm5:$imm),
                  opcodestr, "$rd, $rs1, $imm"> {
  bits<5> imm;

  let Inst{31-25} = funct7;
  let Inst{24-20} = imm;
}

class XxldspR_i6<bits<6> funct6, bits<3> funct3, string opcodestr>
    : RVInstIBase<funct3, OPC_DSP, (outs GPR:$rd), (ins GPR:$rs1, uimm6:$imm),
                  opcodestr, "$rd, $rs1, $imm"> {
  bits<6> imm;

  let Inst{31-26} = funct6;
  let Inst{25-20} = imm;
}

class XxldspRPRP<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_DSP, (outs GPR32PairOp:$rd),
              (ins GPR32PairOp:$rs1, GPR32PairOp:$rs2), opcodestr, "$rd, $rs1, $rs2">;

class XxldspRPRP_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR32PairOp:$rd),
              (ins GPR32PairOp:$rs1, GPR32PairOp:$rs2), opcodestr, "$rd, $rs1, $rs2">;

class XxldspRPRP_D32_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd),
              (ins GPR32PairOp:$rs1, GPR32PairOp:$rs2), opcodestr, "$rd, $rs1, $rs2">;

class XxldspRPR<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_DSP, (outs GPR32PairOp:$rd),
              (ins GPR32PairOp:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

class XxldspRPR_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR32PairOp:$rd),
              (ins GPR32PairOp:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

class XxldspRR_D64_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR32PairOp:$rd),
              (ins GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

class XxldspRP<bits<7> funct7, bits<5> funct5, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_DSP, (outs GPR32PairOp:$rd), (ins GPR32PairOp:$rs1),
              opcodestr, "$rd, $rs1"> {
  let rs2 = funct5;
}

class XxldspRP_cust3<bits<7> funct7, bits<5> funct5, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR32PairOp:$rd), (ins GPR32PairOp:$rs1),
              opcodestr, "$rd, $rs1"> {
  let rs2 = funct5;
}

class XxldspRP_D32_cust3<bits<7> funct7, bits<5> funct5, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd), (ins GPR32PairOp:$rs1),
              opcodestr, "$rd, $rs1"> {
  let rs2 = funct5;
}

class XxldspRP_i5_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstIBase<funct3, OPC_CUSTOM_3, (outs GPR32PairOp:$rd), (ins GPR32PairOp:$rs1, uimm5:$imm),
                  opcodestr, "$rd, $rs1, $imm"> {
  bits<5> imm;

  let Inst{31-25} = funct7;
  let Inst{24-20} = imm;
}

let Constraints = "$rd = $rd_wb" in {
class XxldspRPRP_ACC_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR32PairOp:$rd_wb),
              (ins GPR32PairOp:$rd, GPR32PairOp:$rs1, GPR32PairOp:$rs2), opcodestr, "$rd, $rs1, $rs2">;
}

let Constraints = "$rd = $rd_wb" in {
class XxldspRPRP_D32_ACC_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd_wb),
              (ins GPR:$rd, GPR32PairOp:$rs1, GPR32PairOp:$rs2), opcodestr, "$rd, $rs1, $rs2">;
}

class XxldspD64_S32_S32<bits<7> funct7, bits<3> funct3, string opcodestr,
                        DAGOperand RC>
    : RVInstR<funct7, funct3, OPC_DSP, (outs RC:$rd),
              (ins GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

multiclass XxldspD64_S32_S32_Asm<bits<7> funct7, bits<3> funct3, string opcodestr> {
  let Predicates = [IsRV32] in {
  def _32 : XxldspD64_S32_S32<funct7, funct3, opcodestr, GPR32PairOp>;
  }
  let Predicates = [IsRV64] in {
  def _64 : XxldspD64_S32_S32<funct7, funct3, opcodestr, GPR>;
  }
}

class XxldspD64_S64_S32<bits<7> funct7, bits<3> funct3, string opcodestr,
                        DAGOperand RC>
    : RVInstR<funct7, funct3, OPC_DSP, (outs RC:$rd),
              (ins RC:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

multiclass XxldspD64_S64_S32_Asm<bits<7> funct7, bits<3> funct3, string opcodestr> {
  let Predicates = [IsRV32] in {
  def _32 : XxldspD64_S64_S32<funct7, funct3, opcodestr, GPR32PairOp>;
  }
  let Predicates = [IsRV64] in {
  def _64 : XxldspD64_S64_S32<funct7, funct3, opcodestr, GPR>;
  }
}

class XxldspD64_S64_S64<bits<7> funct7, bits<3> funct3, string opcodestr,
                        DAGOperand RC>
    : RVInstR<funct7, funct3, OPC_DSP, (outs RC:$rd),
              (ins RC:$rs1, RC:$rs2), opcodestr, "$rd, $rs1, $rs2">;

multiclass XxldspD64_S64_S64_Asm<bits<7> funct7, bits<3> funct3, string opcodestr> {
  let Predicates = [IsRV32] in {
  def _32 : XxldspD64_S64_S64<funct7, funct3, opcodestr, GPR32PairOp>;
  }
  let Predicates = [IsRV64] in {
  def _64 : XxldspD64_S64_S64<funct7, funct3, opcodestr, GPR>;
  }
}

let Constraints = "$rd = $rd_wb" in {
class XxldspD64_GPR_GPR_ACC<bits<7> funct7, bits<3> funct3, string opcodestr,
                        DAGOperand RC>
    : RVInstR<funct7, funct3, OPC_DSP, (outs RC:$rd_wb),
              (ins RC:$rd, GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;
}

multiclass XxldspD64_GPR_GPR_ACC_Asm<bits<7> funct7, bits<3> funct3, string opcodestr> {
  let Predicates = [IsRV32] in {
  def _32 : XxldspD64_GPR_GPR_ACC<funct7, funct3, opcodestr, GPR32PairOp>;
  }
  let Predicates = [IsRV64] in {
  def _64 : XxldspD64_GPR_GPR_ACC<funct7, funct3, opcodestr, GPR>;
  }
}

class XxldspGPR_S64_GPR<bits<7> funct7, bits<3> funct3, string opcodestr,
                        DAGOperand RC>
    : RVInstR<funct7, funct3, OPC_DSP, (outs GPR:$rd),
              (ins RC:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

multiclass XxldspGPR_S64_GPR_Asm<bits<7> funct7, bits<3> funct3, string opcodestr> {
  let Predicates = [IsRV32] in {
  def _32 : XxldspGPR_S64_GPR<funct7, funct3, opcodestr, GPR32PairOp>;
  }
  let Predicates = [IsRV64] in {
  def _64 : XxldspGPR_S64_GPR<funct7, funct3, opcodestr, GPR>;
  }
}

class XxldspGPR_S64_Shift<bits<7> funct7, bits<3> funct3, string opcodestr,
                          DAGOperand RC>
    : RVInstIBase<funct3, OPC_DSP, (outs GPR:$rd), (ins RC:$rs1, uimm5:$imm),
                  opcodestr, "$rd, $rs1, $imm"> {
  bits<5> imm;

  let Inst{31-25} = funct7;
  let Inst{24-20} = imm;
}

multiclass XxldspGPR_S64_Shift_Asm<bits<7> funct7, bits<3> funct3, string opcodestr> {
  let Predicates = [IsRV32] in {
  def _32 : XxldspGPR_S64_Shift<funct7, funct3, opcodestr, GPR32PairOp>;
  }
  let Predicates = [IsRV64] in {
  def _64 : XxldspGPR_S64_Shift<funct7, funct3, opcodestr, GPR>;
  }
}



let Predicates = [HasVendorXxldsp], DecoderNamespace = "Xxldsp",
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def ADD16     : XxldspRR<0b0100000, 0b000, "add16">;
  def RADD16    : XxldspRR<0b0000000, 0b000, "radd16">;
  def URADD16   : XxldspRR<0b0010000, 0b000, "uradd16">;
  def KADD16    : XxldspRR<0b0001000, 0b000, "kadd16">;
  def UKADD16   : XxldspRR<0b0011000, 0b000, "ukadd16">;
  def SUB16     : XxldspRR<0b0100001, 0b000, "sub16">;
  def RSUB16    : XxldspRR<0b0000001, 0b000, "rsub16">;
  def URSUB16   : XxldspRR<0b0010001, 0b000, "ursub16">;
  def KSUB16    : XxldspRR<0b0001001, 0b000, "ksub16">;
  def UKSUB16   : XxldspRR<0b0011001, 0b000, "uksub16">;
  def CRAS16    : XxldspRR<0b0100010, 0b000, "cras16">;
  def RCRAS16   : XxldspRR<0b0000010, 0b000, "rcras16">;
  def URCRAS16  : XxldspRR<0b0010010, 0b000, "urcras16">;
  def KCRAS16   : XxldspRR<0b0001010, 0b000, "kcras16">;
  def UKCRAS16  : XxldspRR<0b0011010, 0b000, "ukcras16">;
  def CRSA16    : XxldspRR<0b0100011, 0b000, "crsa16">;
  def RCRSA16   : XxldspRR<0b0000011, 0b000, "rcrsa16">;
  def URCRSA16  : XxldspRR<0b0010011, 0b000, "urcrsa16">;
  def KCRSA16   : XxldspRR<0b0001011, 0b000, "kcrsa16">;
  def UKCRSA16  : XxldspRR<0b0011011, 0b000, "ukcrsa16">;
  def STAS16    : XxldspRR<0b1111010, 0b010, "stas16">;
  def RSTAS16   : XxldspRR<0b1011010, 0b010, "rstas16">;
  def URSTAS16  : XxldspRR<0b1101010, 0b010, "urstas16">;
  def KSTAS16   : XxldspRR<0b1100010, 0b010, "kstas16">;
  def UKSTAS16  : XxldspRR<0b1110010, 0b010, "ukstas16">;
  def STSA16    : XxldspRR<0b1111011, 0b010, "stsa16">;
  def RSTSA16   : XxldspRR<0b1011011, 0b010, "rstsa16">;
  def URSTSA16  : XxldspRR<0b1101011, 0b010, "urstsa16">;
  def KSTSA16   : XxldspRR<0b1100011, 0b010, "kstsa16">;
  def UKSTSA16  : XxldspRR<0b1110011, 0b010, "ukstsa16">;
  def ADD8      : XxldspRR<0b0100100, 0b000, "add8">;
  def RADD8     : XxldspRR<0b0000100, 0b000, "radd8">;
  def URADD8    : XxldspRR<0b0010100, 0b000, "uradd8">;
  def KADD8     : XxldspRR<0b0001100, 0b000, "kadd8">;
  def UKADD8    : XxldspRR<0b0011100, 0b000, "ukadd8">;
  def SUB8      : XxldspRR<0b0100101, 0b000, "sub8">;
  def RSUB8     : XxldspRR<0b0000101, 0b000, "rsub8">;
  def URSUB8    : XxldspRR<0b0010101, 0b000, "ursub8">;
  def KSUB8     : XxldspRR<0b0001101, 0b000, "ksub8">;
  def UKSUB8    : XxldspRR<0b0011101, 0b000, "uksub8">;
  def SRA16     : XxldspRR<0b0101000, 0b000, "sra16">;
  def SRA16_U   : XxldspRR<0b0110000, 0b000, "sra16.u">;
  def SRL16     : XxldspRR<0b0101001, 0b000, "srl16">;
  def SRL16_U   : XxldspRR<0b0110001, 0b000, "srl16.u">;
  def SLL16     : XxldspRR<0b0101010, 0b000, "sll16">;
  def KSLL16    : XxldspRR<0b0110010, 0b000, "ksll16">;
  def KSLRA16   : XxldspRR<0b0101011, 0b000, "kslra16">;
  def KSLRA16_U : XxldspRR<0b0110011, 0b000, "kslra16.u">;
  def SRA8      : XxldspRR<0b0101100, 0b000, "sra8">;
  def SRA8_U    : XxldspRR<0b0110100, 0b000, "sra8.u">;
  def SRL8      : XxldspRR<0b0101101, 0b000, "srl8">;
  def SRL8_U    : XxldspRR<0b0110101, 0b000, "srl8.u">;
  def SLL8      : XxldspRR<0b0101110, 0b000, "sll8">;
  def KSLL8     : XxldspRR<0b0110110, 0b000, "ksll8">;
  def KSLRA8    : XxldspRR<0b0101111, 0b000, "kslra8">;
  def KSLRA8_U  : XxldspRR<0b0110111, 0b000, "kslra8.u">;
  def CMPEQ16   : XxldspRR<0b0100110, 0b000, "cmpeq16">;
  def SCMPLT16  : XxldspRR<0b0000110, 0b000, "scmplt16">;
  def SCMPLE16  : XxldspRR<0b0001110, 0b000, "scmple16">;
  def UCMPLT16  : XxldspRR<0b0010110, 0b000, "ucmplt16">;
  def UCMPLE16  : XxldspRR<0b0011110, 0b000, "ucmple16">;
  def CMPEQ8    : XxldspRR<0b0100111, 0b000, "cmpeq8">;
  def SCMPLT8   : XxldspRR<0b0000111, 0b000, "scmplt8">;
  def SCMPLE8   : XxldspRR<0b0001111, 0b000, "scmple8">;
  def UCMPLT8   : XxldspRR<0b0010111, 0b000, "ucmplt8">;
  def UCMPLE8   : XxldspRR<0b0011111, 0b000, "ucmple8">;
  defm SMUL16   : XxldspD64_S32_S32_Asm<0b1010000, 0b000, "smul16">;
  defm SMULX16  : XxldspD64_S32_S32_Asm<0b1010001, 0b000, "smulx16">;
  defm UMUL16   : XxldspD64_S32_S32_Asm<0b1011000, 0b000, "umul16">;
  defm UMULX16  : XxldspD64_S32_S32_Asm<0b1011001, 0b000, "umulx16">;
  def KHM16     : XxldspRR<0b1000011, 0b000, "khm16">;
  def KHMX16    : XxldspRR<0b1001011, 0b000, "khmx16">;
  defm SMUL8    : XxldspD64_S32_S32_Asm<0b1010100, 0b000, "smul8">;
  defm SMULX8   : XxldspD64_S32_S32_Asm<0b1010101, 0b000, "smulx8">;
  defm UMUL8    : XxldspD64_S32_S32_Asm<0b1011100, 0b000, "umul8">;
  defm UMULX8   : XxldspD64_S32_S32_Asm<0b1011101, 0b000, "umulx8">;
  def KHM8      : XxldspRR<0b1000111, 0b000, "khm8">;
  def KHMX8     : XxldspRR<0b1001111, 0b000, "khmx8">;
  def SMIN16    : XxldspRR<0b1000000, 0b000, "smin16">;
  def UMIN16    : XxldspRR<0b1001000, 0b000, "umin16">;
  def SMAX16    : XxldspRR<0b1000001, 0b000, "smax16">;
  def UMAX16    : XxldspRR<0b1001001, 0b000, "umax16">;
  def SMIN8     : XxldspRR<0b1000100, 0b000, "smin8">;
  def UMIN8     : XxldspRR<0b1001100, 0b000, "umin8">;
  def SMAX8     : XxldspRR<0b1000101, 0b000, "smax8">;
  def UMAX8     : XxldspRR<0b1001101, 0b000, "umax8">;
  def PKBB16    : XxldspRR<0b0000111, 0b001, "pkbb16">;
  def PKBT16    : XxldspRR<0b0001111, 0b001, "pkbt16">;
  def PKTT16    : XxldspRR<0b0010111, 0b001, "pktt16">;
  def PKTB16    : XxldspRR<0b0011111, 0b001, "pktb16">;
  def SMMUL     : XxldspRR<0b0100000, 0b001, "smmul">;
  def SMMUL_U   : XxldspRR<0b0101000, 0b001, "smmul.u">;
  def KMMAC     : XxldspRRACC<0b0110000, 0b001, "kmmac">;
  def KMMAC_U   : XxldspRRACC<0b0111000, 0b001, "kmmac.u">;
  def KMMSB     : XxldspRRACC<0b0100001, 0b001, "kmmsb">;
  def KMMSB_U   : XxldspRRACC<0b0101001, 0b001, "kmmsb.u">;
  def KWMMUL    : XxldspRR<0b0110001, 0b001, "kwmmul">;
  def KWMMUL_U  : XxldspRR<0b0111001, 0b001, "kwmmul.u">;
  def SMMWB     : XxldspRR<0b0100010, 0b001, "smmwb">;
  def SMMWB_U   : XxldspRR<0b0101010, 0b001, "smmwb.u">;
  def SMMWT     : XxldspRR<0b0110010, 0b001, "smmwt">;
  def SMMWT_U   : XxldspRR<0b0111010, 0b001, "smmwt.u">;
  def KMMAWB    : XxldspRRACC<0b0100011, 0b001, "kmmawb">;
  def KMMAWB_U  : XxldspRRACC<0b0101011, 0b001, "kmmawb.u">;
  def KMMAWT    : XxldspRRACC<0b0110011, 0b001, "kmmawt">;
  def KMMAWT_U  : XxldspRRACC<0b0111011, 0b001, "kmmawt.u">;
  def KMMWB2    : XxldspRR<0b1000111, 0b001, "kmmwb2">;
  def KMMWB2_U  : XxldspRR<0b1001111, 0b001, "kmmwb2.u">;
  def KMMWT2    : XxldspRR<0b1010111, 0b001, "kmmwt2">;
  def KMMWT2_U  : XxldspRR<0b1011111, 0b001, "kmmwt2.u">;
  def KMMAWB2   : XxldspRRACC<0b1100111, 0b001, "kmmawb2">;
  def KMMAWB2_U : XxldspRRACC<0b1101111, 0b001, "kmmawb2.u">;
  def KMMAWT2   : XxldspRRACC<0b1110111, 0b001, "kmmawt2">;
  def KMMAWT2_U : XxldspRRACC<0b1111111, 0b001, "kmmawt2.u">;
  def SMBB16    : XxldspRR<0b0000100, 0b001, "smbb16">;
  def SMBT16    : XxldspRR<0b0001100, 0b001, "smbt16">;
  def SMTT16    : XxldspRR<0b0010100, 0b001, "smtt16">;
  def KMDA      : XxldspRR<0b0011100, 0b001, "kmda">;
  def KMXDA     : XxldspRR<0b0011101, 0b001, "kmxda">;
  def SMDS      : XxldspRR<0b0101100, 0b001, "smds">;
  def SMDRS     : XxldspRR<0b0110100, 0b001, "smdrs">;
  def SMXDS     : XxldspRR<0b0111100, 0b001, "smxds">;
  def KMABB     : XxldspRRACC<0b0101101, 0b001, "kmabb">;
  def KMABT     : XxldspRRACC<0b0110101, 0b001, "kmabt">;
  def KMATT     : XxldspRRACC<0b0111101, 0b001, "kmatt">;
  def KMADA     : XxldspRRACC<0b0100100, 0b001, "kmada">;
  def KMAXDA    : XxldspRRACC<0b0100101, 0b001, "kmaxda">;
  def KMADS     : XxldspRRACC<0b0101110, 0b001, "kmads">;
  def KMADRS    : XxldspRRACC<0b0110110, 0b001, "kmadrs">;
  def KMAXDS    : XxldspRRACC<0b0111110, 0b001, "kmaxds">;
  def KMSDA     : XxldspRRACC<0b0100110, 0b001, "kmsda">;
  def KMSXDA    : XxldspRRACC<0b0100111, 0b001, "kmsxda">;
  defm SMAL     : XxldspD64_S64_S32_Asm<0b0101111, 0b001, "smal">;
  def PBSAD     : XxldspRR<0b1111110, 0b000, "pbsad">;
  def PBSADA    : XxldspRRACC<0b1111111, 0b000, "pbsada">;
  def SMAQA     : XxldspRRACC<0b1100100, 0b000, "smaqa">;
  def UMAQA     : XxldspRRACC<0b1100110, 0b000, "umaqa">;
  def SMAQA_SU  : XxldspRRACC<0b1100101, 0b000, "smaqa.su">;
  defm ADD64    : XxldspD64_S64_S64_Asm<0b1100000, 0b001, "add64">;
  defm RADD64   : XxldspD64_S64_S64_Asm<0b1000000, 0b001, "radd64">;
  defm URADD64  : XxldspD64_S64_S64_Asm<0b1010000, 0b001, "uradd64">;
  defm KADD64   : XxldspD64_S64_S64_Asm<0b1001000, 0b001, "kadd64">;
  defm UKADD64  : XxldspD64_S64_S64_Asm<0b1011000, 0b001, "ukadd64">;
  defm SUB64    : XxldspD64_S64_S64_Asm<0b1100001, 0b001, "sub64">;
  defm RSUB64   : XxldspD64_S64_S64_Asm<0b1000001, 0b001, "rsub64">;
  defm URSUB64  : XxldspD64_S64_S64_Asm<0b1010001, 0b001, "ursub64">;
  defm KSUB64   : XxldspD64_S64_S64_Asm<0b1001001, 0b001, "ksub64">;
  defm UKSUB64  : XxldspD64_S64_S64_Asm<0b1011001, 0b001, "uksub64">;
  defm SMAR64   : XxldspD64_GPR_GPR_ACC_Asm<0b1000010, 0b001, "smar64">;
  defm SMSR64   : XxldspD64_GPR_GPR_ACC_Asm<0b1000011, 0b001, "smsr64">;
  defm UMAR64   : XxldspD64_GPR_GPR_ACC_Asm<0b1010010, 0b001, "umar64">;
  defm UMSR64   : XxldspD64_GPR_GPR_ACC_Asm<0b1010011, 0b001, "umsr64">;
  defm KMAR64   : XxldspD64_GPR_GPR_ACC_Asm<0b1001010, 0b001, "kmar64">;
  defm KMSR64   : XxldspD64_GPR_GPR_ACC_Asm<0b1001011, 0b001, "kmsr64">;
  defm UKMAR64  : XxldspD64_GPR_GPR_ACC_Asm<0b1011010, 0b001, "ukmar64">;
  defm UKMSR64  : XxldspD64_GPR_GPR_ACC_Asm<0b1011011, 0b001, "ukmsr64">;
  defm SMALBB   : XxldspD64_GPR_GPR_ACC_Asm<0b1000100, 0b001, "smalbb">;
  defm SMALBT   : XxldspD64_GPR_GPR_ACC_Asm<0b1001100, 0b001, "smalbt">;
  defm SMALTT   : XxldspD64_GPR_GPR_ACC_Asm<0b1010100, 0b001, "smaltt">;
  defm SMALDA   : XxldspD64_GPR_GPR_ACC_Asm<0b1000110, 0b001, "smalda">;
  defm SMALXDA  : XxldspD64_GPR_GPR_ACC_Asm<0b1001110, 0b001, "smalxda">;
  defm SMALDS   : XxldspD64_GPR_GPR_ACC_Asm<0b1000101, 0b001, "smalds">;
  defm SMALDRS  : XxldspD64_GPR_GPR_ACC_Asm<0b1001101, 0b001, "smaldrs">;
  defm SMALXDS  : XxldspD64_GPR_GPR_ACC_Asm<0b1010101, 0b001, "smalxds">;
  defm SMSLDA   : XxldspD64_GPR_GPR_ACC_Asm<0b1010110, 0b001, "smslda">;
  defm SMSLXDA  : XxldspD64_GPR_GPR_ACC_Asm<0b1011110, 0b001, "smslxda">;
  def KADDH     : XxldspRR<0b0000010, 0b001, "kaddh">;
  def KSUBH     : XxldspRR<0b0000011, 0b001, "ksubh">;
  def KHMBB     : XxldspRR<0b0000110, 0b001, "khmbb">;
  def KHMBT     : XxldspRR<0b0001110, 0b001, "khmbt">;
  def KHMTT     : XxldspRR<0b0010110, 0b001, "khmtt">;
  def UKADDH    : XxldspRR<0b0001010, 0b001, "ukaddh">;
  def UKSUBH    : XxldspRR<0b0001011, 0b001, "uksubh">;
  def KADDW     : XxldspRR<0b0000000, 0b001, "kaddw">;
  def UKADDW    : XxldspRR<0b0001000, 0b001, "ukaddw">;
  def KSUBW     : XxldspRR<0b0000001, 0b001, "ksubw">;
  def UKSUBW    : XxldspRR<0b0001001, 0b001, "uksubw">;
  def KDMBB     : XxldspRR<0b0000101, 0b001, "kdmbb">;
  def KDMBT     : XxldspRR<0b0001101, 0b001, "kdmbt">;
  def KDMTT     : XxldspRR<0b0010101, 0b001, "kdmtt">;
  def KSLRAW    : XxldspRR<0b0110111, 0b001, "kslraw">;
  def KSLRAW_U  : XxldspRR<0b0111111, 0b001, "kslraw.u">;
  def KSLLW     : XxldspRR<0b0010011, 0b001, "ksllw">;
  def KDMABB    : XxldspRRACC<0b1101001, 0b001, "kdmabb">;
  def KDMABT    : XxldspRRACC<0b1110001, 0b001, "kdmabt">;
  def KDMATT    : XxldspRRACC<0b1111001, 0b001, "kdmatt">;
  def RADDW     : XxldspRR<0b0010000, 0b001, "raddw">;
  def URADDW    : XxldspRR<0b0011000, 0b001, "uraddw">;
  def RSUBW     : XxldspRR<0b0010001, 0b001, "rsubw">;
  def URSUBW    : XxldspRR<0b0011001, 0b001, "ursubw">;
  def MAXW      : XxldspRR<0b1111001, 0b000, "maxw">;
  def MINW      : XxldspRR<0b1111000, 0b000, "minw">;
  defm MULR64   : XxldspD64_S32_S32_Asm<0b1111000, 0b001, "mulr64">;
  defm MULSR64  : XxldspD64_S32_S32_Asm<0b1110000, 0b001, "mulsr64">;
  def AVE       : XxldspRR<0b1110000, 0b000, "ave">;
  def SRA_U     : XxldspRR<0b0010010, 0b001, "sra.u">;
  def BITREV    : XxldspRR<0b1110011, 0b000, "bitrev">;
  defm WEXT     : XxldspGPR_S64_GPR_Asm<0b1100111, 0b000, "wext">;
  def MADDR32   : XxldspRRACC<0b1100010, 0b001, "maddr32">;
  def MSUBR32   : XxldspRRACC<0b1100011, 0b001, "msubr32">;

  def KABS16    : XxldspR<0b1010110, 0b10001, 0b000, "kabs16">;
  def CLRS16    : XxldspR<0b1010111, 0b01000, 0b000, "clrs16">;
  def CLZ16     : XxldspR<0b1010111, 0b01001, 0b000, "clz16">;
  def CLO16     : XxldspR<0b1010111, 0b01011, 0b000, "clo16">;
  def KABS8     : XxldspR<0b1010110, 0b10000, 0b000, "kabs8">;
  def CLRS8     : XxldspR<0b1010111, 0b00000, 0b000, "clrs8">;
  def CLZ8      : XxldspR<0b1010111, 0b00001, 0b000, "clz8">;
  def CLO8      : XxldspR<0b1010111, 0b00011, 0b000, "clo8">;
  def SWAP8     : XxldspR<0b1010110, 0b11000, 0b000, "swap8">;
  def SWAP16    : XxldspR<0b1010110, 0b11001, 0b000, "swap16">;
  def SUNPKD810 : XxldspR<0b1010110, 0b01000, 0b000, "sunpkd810">;
  def SUNPKD820 : XxldspR<0b1010110, 0b01001, 0b000, "sunpkd820">;
  def SUNPKD830 : XxldspR<0b1010110, 0b01010, 0b000, "sunpkd830">;
  def SUNPKD831 : XxldspR<0b1010110, 0b01011, 0b000, "sunpkd831">;
  def SUNPKD832 : XxldspR<0b1010110, 0b10011, 0b000, "sunpkd832">;
  def ZUNPKD810 : XxldspR<0b1010110, 0b01100, 0b000, "zunpkd810">;
  def ZUNPKD820 : XxldspR<0b1010110, 0b01101, 0b000, "zunpkd820">;
  def ZUNPKD830 : XxldspR<0b1010110, 0b01110, 0b000, "zunpkd830">;
  def ZUNPKD831 : XxldspR<0b1010110, 0b01111, 0b000, "zunpkd831">;
  def ZUNPKD832 : XxldspR<0b1010110, 0b10111, 0b000, "zunpkd832">;
  def CLRS32    : XxldspR<0b1010111, 0b11000, 0b000, "clrs32">;
  def CLZ32     : XxldspR<0b1010111, 0b11001, 0b000, "clz32">;
  def CLO32     : XxldspR<0b1010111, 0b11011, 0b000, "clo32">;
  def KABSW     : XxldspR<0b1010110, 0b10100, 0b000, "kabsw">;
  def EXPD80    : XxldspR<0b0010010, 0b00000, 0b111, "expd80">;
  def EXPD81    : XxldspR<0b0010010, 0b00001, 0b111, "expd81">;
  def EXPD82    : XxldspR<0b0010010, 0b00010, 0b111, "expd82">;
  def EXPD83    : XxldspR<0b0010010, 0b00011, 0b111, "expd83">;
  def EXPD84    : XxldspR<0b0010010, 0b00100, 0b111, "expd84">;
  def EXPD85    : XxldspR<0b0010010, 0b00101, 0b111, "expd85">;
  def EXPD86    : XxldspR<0b0010010, 0b00110, 0b111, "expd86">;
  def EXPD87    : XxldspR<0b0010010, 0b00111, 0b111, "expd87">;

  def SRAI8     : XxldspR_i3<0b0111100, 0b00, 0b000, "srai8">;
  def SRAI8_U   : XxldspR_i3<0b0111100, 0b01, 0b000, "srai8.u">;
  def SRLI8     : XxldspR_i3<0b0111101, 0b00, 0b000, "srli8">;
  def SRLI8_U   : XxldspR_i3<0b0111101, 0b01, 0b000, "srli8.u">;
  def SLLI8     : XxldspR_i3<0b0111110, 0b00, 0b000, "slli8">;
  def KSLLI8    : XxldspR_i3<0b0111110, 0b01, 0b000, "kslli8">;
  def SCLIP8    : XxldspR_i3<0b1000110, 0b00, 0b000, "sclip8">;
  def UCLIP8    : XxldspR_i3<0b1000110, 0b10, 0b000, "uclip8">;
  def INSB      : XxldspR_i3_ACC<0b1010110, 0b00, 0b000, "insb">;

  def SRAI16    : XxldspR_i4<0b0111000, 0b0, 0b000, "srai16">;
  def SRAI16_U  : XxldspR_i4<0b0111000, 0b1, 0b000, "srai16.u">;
  def SRLI16    : XxldspR_i4<0b0111001, 0b0, 0b000, "srli16">;
  def SRLI16_U  : XxldspR_i4<0b0111001, 0b1, 0b000, "srli16.u">;
  def SLLI16    : XxldspR_i4<0b0111010, 0b0, 0b000, "slli16">;
  def KSLLI16   : XxldspR_i4<0b0111010, 0b1, 0b000, "kslli16">;
  def SCLIP16   : XxldspR_i4<0b1000010, 0b0, 0b000, "sclip16">;
  def UCLIP16   : XxldspR_i4<0b1000010, 0b1, 0b000, "uclip16">;

  def SCLIP32   : XxldspR_i5<0b1110010, 0b000, "sclip32">;
  def UCLIP32   : XxldspR_i5<0b1111010, 0b000, "uclip32">;
  def KSLLIW    : XxldspR_i5<0b0011011, 0b001, "kslliw">;
  defm WEXTI    : XxldspGPR_S64_Shift_Asm<0b1101111, 0b000, "wexti">;

  def SRAI_U    : XxldspR_i6<0b110101, 0b001, "srai.u">;
  def BITREVI   : XxldspR_i6<0b111010, 0b000, "bitrevi">;

  def BPICK     : XxldspR4<0b00, 0b011, "bpick">;
}

let Predicates = [HasVendorXxldsp] in {
  def : InstAlias<"clrov", (CSRRCI X0, UCODE.Encoding, 1), 0>;
  def : InstAlias<"rdov $rd", (CSRRS GPR:$rd, UCODE.Encoding, X0), 0>;
}

let Predicates = [HasVendorXxldsp],
    hasSideEffects = 1, mayLoad = 0, mayStore = 0 in {
  def PseudoXLDSPCLROV : Pseudo<(outs), (ins),
                                 [(int_riscv_xldsp_clrov)]>,
                         PseudoInstExpansion<(CSRRCI X0, UCODE.Encoding, 1)>;
}

let Predicates = [HasVendorXxldsp, IsRV32],
    hasSideEffects = 1, mayLoad = 0, mayStore = 0 in {
  def PseudoXLDSPRDOV32 : Pseudo<(outs GPR:$rd), (ins),
                                  [(set GPR:$rd,
                                        (int_riscv_xldsp_rdov_32))]>,
                          PseudoInstExpansion<(CSRRS GPR:$rd, UCODE.Encoding,
                                                X0)>;
}

let Predicates = [HasVendorXxldsp, IsRV64],
    hasSideEffects = 1, mayLoad = 0, mayStore = 0 in {
  def PseudoXLDSPRDOV64 : Pseudo<(outs GPR:$rd), (ins),
                                  [(set GPR:$rd,
                                        (int_riscv_xldsp_rdov_64))]>,
                          PseudoInstExpansion<(CSRRS GPR:$rd, UCODE.Encoding,
                                                X0)>;
}

let Predicates = [HasVendorXxldsp, IsRV64] in {
  def : InstAlias<"smbb32 $rd, $rs1, $rs2", (MULSR64_64 GPR:$rd, GPR:$rs1, GPR:$rs2)>;
  def : InstAlias<"kmada32 $rd, $rs1, $rs2", (KMAR64_64 GPR:$rd, GPR:$rs1, GPR:$rs2)>;
}

let Predicates = [HasVendorXxldsp, IsRV64], DecoderNamespace = "Xxldsp",
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def ADD32     : XxldspRR<0b0100000, 0b010, "add32">;
  def RADD32    : XxldspRR<0b0000000, 0b010, "radd32">;
  def URADD32   : XxldspRR<0b0010000, 0b010, "uradd32">;
  def KADD32    : XxldspRR<0b0001000, 0b010, "kadd32">;
  def UKADD32   : XxldspRR<0b0011000, 0b010, "ukadd32">;
  def SUB32     : XxldspRR<0b0100001, 0b010, "sub32">;
  def RSUB32    : XxldspRR<0b0000001, 0b010, "rsub32">;
  def URSUB32   : XxldspRR<0b0010001, 0b010, "ursub32">;
  def KSUB32    : XxldspRR<0b0001001, 0b010, "ksub32">;
  def UKSUB32   : XxldspRR<0b0011001, 0b010, "uksub32">;
  def CRAS32    : XxldspRR<0b0100010, 0b010, "cras32">;
  def RCRAS32   : XxldspRR<0b0000010, 0b010, "rcras32">;
  def URCRAS32  : XxldspRR<0b0010010, 0b010, "urcras32">;
  def KCRAS32   : XxldspRR<0b0001010, 0b010, "kcras32">;
  def UKCRAS32  : XxldspRR<0b0011010, 0b010, "ukcras32">;
  def CRSA32    : XxldspRR<0b0100011, 0b010, "crsa32">;
  def RCRSA32   : XxldspRR<0b0000011, 0b010, "rcrsa32">;
  def URCRSA32  : XxldspRR<0b0010011, 0b010, "urcrsa32">;
  def KCRSA32   : XxldspRR<0b0001011, 0b010, "kcrsa32">;
  def UKCRSA32  : XxldspRR<0b0011011, 0b010, "ukcrsa32">;
  def STAS32    : XxldspRR<0b1111000, 0b010, "stas32">;
  def RSTAS32   : XxldspRR<0b1011000, 0b010, "rstas32">;
  def URSTAS32  : XxldspRR<0b1101000, 0b010, "urstas32">;
  def KSTAS32   : XxldspRR<0b1100000, 0b010, "kstas32">;
  def UKSTAS32  : XxldspRR<0b1110000, 0b010, "ukstas32">;
  def STSA32    : XxldspRR<0b1111001, 0b010, "stsa32">;
  def RSTSA32   : XxldspRR<0b1011001, 0b010, "rstsa32">;
  def URSTSA32  : XxldspRR<0b1101001, 0b010, "urstsa32">;
  def KSTSA32   : XxldspRR<0b1100001, 0b010, "kstsa32">;
  def UKSTSA32  : XxldspRR<0b1110001, 0b010, "ukstsa32">;
  def SRA32     : XxldspRR<0b0101000, 0b010, "sra32">;
  def SRA32_U   : XxldspRR<0b0110000, 0b010, "sra32.u">;
  def SRL32     : XxldspRR<0b0101001, 0b010, "srl32">;
  def SRL32_U   : XxldspRR<0b0110001, 0b010, "srl32.u">;
  def SLL32     : XxldspRR<0b0101010, 0b010, "sll32">;
  def KSLL32    : XxldspRR<0b0110010, 0b010, "ksll32">;
  def KSLRA32   : XxldspRR<0b0101011, 0b010, "kslra32">;
  def KSLRA32_U : XxldspRR<0b0110011, 0b010, "kslra32.u">;
  def SMIN32    : XxldspRR<0b1001000, 0b010, "smin32">;
  def UMIN32    : XxldspRR<0b1010000, 0b010, "umin32">;
  def SMAX32    : XxldspRR<0b1001001, 0b010, "smax32">;
  def UMAX32    : XxldspRR<0b1010001, 0b010, "umax32">;
  def KHMBB16   : XxldspRR<0b1101110, 0b001, "khmbb16">;
  def KHMBT16   : XxldspRR<0b1110110, 0b001, "khmbt16">;
  def KHMTT16   : XxldspRR<0b1111110, 0b001, "khmtt16">;
  def KDMBB16   : XxldspRR<0b1101101, 0b001, "kdmbb16">;
  def KDMBT16   : XxldspRR<0b1110101, 0b001, "kdmbt16">;
  def KDMTT16   : XxldspRR<0b1111101, 0b001, "kdmtt16">;
  def KDMABB16  : XxldspRRACC<0b1101100, 0b001, "kdmabb16">;
  def KDMABT16  : XxldspRRACC<0b1110100, 0b001, "kdmabt16">;
  def KDMATT16  : XxldspRRACC<0b1111100, 0b001, "kdmatt16">;
  def SMBT32    : XxldspRR<0b0001100, 0b010, "smbt32">;
  def SMTT32    : XxldspRR<0b0010100, 0b010, "smtt32">;
  def KMABB32   : XxldspRRACC<0b0101101, 0b010, "kmabb32">;
  def KMABT32   : XxldspRRACC<0b0110101, 0b010, "kmabt32">;
  def KMATT32   : XxldspRRACC<0b0111101, 0b010, "kmatt32">;
  def KMDA32    : XxldspRR<0b0011100, 0b010, "kmda32">;
  def KMXDA32   : XxldspRR<0b0011101, 0b010, "kmxda32">;
  def KMAXDA32  : XxldspRRACC<0b0100101, 0b010, "kmaxda32">;
  def KMADS32   : XxldspRRACC<0b0101110, 0b010, "kmads32">;
  def KMADRS32  : XxldspRRACC<0b0110110, 0b010, "kmadrs32">;
  def KMAXDS32  : XxldspRRACC<0b0111110, 0b010, "kmaxds32">;
  def KMSDA32   : XxldspRRACC<0b0100110, 0b010, "kmsda32">;
  def KMSXDA32  : XxldspRRACC<0b0100111, 0b010, "kmsxda32">;
  def SMDS32    : XxldspRR<0b0101100, 0b010, "smds32">;
  def SMDRS32   : XxldspRR<0b0110100, 0b010, "smdrs32">;
  def SMXDS32   : XxldspRR<0b0111100, 0b010, "smxds32">;
  def PKBB32    : XxldspRR<0b0000111, 0b010, "pkbb32">;
  def PKBT32    : XxldspRR<0b0001111, 0b010, "pkbt32">;
  def PKTT32    : XxldspRR<0b0010111, 0b010, "pktt32">;
  def PKTB32    : XxldspRR<0b0011111, 0b010, "pktb32">;

  def KABS32    : XxldspR<0b1010110, 0b10010, 0b000, "kabs32">;

  def SRAI32    : XxldspR_i5<0b0111000, 0b010, "srai32">;
  def SRAI32_U  : XxldspR_i5<0b1000000, 0b010, "srai32.u">;
  def SRLI32    : XxldspR_i5<0b0111001, 0b010, "srli32">;
  def SRLI32_U  : XxldspR_i5<0b1000001, 0b010, "srli32.u">;
  def SLLI32    : XxldspR_i5<0b0111010, 0b010, "slli32">;
  def KSLLI32   : XxldspR_i5<0b1000010, 0b010, "kslli32">;
  def SRAIW_U   : XxldspR_i5<0b0011010, 0b001, "sraiw.u">;
}

let Predicates = [HasVendorXxldspn1x, IsRV32], DecoderNamespace = "Xxldspn1x",
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def DKHM8     : XxldspRPRP<0b1000111, 0b111, "dkhm8">;
  def DKHM16    : XxldspRPRP<0b1000011, 0b111, "dkhm16">;
  def DKSLRA8   : XxldspRPR<0b0101111, 0b111, "dkslra8">;
  def DKSLRA16  : XxldspRPR<0b0101011, 0b111, "dkslra16">;
  def DKADD8    : XxldspRPRP<0b0001100, 0b111, "dkadd8">;
  def DKADD16   : XxldspRPRP<0b0001000, 0b111, "dkadd16">;
  def DKSUB8    : XxldspRPRP<0b0001101, 0b111, "dksub8">;
  def DKSUB16   : XxldspRPRP<0b0001001, 0b111, "dksub16">;

  def DKABS8    : XxldspRP<0b1010110, 0b10000, 0b111, "dkabs8">;
  def DKABS16   : XxldspRP<0b1010110, 0b10001, 0b111, "dkabs16">;
}

let Predicates = [HasVendorXxldspn2x, IsRV32], DecoderNamespace = "Xxldspn2x",
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def DKHMX8         : XxldspRPRP_cust3<0b0000000, 0b000, "dkhmx8">;
  def DKHMX16        : XxldspRPRP_cust3<0b0000001, 0b000, "dkhmx16">;
  def DSMMUL         : XxldspRPRP_cust3<0b0000010, 0b000, "dsmmul">;
  def DSMMUL_U       : XxldspRPRP_cust3<0b0000011, 0b000, "dsmmul.u">;
  def DKWMMUL        : XxldspRPRP_cust3<0b0000100, 0b000, "dkwmmul">;
  def DKWMMUL_U      : XxldspRPRP_cust3<0b0000101, 0b000, "dkwmmul.u">;
  def DKSLRA32       : XxldspRPR_cust3<0b0000111, 0b000, "dkslra32">;
  def DKADD32        : XxldspRPRP_cust3<0b0001000, 0b000, "dkadd32">;
  def DKSUB32        : XxldspRPRP_cust3<0b0001001, 0b000, "dksub32">;
  def DRADD16        : XxldspRPRP_cust3<0b0101110, 0b000, "dradd16">;
  def DSUB16         : XxldspRPRP_cust3<0b0101111, 0b000, "dsub16">;
  def DRADD32        : XxldspRPRP_cust3<0b0110000, 0b000, "dradd32">;
  def DSUB32         : XxldspRPRP_cust3<0b0110001, 0b000, "dsub32">;
  def DKMDA          : XxldspRPRP_cust3<0b0110010, 0b000, "dkmda">;
  def DKMXDA         : XxldspRPRP_cust3<0b0110011, 0b000, "dkmxda">;
  def DSMDRS         : XxldspRPRP_cust3<0b0110100, 0b000, "dsmdrs">;
  def DSMXDS         : XxldspRPRP_cust3<0b0110101, 0b000, "dsmxds">;
  def DSMBB32        : XxldspRPRP_cust3<0b0110110, 0b000, "dsmbb32">;
  def DSMBB32_SRA14  : XxldspRPRP_cust3<0b0110111, 0b000, "dsmbb32.sra14">;
  def DSMBB32_SRA32  : XxldspRPRP_cust3<0b0111000, 0b000, "dsmbb32.sra32">;
  def DSMBT32        : XxldspRPRP_cust3<0b0111001, 0b000, "dsmbt32">;
  def DSMBT32_SRA14  : XxldspRPRP_cust3<0b0111010, 0b000, "dsmbt32.sra14">;
  def DSMBT32_SRA32  : XxldspRPRP_cust3<0b0111011, 0b000, "dsmbt32.sra32">;
  def DSMTT32        : XxldspRPRP_cust3<0b0111100, 0b000, "dsmtt32">;
  def DSMTT32_SRA14  : XxldspRPRP_cust3<0b0111101, 0b000, "dsmtt32.sra14">;
  def DSMTT32_SRA32  : XxldspRPRP_cust3<0b0111110, 0b000, "dsmtt32.sra32">;
  def DPKBB32        : XxldspRPRP_cust3<0b0111111, 0b000, "dpkbb32">;
  def DPKBT32        : XxldspRPRP_cust3<0b1000000, 0b000, "dpkbt32">;
  def DPACK32        : XxldspRR_D64_cust3<0b1100110, 0b000, "dpack32">;
  def DPKTT32        : XxldspRPRP_cust3<0b1000001, 0b000, "dpktt32">;
  def DPKTB32        : XxldspRPRP_cust3<0b1000010, 0b000, "dpktb32">;
  def DPKTB16        : XxldspRPRP_cust3<0b1000011, 0b000, "dpktb16">;
  def DPKBB16        : XxldspRPRP_cust3<0b1000100, 0b000, "dpkbb16">;
  def DPKBT16        : XxldspRPRP_cust3<0b1000101, 0b000, "dpkbt16">;
  def DPKTT16        : XxldspRPRP_cust3<0b1000110, 0b000, "dpktt16">;
  def DSRA16         : XxldspRPRP_cust3<0b1000111, 0b000, "dsra16">;
  def DADD16         : XxldspRPRP_cust3<0b1001000, 0b000, "dadd16">;
  def DADD32         : XxldspRPRP_cust3<0b1001001, 0b000, "dadd32">;
  def DSMBB16        : XxldspRPRP_cust3<0b1001010, 0b000, "dsmbb16">;
  def DSMBT16        : XxldspRPRP_cust3<0b1001011, 0b000, "dsmbt16">;
  def DSMTT16        : XxldspRPRP_cust3<0b1001100, 0b000, "dsmtt16">;
  def DRCRSA16       : XxldspRPRP_cust3<0b1001101, 0b000, "drcrsa16">;
  def DRCRAS16       : XxldspRPRP_cust3<0b1001110, 0b000, "drcras16">;
  def DKCRSA16       : XxldspRPRP_cust3<0b1001111, 0b000, "dkcrsa16">;
  def DKCRAS16       : XxldspRPRP_cust3<0b1010000, 0b000, "dkcras16">;
  def DRSUB16        : XxldspRPRP_cust3<0b1010001, 0b000, "drsub16">;
  def DRSUB32        : XxldspRPRP_cust3<0b1010010, 0b000, "drsub32">;
  def DSTSA32        : XxldspRPRP_cust3<0b1010011, 0b000, "dstsa32">;
  def DSTAS32        : XxldspRPRP_cust3<0b1010100, 0b000, "dstas32">;
  def DKCRAS32       : XxldspRPRP_cust3<0b1010101, 0b000, "dkcras32">;
  def DKCRSA32       : XxldspRPRP_cust3<0b1010110, 0b000, "dkcrsa32">;
  def DCRSA32        : XxldspRPRP_cust3<0b1010111, 0b000, "dcrsa32">;
  def DCRAS32        : XxldspRPRP_cust3<0b1011000, 0b000, "dcras32">;
  def DKSTSA16       : XxldspRPRP_cust3<0b1011001, 0b000, "dkstsa16">;
  def DKSTAS16       : XxldspRPRP_cust3<0b1011010, 0b000, "dkstas16">;
  def DRCRSA32       : XxldspRPRP_cust3<0b1011110, 0b000, "drcrsa32">;
  def DRCRAS32       : XxldspRPRP_cust3<0b1110010, 0b000, "drcras32">;
  def DMSR16         : XxldspRPRP_cust3<0b1011111, 0b000, "dmsr16">;
  def DMSR17         : XxldspRPRP_cust3<0b1100000, 0b000, "dmsr17">;
  def DMSR33         : XxldspRPRP_cust3<0b1100001, 0b000, "dmsr33">;
  def DMXSR33        : XxldspRPRP_cust3<0b1110011, 0b000, "dmxsr33">;

  def DSCLIP8        : XxldspRP_i5_cust3<0b1011011, 0b000, "dsclip8">;
  def DSCLIP16       : XxldspRP_i5_cust3<0b1011100, 0b000, "dsclip16">;
  def DSCLIP32       : XxldspRP_i5_cust3<0b1011101, 0b000, "dsclip32">;

  def DKCLIP64       : XxldspRP_D32_cust3<0b0000110, 0b00001, 0b000, "dkclip64">;
  def DREDAS16       : XxldspRP_D32_cust3<0b0000110, 0b00010, 0b000, "dredas16">;
  def DREDSA16       : XxldspRP_D32_cust3<0b0000110, 0b00011, 0b000, "dredsa16">;

  def DKABS32        : XxldspRP_cust3<0b0000110, 0b00000, 0b000, "dkabs32">;
  def DSUNPKD810     : XxldspRP_cust3<0b0000110, 0b00100, 0b000, "dsunpkd810">;
  def DSUNPKD820     : XxldspRP_cust3<0b0000110, 0b00101, 0b000, "dsunpkd820">;
  def DSUNPKD830     : XxldspRP_cust3<0b0000110, 0b00110, 0b000, "dsunpkd830">;
  def DSUNPKD831     : XxldspRP_cust3<0b0000110, 0b00111, 0b000, "dsunpkd831">;
  def DSUNPKD832     : XxldspRP_cust3<0b0000110, 0b01000, 0b000, "dsunpkd832">;
  def DZUNPKD810     : XxldspRP_cust3<0b0000110, 0b01001, 0b000, "dzunpkd810">;
  def DZUNPKD820     : XxldspRP_cust3<0b0000110, 0b01010, 0b000, "dzunpkd820">;
  def DZUNPKD830     : XxldspRP_cust3<0b0000110, 0b01011, 0b000, "dzunpkd830">;
  def DZUNPKD831     : XxldspRP_cust3<0b0000110, 0b01100, 0b000, "dzunpkd831">;
  def DZUNPKD832     : XxldspRP_cust3<0b0000110, 0b01101, 0b000, "dzunpkd832">;
}

let Predicates = [HasVendorXxldspn3x, IsRV32], DecoderNamespace = "Xxldspn3x",
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def DKMMAC      : XxldspRPRP_ACC_cust3<0b0001010, 0b000, "dkmmac">;
  def DKMMAC_U    : XxldspRPRP_ACC_cust3<0b0001011, 0b000, "dkmmac.u">;
  def DKMMSB      : XxldspRPRP_ACC_cust3<0b0001100, 0b000, "dkmmsb">;
  def DKMMSB_U    : XxldspRPRP_ACC_cust3<0b0001101, 0b000, "dkmmsb.u">;
  def DKMADA      : XxldspRPRP_ACC_cust3<0b0001110, 0b000, "dkmada">;
  def DKMAXDA     : XxldspRPRP_ACC_cust3<0b0001111, 0b000, "dkmaxda">;
  def DKMADS      : XxldspRPRP_ACC_cust3<0b0010000, 0b000, "dkmads">;
  def DKMADRS     : XxldspRPRP_ACC_cust3<0b0010001, 0b000, "dkmadrs">;
  def DKMAXDS     : XxldspRPRP_ACC_cust3<0b0010010, 0b000, "dkmaxds">;
  def DKMSDA      : XxldspRPRP_ACC_cust3<0b0010011, 0b000, "dkmsda">;
  def DKMSXDA     : XxldspRPRP_ACC_cust3<0b0010100, 0b000, "dkmsxda">;
  def DSMAQA      : XxldspRPRP_ACC_cust3<0b0010101, 0b000, "dsmaqa">;
  def DSMAQA_SU   : XxldspRPRP_ACC_cust3<0b0010110, 0b000, "dsmaqa.su">;
  def DUMAQA      : XxldspRPRP_ACC_cust3<0b0010111, 0b000, "dumaqa">;
  def DKMDA32     : XxldspRPRP_cust3<0b0011000, 0b000, "dkmda32">;
  def DKMXDA32    : XxldspRPRP_cust3<0b0011001, 0b000, "dkmxda32">;
  def DKMADA32    : XxldspRPRP_ACC_cust3<0b0011010, 0b000, "dkmada32">;
  def DKMAXDA32   : XxldspRPRP_ACC_cust3<0b0011011, 0b000, "dkmaxda32">;
  def DKMADS32    : XxldspRPRP_ACC_cust3<0b0011100, 0b000, "dkmads32">;
  def DKMADRS32   : XxldspRPRP_ACC_cust3<0b0011101, 0b000, "dkmadrs32">;
  def DKMAXDS32   : XxldspRPRP_ACC_cust3<0b0011110, 0b000, "dkmaxds32">;
  def DKMSDA32    : XxldspRPRP_ACC_cust3<0b0011111, 0b000, "dkmsda32">;
  def DKMSXDA32   : XxldspRPRP_ACC_cust3<0b0100000, 0b000, "dkmsxda32">;
  def DSMDS32     : XxldspRPRP_cust3<0b0100001, 0b000, "dsmds32">;
  def DSMDRS32    : XxldspRPRP_cust3<0b0100010, 0b000, "dsmdrs32">;
  def DSMXDS32    : XxldspRPRP_cust3<0b0100011, 0b000, "dsmxds32">;
  def DSMALDA     : XxldspRPRP_ACC_cust3<0b0100100, 0b000, "dsmalda">;
  def DSMALXDA    : XxldspRPRP_ACC_cust3<0b0100101, 0b000, "dsmalxda">;
  def DSMALDS     : XxldspRPRP_ACC_cust3<0b0100110, 0b000, "dsmalds">;
  def DSMALDRS    : XxldspRPRP_ACC_cust3<0b0100111, 0b000, "dsmaldrs">;
  def DSMALXDS    : XxldspRPRP_ACC_cust3<0b0101000, 0b000, "dsmalxds">;
  def DSMSLDA     : XxldspRPRP_ACC_cust3<0b0101001, 0b000, "dsmslda">;
  def DSMSLXDA    : XxldspRPRP_ACC_cust3<0b0101010, 0b000, "dsmslxda">;
  def DDSMAQA     : XxldspRPRP_ACC_cust3<0b0101011, 0b000, "ddsmaqa">;
  def DDSMAQA_SU  : XxldspRPRP_ACC_cust3<0b0101100, 0b000, "ddsmaqa.su">;
  def DDUMAQA     : XxldspRPRP_ACC_cust3<0b0101101, 0b000, "ddumaqa">;
  def DSMADA16    : XxldspRPRP_D32_ACC_cust3<0b1100010, 0b000, "dsmada16">;
  def DSMAXDA16   : XxldspRPRP_D32_ACC_cust3<0b1100011, 0b000, "dsmaxda16">;
  def DKSMS32_U   : XxldspRPRP_ACC_cust3<0b1100100, 0b000, "dksms32.u">;
  def DMADA32     : XxldspRPRP_D32_ACC_cust3<0b1100101, 0b000, "dmada32">;
  def DSMA32_U    : XxldspRPRP_D32_cust3<0b1101000, 0b000, "dsma32.u">;
  def DSMXS32_U   : XxldspRPRP_D32_cust3<0b1101001, 0b000, "dsmxs32.u">;
  def DSMXA32_U   : XxldspRPRP_D32_cust3<0b1101010, 0b000, "dsmxa32.u">;
  def DSMS32_U    : XxldspRPRP_D32_cust3<0b1101011, 0b000, "dsms32.u">;
  def DSMALBB     : XxldspRPRP_ACC_cust3<0b1101100, 0b000, "dsmalbb">;
  def DSMALBT     : XxldspRPRP_ACC_cust3<0b1101101, 0b000, "dsmalbt">;
  def DSMALTT     : XxldspRPRP_ACC_cust3<0b1101110, 0b000, "dsmaltt">;
  def DKMABB32    : XxldspRPRP_ACC_cust3<0b1101111, 0b000, "dkmabb32">;
  def DKMABT32    : XxldspRPRP_ACC_cust3<0b1110000, 0b000, "dkmabt32">;
  def DKMATT32    : XxldspRPRP_ACC_cust3<0b1110001, 0b000, "dkmatt32">;
}

multiclass XxldspGprGprPats <string intr> {
  let Predicates = [IsRV32] in {
    def : PatGprGpr<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                    !cast<RVInst>(NAME)>;
  }
  let Predicates = [IsRV64] in {
    def : PatGprGpr<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                    !cast<RVInst>(NAME)>;
  }
}

multiclass XxldspGprPats <string intr> {
  let Predicates = [IsRV32] in {
    def : PatGpr<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                 !cast<RVInst>(NAME)>;
  }
  let Predicates = [IsRV64] in {
    def : PatGpr<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                 !cast<RVInst>(NAME)>;
  }
}

class PatGprGprGpr<SDPatternOperator OpNode, RVInst Inst, ValueType vt1 = XLenVT,
                ValueType vt2 = XLenVT, ValueType vt3 = XLenVT>
    : Pat<(vt1 (OpNode (vt1 GPR:$rs1), (vt2 GPR:$rs2), (vt3 GPR:$rs3))),
          (Inst GPR:$rs1, GPR:$rs2, GPR:$rs3)>;

multiclass XxldspGprGprGprPats <string intr> {
  let Predicates = [IsRV32] in {
    def : PatGprGprGpr<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                        !cast<RVInst>(NAME)>;
  }
  let Predicates = [IsRV64] in {
    def : PatGprGprGpr<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                        !cast<RVInst>(NAME)>;
  }
}

multiclass XxldspGprShift3Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32") GPR:$rs1, xl_uimm3:$imm),
              (!cast<RVInst>(NAME) GPR:$rs1, xl_uimm3:$imm)>;
  }
  let Predicates = [IsRV64] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64") GPR:$rs1, xl_uimm3:$imm),
              (!cast<RVInst>(NAME) GPR:$rs1, xl_uimm3:$imm)>;
  }
}

multiclass XxldspGprShift3ACCPats <string intr> {
  let Predicates = [IsRV32] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32") GPR:$rd, GPR:$rs1, xl_uimm3:$imm),
              (!cast<RVInst>(NAME) GPR:$rd, GPR:$rs1, xl_uimm3:$imm)>;
  }
  let Predicates = [IsRV64] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64") GPR:$rd, GPR:$rs1, xl_uimm3:$imm),
              (!cast<RVInst>(NAME) GPR:$rd, GPR:$rs1, xl_uimm3:$imm)>;
  }
}

multiclass XxldspGprShift4Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32") GPR:$rs1, xl_uimm4:$imm),
              (!cast<RVInst>(NAME) GPR:$rs1, xl_uimm4:$imm)>;
  }
  let Predicates = [IsRV64] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64") GPR:$rs1, xl_uimm4:$imm),
              (!cast<RVInst>(NAME) GPR:$rs1, xl_uimm4:$imm)>;
  }
}

multiclass XxldspGprShift5Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32") GPR:$rs1, xl_uimm5:$imm),
              (!cast<RVInst>(NAME) GPR:$rs1, xl_uimm5:$imm)>;
  }
  let Predicates = [IsRV64] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64") GPR:$rs1, xl_uimm5:$imm),
              (!cast<RVInst>(NAME) GPR:$rs1, xl_uimm5:$imm)>;
  }
}

multiclass XxldspGprShift6Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32") GPR:$rs1, xl_uimm6:$imm),
              (!cast<RVInst>(NAME) GPR:$rs1, xl_uimm6:$imm)>;
  }
  let Predicates = [IsRV64] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64") GPR:$rs1, xl_uimm6:$imm),
              (!cast<RVInst>(NAME) GPR:$rs1, xl_uimm6:$imm)>;
  }
}

class XxldspGpr64Gpr64Gpr64Pats_RV64 <string intr, string asm> :
    PatGprGpr<!cast<Intrinsic>("int_riscv_xldsp_" # intr),
                    !cast<RVInst>(asm)>;

class PatGprGprAcc<SDPatternOperator OpNode, RVInst Inst, ValueType vt1 = XLenVT,
                ValueType vt2 = XLenVT, ValueType vt3 = XLenVT>
    : Pat<(vt1 (OpNode (vt1 GPR:$rd), (vt2 GPR:$rs1), (vt3 GPR:$rs2))),
          (Inst GPR:$rd, GPR:$rs1, GPR:$rs2)>;

class XxldspGpr64Gpr64Gpr64ACCPats_RV64 <string intr, string asm> :
    PatGprGprAcc<!cast<Intrinsic>("int_riscv_xldsp_" # intr),
                    !cast<RVInst>(asm)>;

multiclass XxldspGprGprGprACCPats <string intr>
{
  let Predicates = [IsRV32] in {
    def : PatGprGprAcc<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                  !cast<RVInst>(NAME)>;
  }
  let Predicates = [IsRV64] in {
    def : PatGprGprAcc<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                  !cast<RVInst>(NAME)>;
  }
}

class XxldspGpr64Gpr64Pats_RV64 <string intr, string asm> :
    PatGpr<!cast<Intrinsic>("int_riscv_xldsp_" # intr),
                    !cast<RVInst>(asm)>;

class XxldspGpr64Shift5Pats_RV64 <string intr, string asm> : 
    Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR:$rs1, xl_uimm5:$imm),
              (!cast<RVInst>(asm) GPR:$rs1, xl_uimm5:$imm)>;

class PatD64S64S64RV32<SDPatternOperator OpNode, RVInst Inst, ValueType vt1 = v2i32>
    : Pat<(vt1 (OpNode (vt1 GPR32PairOp:$rs1), (vt1 GPR32PairOp:$rs2))),
          (Inst $rs1, $rs2)>;

class XxldspD64_S64_S64_Pats_RV32 <string intr, string asm>
    : PatD64S64S64RV32<!cast<Intrinsic>("int_riscv_xldsp_" # intr),
                      !cast<RVInst>(asm)>;

class XxldspD64_S64_Pats_RV32 <string intr, string asm>
    : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR32PairOp:$rs1),
              (!cast<RVInst>(asm) GPR32PairOp:$rs1)>;

class XxldspD64_S64_S32_Pats_RV32 <string intr, string asm>
    : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR32PairOp:$rs1, GPR:$rs2),
              (!cast<RVInst>(asm) GPR32PairOp:$rs1, GPR:$rs2)>;

class XxldspD32_S64_Pats_RV32 <string intr, string asm>
    : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR32PairOp:$rs1),
              (!cast<RVInst>(asm) GPR32PairOp:$rs1)>;

class XxldspD64_S64_Shift_Pats_RV32 <string intr, string asm>
    : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR32PairOp:$rs1, xl_uimm5:$imm),
              (!cast<RVInst>(asm) GPR32PairOp:$rs1, xl_uimm5:$imm)>;

class XxldspD64_S32_S32_Pats_RV32 <string intr, string asm>
    : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR:$rs1, GPR:$rs2),
              (!cast<RVInst>(asm) GPR:$rs1, GPR:$rs2)>;

class XxldspD64_S64_S64_ACC_Pats_RV32 <string intr, string asm>
    : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR32PairOp:$rd, GPR32PairOp:$rs1, GPR32PairOp:$rs2),
              (!cast<RVInst>(asm) GPR32PairOp:$rd, GPR32PairOp:$rs1, GPR32PairOp:$rs2)>;

class XxldspD32_S64_S64_ACC_Pats_RV32 <string intr, string asm>
    : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR:$rd, GPR32PairOp:$rs1, GPR32PairOp:$rs2),
              (!cast<RVInst>(asm) GPR:$rd, GPR32PairOp:$rs1, GPR32PairOp:$rs2)>;

class XxldspD32_S64_S64_Pats_RV32 <string intr, string asm>
    : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr) GPR32PairOp:$rs1, GPR32PairOp:$rs2),
              (!cast<RVInst>(asm) GPR32PairOp:$rs1, GPR32PairOp:$rs2)>;

let Predicates = [HasVendorXxldsp, IsRV32] in {
def : Pat<(extractelt (v2i32 GPR32PairOp:$rs1), 0),
          (i32 (EXTRACT_SUBREG GPR32PairOp:$rs1, sub_gpr_even))>;
def : Pat<(extractelt (v2i32 GPR32PairOp:$rs1), 1),
          (i32 (EXTRACT_SUBREG GPR32PairOp:$rs1, sub_gpr_odd))>;
}

class PatXxldspBinary<SDPatternOperator OpNode, RVInst Inst, ValueType vt1,
                        ValueType vt2, ValueType vt3, DAGOperand RC1, DAGOperand RC2>
    : Pat<(vt3 (OpNode (vt1 RC1:$rs1), (vt2 RC2:$rs2))),
          (Inst $rs1, $rs2)>;

multiclass XxldspD64_S32_S32_Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : PatXxldspBinary<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                  !cast<RVInst>(NAME # "_32"), i32, i32, v2i32, GPR, GPR>;
  }
  let Predicates = [IsRV64] in {
    def : PatXxldspBinary<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                  !cast<RVInst>(NAME # "_64"), i64, i64, i64, GPR, GPR>;
  }
}

multiclass XxldspD64_S64_GPR_Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : PatXxldspBinary<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                  !cast<RVInst>(NAME # "_32"), v2i32, i32, v2i32, GPR32PairOp, GPR>;
  }
  let Predicates = [IsRV64] in {
    def : PatXxldspBinary<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                  !cast<RVInst>(NAME # "_64"), i64, i64, i64, GPR, GPR>;
  }
}

multiclass XxldspD64_S64_S64_Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : PatXxldspBinary<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                  !cast<RVInst>(NAME # "_32"), v2i32, v2i32, v2i32, GPR32PairOp, GPR32PairOp>;
  }
  let Predicates = [IsRV64] in {
    def : PatXxldspBinary<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                  !cast<RVInst>(NAME # "_64"), i64, i64, i64, GPR, GPR>;
  }
}

class PatXxldspBinaryACC<SDPatternOperator OpNode, RVInst Inst, ValueType vt1,
                        ValueType vt2, ValueType vt3, DAGOperand RC1, DAGOperand RC2>
    : Pat<(vt3 (OpNode (vt3 RC1:$rd), (vt1 RC2:$rs1), (vt2 RC2:$rs2))),
          (Inst $rd, $rs1, $rs2)>;

multiclass XxldspD64_GPR_GPR_ACC_Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : PatXxldspBinaryACC<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                  !cast<RVInst>(NAME # "_32"), i32, i32, v2i32, GPR32PairOp, GPR>;
  }
  let Predicates = [IsRV64] in {
    def : PatXxldspBinaryACC<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                  !cast<RVInst>(NAME # "_64"), i64, i64, i64, GPR, GPR>;
  }
}

multiclass XxldspGPR_S64_GPR_Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : PatXxldspBinary<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32"),
                  !cast<RVInst>(NAME # "_32"), v2i32, i32, i32, GPR32PairOp, GPR>;
  }
  let Predicates = [IsRV64] in {
    def : PatXxldspBinary<!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64"),
                  !cast<RVInst>(NAME # "_64"), i64, i64, i64, GPR, GPR>;
  }
}

multiclass XxldspGPR_S64_Shift_Pats <string intr> {
  let Predicates = [IsRV32] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_32") GPR32PairOp:$rs1, xl_uimm5:$imm),
              (!cast<RVInst>(NAME # "_32") GPR32PairOp:$rs1, xl_uimm5:$imm)>;
  }
  let Predicates = [IsRV64] in {
    def : Pat<(!cast<Intrinsic>("int_riscv_xldsp_" # intr # "_64") GPR:$rs1, xl_uimm5:$imm),
              (!cast<RVInst>(NAME # "_64") GPR:$rs1, xl_uimm5:$imm)>;
  }
}

let Predicates = [HasVendorXxldsp] in {
  defm ADD16      : XxldspGprGprPats<"add16">;
  defm RADD16     : XxldspGprGprPats<"radd16">;
  defm URADD16    : XxldspGprGprPats<"uradd16">;
  defm KADD16     : XxldspGprGprPats<"kadd16">;
  defm UKADD16    : XxldspGprGprPats<"ukadd16">;
  defm SUB16      : XxldspGprGprPats<"sub16">;
  defm RSUB16     : XxldspGprGprPats<"rsub16">;
  defm URSUB16    : XxldspGprGprPats<"ursub16">;
  defm KSUB16     : XxldspGprGprPats<"ksub16">;
  defm UKSUB16    : XxldspGprGprPats<"uksub16">;
  defm CRAS16     : XxldspGprGprPats<"cras16">;
  defm RCRAS16    : XxldspGprGprPats<"rcras16">;
  defm URCRAS16   : XxldspGprGprPats<"urcras16">;
  defm KCRAS16    : XxldspGprGprPats<"kcras16">;
  defm UKCRAS16   : XxldspGprGprPats<"ukcras16">;
  defm CRSA16     : XxldspGprGprPats<"crsa16">;
  defm RCRSA16    : XxldspGprGprPats<"rcrsa16">;
  defm URCRSA16   : XxldspGprGprPats<"urcrsa16">;
  defm KCRSA16    : XxldspGprGprPats<"kcrsa16">;
  defm UKCRSA16   : XxldspGprGprPats<"ukcrsa16">;
  defm STAS16     : XxldspGprGprPats<"stas16">;
  defm RSTAS16    : XxldspGprGprPats<"rstas16">;
  defm URSTAS16   : XxldspGprGprPats<"urstas16">;
  defm KSTAS16    : XxldspGprGprPats<"kstas16">;
  defm UKSTAS16   : XxldspGprGprPats<"ukstas16">;
  defm STSA16     : XxldspGprGprPats<"stsa16">;
  defm RSTSA16    : XxldspGprGprPats<"rstsa16">;
  defm URSTSA16   : XxldspGprGprPats<"urstsa16">;
  defm KSTSA16    : XxldspGprGprPats<"kstsa16">;
  defm UKSTSA16   : XxldspGprGprPats<"ukstsa16">;
  defm ADD8       : XxldspGprGprPats<"add8">;
  defm RADD8      : XxldspGprGprPats<"radd8">;
  defm URADD8     : XxldspGprGprPats<"uradd8">;
  defm KADD8      : XxldspGprGprPats<"kadd8">;
  defm UKADD8     : XxldspGprGprPats<"ukadd8">;
  defm SUB8       : XxldspGprGprPats<"sub8">;
  defm RSUB8      : XxldspGprGprPats<"rsub8">;
  defm URSUB8     : XxldspGprGprPats<"ursub8">;
  defm KSUB8      : XxldspGprGprPats<"ksub8">;
  defm UKSUB8     : XxldspGprGprPats<"uksub8">;
  defm SRA16      : XxldspGprGprPats<"sra16">;
  defm SRA16_U    : XxldspGprGprPats<"sra16_u">;
  defm SRL16      : XxldspGprGprPats<"srl16">;
  defm SRL16_U    : XxldspGprGprPats<"srl16_u">;
  defm SLL16      : XxldspGprGprPats<"sll16">;
  defm KSLL16     : XxldspGprGprPats<"ksll16">;
  defm KSLRA16    : XxldspGprGprPats<"kslra16">;
  defm KSLRA16_U  : XxldspGprGprPats<"kslra16_u">;
  defm SRA8       : XxldspGprGprPats<"sra8">;
  defm SRA8_U     : XxldspGprGprPats<"sra8_u">;
  defm SRL8       : XxldspGprGprPats<"srl8">;
  defm SRL8_U     : XxldspGprGprPats<"srl8_u">;
  defm SLL8       : XxldspGprGprPats<"sll8">;
  defm KSLL8      : XxldspGprGprPats<"ksll8">;
  defm KSLRA8     : XxldspGprGprPats<"kslra8">;
  defm KSLRA8_U   : XxldspGprGprPats<"kslra8_u">;
  defm CMPEQ16    : XxldspGprGprPats<"cmpeq16">;
  defm SCMPLT16   : XxldspGprGprPats<"scmplt16">;
  defm SCMPLE16   : XxldspGprGprPats<"scmple16">;
  defm UCMPLT16   : XxldspGprGprPats<"ucmplt16">;
  defm UCMPLE16   : XxldspGprGprPats<"ucmple16">;
  defm CMPEQ8     : XxldspGprGprPats<"cmpeq8">;
  defm SCMPLT8    : XxldspGprGprPats<"scmplt8">;
  defm SCMPLE8    : XxldspGprGprPats<"scmple8">;
  defm UCMPLT8    : XxldspGprGprPats<"ucmplt8">;
  defm UCMPLE8    : XxldspGprGprPats<"ucmple8">;
  defm KHM16      : XxldspGprGprPats<"khm16">;
  defm KHMX16     : XxldspGprGprPats<"khmx16">;
  defm KHM8       : XxldspGprGprPats<"khm8">;
  defm KHMX8      : XxldspGprGprPats<"khmx8">;
  defm SMIN16     : XxldspGprGprPats<"smin16">;
  defm UMIN16     : XxldspGprGprPats<"umin16">;
  defm SMAX16     : XxldspGprGprPats<"smax16">;
  defm UMAX16     : XxldspGprGprPats<"umax16">;
  defm SMIN8      : XxldspGprGprPats<"smin8">;
  defm UMIN8      : XxldspGprGprPats<"umin8">;
  defm SMAX8      : XxldspGprGprPats<"smax8">;
  defm UMAX8      : XxldspGprGprPats<"umax8">;
  defm PKBB16     : XxldspGprGprPats<"pkbb16">;
  defm PKBT16     : XxldspGprGprPats<"pkbt16">;
  defm PKTT16     : XxldspGprGprPats<"pktt16">;
  defm PKTB16     : XxldspGprGprPats<"pktb16">;
  defm SMMUL      : XxldspGprGprPats<"smmul">;
  defm SMMUL_U    : XxldspGprGprPats<"smmul_u">;
  defm KWMMUL     : XxldspGprGprPats<"kwmmul">;
  defm KWMMUL_U   : XxldspGprGprPats<"kwmmul_u">;
  defm SMMWB      : XxldspGprGprPats<"smmwb">;
  defm SMMWB_U    : XxldspGprGprPats<"smmwb_u">;
  defm SMMWT      : XxldspGprGprPats<"smmwt">;
  defm SMMWT_U    : XxldspGprGprPats<"smmwt_u">;
  defm KMMWB2     : XxldspGprGprPats<"kmmwb2">;
  defm KMMWB2_U   : XxldspGprGprPats<"kmmwb2_u">;
  defm KMMWT2     : XxldspGprGprPats<"kmmwt2">;
  defm KMMWT2_U   : XxldspGprGprPats<"kmmwt2_u">;
  defm SMBB16     : XxldspGprGprPats<"smbb16">;
  defm SMBT16     : XxldspGprGprPats<"smbt16">;
  defm SMTT16     : XxldspGprGprPats<"smtt16">;
  defm KMDA       : XxldspGprGprPats<"kmda">;
  defm KMXDA      : XxldspGprGprPats<"kmxda">;
  defm SMDS       : XxldspGprGprPats<"smds">;
  defm SMDRS      : XxldspGprGprPats<"smdrs">;
  defm SMXDS      : XxldspGprGprPats<"smxds">;
  defm PBSAD      : XxldspGprGprPats<"pbsad">;
  defm KADDH      : XxldspGprGprPats<"kaddh">;
  defm KSUBH      : XxldspGprGprPats<"ksubh">;
  defm KHMBB      : XxldspGprGprPats<"khmbb">;
  defm KHMBT      : XxldspGprGprPats<"khmbt">;
  defm KHMTT      : XxldspGprGprPats<"khmtt">;
  defm UKADDH     : XxldspGprGprPats<"ukaddh">;
  defm UKSUBH     : XxldspGprGprPats<"uksubh">;
  defm KADDW      : XxldspGprGprPats<"kaddw">;
  defm UKADDW     : XxldspGprGprPats<"ukaddw">;
  defm KSUBW      : XxldspGprGprPats<"ksubw">;
  defm UKSUBW     : XxldspGprGprPats<"uksubw">;
  defm KDMBB      : XxldspGprGprPats<"kdmbb">;
  defm KDMBT      : XxldspGprGprPats<"kdmbt">;
  defm KDMTT      : XxldspGprGprPats<"kdmtt">;
  defm KSLRAW     : XxldspGprGprPats<"kslraw">;
  defm KSLRAW_U   : XxldspGprGprPats<"kslraw_u">;
  defm KSLLW      : XxldspGprGprPats<"ksllw">;
  defm RADDW      : XxldspGprGprPats<"raddw">;
  defm URADDW     : XxldspGprGprPats<"uraddw">;
  defm RSUBW      : XxldspGprGprPats<"rsubw">;
  defm URSUBW     : XxldspGprGprPats<"ursubw">;
  defm MAXW       : XxldspGprGprPats<"maxw">;
  defm MINW       : XxldspGprGprPats<"minw">;
  defm AVE        : XxldspGprGprPats<"ave">;
  defm SRA_U      : XxldspGprGprPats<"sra_u">;
  defm BITREV     : XxldspGprGprPats<"bitrev">;

  defm SMUL16     : XxldspD64_S32_S32_Pats<"smul16">;
  defm SMULX16    : XxldspD64_S32_S32_Pats<"smulx16">;
  defm UMUL16     : XxldspD64_S32_S32_Pats<"umul16">;
  defm UMULX16    : XxldspD64_S32_S32_Pats<"umulx16">;
  defm SMUL8      : XxldspD64_S32_S32_Pats<"smul8">;
  defm SMULX8     : XxldspD64_S32_S32_Pats<"smulx8">;
  defm UMUL8      : XxldspD64_S32_S32_Pats<"umul8">;
  defm UMULX8     : XxldspD64_S32_S32_Pats<"umulx8">;
  defm MULR64     : XxldspD64_S32_S32_Pats<"mulr64">;
  defm MULSR64    : XxldspD64_S32_S32_Pats<"mulsr64">;

  defm KMMAC      : XxldspGprGprGprACCPats<"kmmac">;
  defm KMMAC_U    : XxldspGprGprGprACCPats<"kmmac_u">;
  defm KMMSB      : XxldspGprGprGprACCPats<"kmmsb">;
  defm KMMSB_U    : XxldspGprGprGprACCPats<"kmmsb_u">;
  defm KMMAWB     : XxldspGprGprGprACCPats<"kmmawb">;
  defm KMMAWB_U   : XxldspGprGprGprACCPats<"kmmawb_u">;
  defm KMMAWT     : XxldspGprGprGprACCPats<"kmmawt">;
  defm KMMAWT_U   : XxldspGprGprGprACCPats<"kmmawt_u">;
  defm KMMAWB2    : XxldspGprGprGprACCPats<"kmmawb2">;
  defm KMMAWB2_U  : XxldspGprGprGprACCPats<"kmmawb2_u">;
  defm KMMAWT2    : XxldspGprGprGprACCPats<"kmmawt2">;
  defm KMMAWT2_U  : XxldspGprGprGprACCPats<"kmmawt2_u">;
  defm KMABB      : XxldspGprGprGprACCPats<"kmabb">;
  defm KMABT      : XxldspGprGprGprACCPats<"kmabt">;
  defm KMATT      : XxldspGprGprGprACCPats<"kmatt">;
  defm KMADA      : XxldspGprGprGprACCPats<"kmada">;
  defm KMAXDA     : XxldspGprGprGprACCPats<"kmaxda">;
  defm KMADS      : XxldspGprGprGprACCPats<"kmads">;
  defm KMADRS     : XxldspGprGprGprACCPats<"kmadrs">;
  defm KMAXDS     : XxldspGprGprGprACCPats<"kmaxds">;
  defm KMSDA      : XxldspGprGprGprACCPats<"kmsda">;
  defm KMSXDA     : XxldspGprGprGprACCPats<"kmsxda">;
  defm PBSADA     : XxldspGprGprGprACCPats<"pbsada">;
  defm SMAQA      : XxldspGprGprGprACCPats<"smaqa">;
  defm UMAQA      : XxldspGprGprGprACCPats<"umaqa">;
  defm SMAQA_SU   : XxldspGprGprGprACCPats<"smaqa_su">;
  defm KDMABB     : XxldspGprGprGprACCPats<"kdmabb">;
  defm KDMABT     : XxldspGprGprGprACCPats<"kdmabt">;
  defm KDMATT     : XxldspGprGprGprACCPats<"kdmatt">;
  defm MADDR32    : XxldspGprGprGprACCPats<"maddr32">;
  defm MSUBR32    : XxldspGprGprGprACCPats<"msubr32">;

  defm SMAL       : XxldspD64_S64_GPR_Pats<"smal">;

  defm ADD64      : XxldspD64_S64_S64_Pats<"add64">;
  defm RADD64     : XxldspD64_S64_S64_Pats<"radd64">;
  defm URADD64    : XxldspD64_S64_S64_Pats<"uradd64">;
  defm KADD64     : XxldspD64_S64_S64_Pats<"kadd64">;
  defm UKADD64    : XxldspD64_S64_S64_Pats<"ukadd64">;
  defm SUB64      : XxldspD64_S64_S64_Pats<"sub64">;
  defm RSUB64     : XxldspD64_S64_S64_Pats<"rsub64">;
  defm URSUB64    : XxldspD64_S64_S64_Pats<"ursub64">;
  defm KSUB64     : XxldspD64_S64_S64_Pats<"ksub64">;
  defm UKSUB64    : XxldspD64_S64_S64_Pats<"uksub64">;

  defm SMAR64     : XxldspD64_GPR_GPR_ACC_Pats<"smar64">;
  defm SMSR64     : XxldspD64_GPR_GPR_ACC_Pats<"smsr64">;
  defm UMAR64     : XxldspD64_GPR_GPR_ACC_Pats<"umar64">;
  defm UMSR64     : XxldspD64_GPR_GPR_ACC_Pats<"umsr64">;
  defm KMAR64     : XxldspD64_GPR_GPR_ACC_Pats<"kmar64">;
  defm KMSR64     : XxldspD64_GPR_GPR_ACC_Pats<"kmsr64">;
  defm UKMAR64    : XxldspD64_GPR_GPR_ACC_Pats<"ukmar64">;
  defm UKMSR64    : XxldspD64_GPR_GPR_ACC_Pats<"ukmsr64">;
  defm SMALBB     : XxldspD64_GPR_GPR_ACC_Pats<"smalbb">;
  defm SMALBT     : XxldspD64_GPR_GPR_ACC_Pats<"smalbt">;
  defm SMALTT     : XxldspD64_GPR_GPR_ACC_Pats<"smaltt">;
  defm SMALDA     : XxldspD64_GPR_GPR_ACC_Pats<"smalda">;
  defm SMALXDA    : XxldspD64_GPR_GPR_ACC_Pats<"smalxda">;
  defm SMALDS     : XxldspD64_GPR_GPR_ACC_Pats<"smalds">;
  defm SMALDRS    : XxldspD64_GPR_GPR_ACC_Pats<"smaldrs">;
  defm SMALXDS    : XxldspD64_GPR_GPR_ACC_Pats<"smalxds">;
  defm SMSLDA     : XxldspD64_GPR_GPR_ACC_Pats<"smslda">;
  defm SMSLXDA    : XxldspD64_GPR_GPR_ACC_Pats<"smslxda">;

  defm WEXT       : XxldspGPR_S64_GPR_Pats<"wext">;
  defm WEXTI      : XxldspGPR_S64_Shift_Pats<"wexti">;

  defm KABS16     : XxldspGprPats<"kabs16">;
  defm CLRS16     : XxldspGprPats<"clrs16">;
  defm CLZ16      : XxldspGprPats<"clz16">;
  defm CLO16      : XxldspGprPats<"clo16">;
  defm KABS8      : XxldspGprPats<"kabs8">;
  defm CLRS8      : XxldspGprPats<"clrs8">;
  defm CLZ8       : XxldspGprPats<"clz8">;
  defm CLO8       : XxldspGprPats<"clo8">;
  defm SWAP8      : XxldspGprPats<"swap8">;
  defm SWAP16     : XxldspGprPats<"swap16">;
  defm SUNPKD810  : XxldspGprPats<"sunpkd810">;
  defm SUNPKD820  : XxldspGprPats<"sunpkd820">;
  defm SUNPKD830  : XxldspGprPats<"sunpkd830">;
  defm SUNPKD831  : XxldspGprPats<"sunpkd831">;
  defm SUNPKD832  : XxldspGprPats<"sunpkd832">;
  defm ZUNPKD810  : XxldspGprPats<"zunpkd810">;
  defm ZUNPKD820  : XxldspGprPats<"zunpkd820">;
  defm ZUNPKD830  : XxldspGprPats<"zunpkd830">;
  defm ZUNPKD831  : XxldspGprPats<"zunpkd831">;
  defm ZUNPKD832  : XxldspGprPats<"zunpkd832">;
  defm CLRS32     : XxldspGprPats<"clrs32">;
  defm CLZ32      : XxldspGprPats<"clz32">;
  defm CLO32      : XxldspGprPats<"clo32">;
  defm KABSW      : XxldspGprPats<"kabsw">;
  defm EXPD80     : XxldspGprPats<"expd80">;
  defm EXPD81     : XxldspGprPats<"expd81">;
  defm EXPD82     : XxldspGprPats<"expd82">;
  defm EXPD83     : XxldspGprPats<"expd83">;



  defm SRAI8      : XxldspGprShift3Pats<"srai8">;
  defm SRAI8_U    : XxldspGprShift3Pats<"srai8_u">;
  defm SRLI8      : XxldspGprShift3Pats<"srli8">;
  defm SRLI8_U    : XxldspGprShift3Pats<"srli8_u">;
  defm SLLI8      : XxldspGprShift3Pats<"slli8">;
  defm KSLLI8     : XxldspGprShift3Pats<"kslli8">;
  defm SCLIP8     : XxldspGprShift3Pats<"sclip8">;
  defm UCLIP8     : XxldspGprShift3Pats<"uclip8">;
  defm SRAI16     : XxldspGprShift4Pats<"srai16">;
  defm SRAI16_U   : XxldspGprShift4Pats<"srai16_u">;
  defm SRLI16     : XxldspGprShift4Pats<"srli16">;
  defm SRLI16_U   : XxldspGprShift4Pats<"srli16_u">;
  defm SLLI16     : XxldspGprShift4Pats<"slli16">;
  defm KSLLI16    : XxldspGprShift4Pats<"kslli16">;
  defm SCLIP16    : XxldspGprShift4Pats<"sclip16">;
  defm UCLIP16    : XxldspGprShift4Pats<"uclip16">;
  defm SCLIP32    : XxldspGprShift5Pats<"sclip32">;
  defm UCLIP32    : XxldspGprShift5Pats<"uclip32">;
  defm KSLLIW     : XxldspGprShift5Pats<"kslliw">;
  defm SRAI_U     : XxldspGprShift6Pats<"srai_u">;
  defm BITREVI    : XxldspGprShift6Pats<"bitrevi">;

  defm BPICK      : XxldspGprGprGprPats<"bpick">;

  defm INSB       : XxldspGprShift3ACCPats<"insb">;

  let Predicates = [IsRV64] in {
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"add32", "ADD32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"radd32", "RADD32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"uradd32", "URADD32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kadd32", "KADD32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"ukadd32", "UKADD32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"sub32", "SUB32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"rsub32", "RSUB32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"ursub32", "URSUB32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"ksub32", "KSUB32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"uksub32", "UKSUB32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"cras32", "CRAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"rcras32", "RCRAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"urcras32", "URCRAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kcras32", "KCRAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"ukcras32", "UKCRAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"crsa32", "CRSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"rcrsa32", "RCRSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"urcrsa32", "URCRSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kcrsa32", "KCRSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"ukcrsa32", "UKCRSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"stas32", "STAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"rstas32", "RSTAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"urstas32", "URSTAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kstas32", "KSTAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"ukstas32", "UKSTAS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"stsa32", "STSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"rstsa32", "RSTSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"urstsa32", "URSTSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kstsa32", "KSTSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"ukstsa32", "UKSTSA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"sra32", "SRA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"sra32_u", "SRA32_U">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"srl32", "SRL32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"srl32_u", "SRL32_U">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"sll32", "SLL32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"ksll32", "KSLL32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kslra32", "KSLRA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kslra32_u", "KSLRA32_U">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"smin32", "SMIN32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"umin32", "UMIN32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"smax32", "SMAX32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"umax32", "UMAX32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"khmbb16", "KHMBB16">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"khmbt16", "KHMBT16">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"khmtt16", "KHMTT16">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kdmbb16", "KDMBB16">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kdmbt16", "KDMBT16">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kdmtt16", "KDMTT16">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"smbt32", "SMBT32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"smtt32", "SMTT32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kmda32", "KMDA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"kmxda32", "KMXDA32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"smds32", "SMDS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"smdrs32", "SMDRS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"smxds32", "SMXDS32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"pkbb32", "PKBB32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"pkbt32", "PKBT32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"pktt32", "PKTT32">;
  def : XxldspGpr64Gpr64Gpr64Pats_RV64<"pktb32", "PKTB32">;

  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kdmabb16", "KDMABB16">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kdmabt16", "KDMABT16">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kdmatt16", "KDMATT16">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmabb32", "KMABB32">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmabt32", "KMABT32">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmatt32", "KMATT32">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmaxda32", "KMAXDA32">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmads32", "KMADS32">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmadrs32", "KMADRS32">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmaxds32", "KMAXDS32">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmsda32", "KMSDA32">;
  def : XxldspGpr64Gpr64Gpr64ACCPats_RV64<"kmsxda32", "KMSXDA32">;

  def : XxldspGpr64Gpr64Pats_RV64<"kabs32", "KABS32">;
  def : XxldspGpr64Gpr64Pats_RV64<"expd84", "EXPD84">;
  def : XxldspGpr64Gpr64Pats_RV64<"expd85", "EXPD85">;
  def : XxldspGpr64Gpr64Pats_RV64<"expd86", "EXPD86">;
  def : XxldspGpr64Gpr64Pats_RV64<"expd87", "EXPD87">;

  def : XxldspGpr64Shift5Pats_RV64<"srai32", "SRAI32">;
  def : XxldspGpr64Shift5Pats_RV64<"srai32_u", "SRAI32_U">;
  def : XxldspGpr64Shift5Pats_RV64<"srli32", "SRLI32">;
  def : XxldspGpr64Shift5Pats_RV64<"srli32_u", "SRLI32_U">;
  def : XxldspGpr64Shift5Pats_RV64<"slli32", "SLLI32">;
  def : XxldspGpr64Shift5Pats_RV64<"kslli32", "KSLLI32">;
  def : XxldspGpr64Shift5Pats_RV64<"sraiw_u", "SRAIW_U">;
  }
}

let Predicates = [HasVendorXxldspn1x, IsRV32] in {
  def : XxldspD64_S64_S64_Pats_RV32<"dkhm8", "DKHM8">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkhm16", "DKHM16">;
  def : XxldspD64_S64_S32_Pats_RV32<"dkslra8", "DKSLRA8">;
  def : XxldspD64_S64_S32_Pats_RV32<"dkslra16", "DKSLRA16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkadd8", "DKADD8">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkadd16", "DKADD16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dksub8", "DKSUB8">;
  def : XxldspD64_S64_S64_Pats_RV32<"dksub16", "DKSUB16">;
  def : XxldspD64_S64_Pats_RV32<"dkabs8", "DKABS8">;
  def : XxldspD64_S64_Pats_RV32<"dkabs16", "DKABS16">;

}

let Predicates = [HasVendorXxldspn2x, IsRV32] in {
  def : XxldspD64_S64_S64_Pats_RV32<"dkhmx8", "DKHMX8">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkhmx16", "DKHMX16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmmul", "DSMMUL">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmmul_u", "DSMMUL_U">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkwmmul", "DKWMMUL">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkwmmul_u", "DKWMMUL_U">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkadd32", "DKADD32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dksub32", "DKSUB32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dradd16", "DRADD16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsub16", "DSUB16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dradd32", "DRADD32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsub32", "DSUB32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkmda", "DKMDA">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkmxda", "DKMXDA">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmdrs", "DSMDRS">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmxds", "DSMXDS">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmbb32", "DSMBB32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmbb32_sra14", "DSMBB32_SRA14">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmbb32_sra32", "DSMBB32_SRA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmbt32", "DSMBT32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmbt32_sra14", "DSMBT32_SRA14">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmbt32_sra32", "DSMBT32_SRA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmtt32", "DSMTT32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmtt32_sra14", "DSMTT32_SRA14">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmtt32_sra32", "DSMTT32_SRA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dpkbb32", "DPKBB32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dpkbt32", "DPKBT32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dpktt32", "DPKTT32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dpktb32", "DPKTB32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dpktb16", "DPKTB16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dpkbb16", "DPKBB16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dpkbt16", "DPKBT16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dpktt16", "DPKTT16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsra16", "DSRA16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dadd16", "DADD16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dadd32", "DADD32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmbb16", "DSMBB16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmbt16", "DSMBT16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmtt16", "DSMTT16">;
  def : XxldspD64_S64_S64_Pats_RV32<"drcrsa16", "DRCRSA16">;
  def : XxldspD64_S64_S64_Pats_RV32<"drcras16", "DRCRAS16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkcrsa16", "DKCRSA16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkcras16", "DKCRAS16">;
  def : XxldspD64_S64_S64_Pats_RV32<"drsub16", "DRSUB16">;
  def : XxldspD64_S64_S64_Pats_RV32<"drsub32", "DRSUB32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dstsa32", "DSTSA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dstas32", "DSTAS32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkcras32", "DKCRAS32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkcrsa32", "DKCRSA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dcrsa32", "DCRSA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dcras32", "DCRAS32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkstsa16", "DKSTSA16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkstas16", "DKSTAS16">;
  def : XxldspD64_S64_S64_Pats_RV32<"drcrsa32", "DRCRSA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"drcras32", "DRCRAS32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dmsr16", "DMSR16">;
  def : XxldspD64_S64_S64_Pats_RV32<"dmsr17", "DMSR17">;
  def : XxldspD64_S64_S64_Pats_RV32<"dmsr33", "DMSR33">;
  def : XxldspD64_S64_S64_Pats_RV32<"dmxsr33", "DMXSR33">;

  def : XxldspD64_S64_Pats_RV32<"dkabs32", "DKABS32">;
  def : XxldspD64_S64_Pats_RV32<"dsunpkd810", "DSUNPKD810">;
  def : XxldspD64_S64_Pats_RV32<"dsunpkd820", "DSUNPKD820">;
  def : XxldspD64_S64_Pats_RV32<"dsunpkd830", "DSUNPKD830">;
  def : XxldspD64_S64_Pats_RV32<"dsunpkd831", "DSUNPKD831">;
  def : XxldspD64_S64_Pats_RV32<"dsunpkd832", "DSUNPKD832">;
  def : XxldspD64_S64_Pats_RV32<"dzunpkd810", "DZUNPKD810">;
  def : XxldspD64_S64_Pats_RV32<"dzunpkd820", "DZUNPKD820">;
  def : XxldspD64_S64_Pats_RV32<"dzunpkd830", "DZUNPKD830">;
  def : XxldspD64_S64_Pats_RV32<"dzunpkd831", "DZUNPKD831">;
  def : XxldspD64_S64_Pats_RV32<"dzunpkd832", "DZUNPKD832">;

  def : XxldspD64_S64_S32_Pats_RV32<"dkslra32", "DKSLRA32">;

  def : XxldspD32_S64_Pats_RV32<"dkclip64", "DKCLIP64">;
  def : XxldspD32_S64_Pats_RV32<"dredas16", "DREDAS16">;
  def : XxldspD32_S64_Pats_RV32<"dredsa16", "DREDSA16">;

  def : XxldspD64_S64_Shift_Pats_RV32<"dsclip8", "DSCLIP8">;
  def : XxldspD64_S64_Shift_Pats_RV32<"dsclip16", "DSCLIP16">;
  def : XxldspD64_S64_Shift_Pats_RV32<"dsclip32", "DSCLIP32">;

  def : XxldspD64_S32_S32_Pats_RV32<"dpack32", "DPACK32">;
}

let Predicates = [HasVendorXxldspn3x, IsRV32] in {
  def : XxldspD64_S64_S64_Pats_RV32<"dkmda32", "DKMDA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dkmxda32", "DKMXDA32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmds32", "DSMDS32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmdrs32", "DSMDRS32">;
  def : XxldspD64_S64_S64_Pats_RV32<"dsmxds32", "DSMXDS32">;

  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmmac", "DKMMAC">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmmac_u", "DKMMAC_U">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmmsb", "DKMMSB">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmmsb_u", "DKMMSB_U">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmada", "DKMADA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmaxda", "DKMAXDA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmads", "DKMADS">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmadrs", "DKMADRS">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmaxds", "DKMAXDS">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmsda", "DKMSDA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmsxda", "DKMSXDA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmaqa", "DSMAQA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmaqa_su", "DSMAQA_SU">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dumaqa", "DUMAQA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmada32", "DKMADA32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmaxda32", "DKMAXDA32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmads32", "DKMADS32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmadrs32", "DKMADRS32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmaxds32", "DKMAXDS32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmsda32", "DKMSDA32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmsxda32", "DKMSXDA32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmalda", "DSMALDA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmalxda", "DSMALXDA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmalds", "DSMALDS">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmaldrs", "DSMALDRS">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmalxds", "DSMALXDS">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmslda", "DSMSLDA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmslxda", "DSMSLXDA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"ddsmaqa", "DDSMAQA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"ddsmaqa_su", "DDSMAQA_SU">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"ddumaqa", "DDUMAQA">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dksms32_u", "DKSMS32_U">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmalbb", "DSMALBB">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmalbt", "DSMALBT">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dsmaltt", "DSMALTT">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmabb32", "DKMABB32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmabt32", "DKMABT32">;
  def : XxldspD64_S64_S64_ACC_Pats_RV32<"dkmatt32", "DKMATT32">;

  def : XxldspD32_S64_S64_ACC_Pats_RV32<"dsmada16", "DSMADA16">;
  def : XxldspD32_S64_S64_ACC_Pats_RV32<"dsmaxda16", "DSMAXDA16">;
  def : XxldspD32_S64_S64_ACC_Pats_RV32<"dmada32", "DMADA32">;

  def : XxldspD32_S64_S64_Pats_RV32<"dsma32_u", "DSMA32_U">;
  def : XxldspD32_S64_S64_Pats_RV32<"dsmxs32_u", "DSMXS32_U">;
  def : XxldspD32_S64_S64_Pats_RV32<"dsmxa32_u", "DSMXA32_U">;
  def : XxldspD32_S64_S64_Pats_RV32<"dsms32_u", "DSMS32_U">;
}
