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

class XxldspRR<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_DSP, (outs GPR:$rd),
              (ins GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

class XxldspRR_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd),
              (ins GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

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

class XxldspR_i5_cust3<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstIBase<funct3, OPC_CUSTOM_3, (outs GPR:$rd), (ins GPR:$rs1, uimm5:$imm),
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
  def SMUL16    : XxldspRR<0b1010000, 0b000, "smul16">;
  def SMULX16   : XxldspRR<0b1010001, 0b000, "smulx16">;
  def UMUL16    : XxldspRR<0b1011000, 0b000, "umul16">;
  def UMULX16   : XxldspRR<0b1011001, 0b000, "umulx16">;
  def KHM16     : XxldspRR<0b1000011, 0b000, "khm16">;
  def KHMX16    : XxldspRR<0b1001011, 0b000, "khmx16">;
  def SMUL8     : XxldspRR<0b1010100, 0b000, "smul8">;
  def SMULX8    : XxldspRR<0b1010101, 0b000, "smulx8">;
  def UMUL8     : XxldspRR<0b1011100, 0b000, "umul8">;
  def UMULX8    : XxldspRR<0b1011101, 0b000, "umulx8">;
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
  def KMMAC     : XxldspRR<0b0110000, 0b001, "kmmac">;
  def KMMAC_U   : XxldspRR<0b0111000, 0b001, "kmmac.u">;
  def KMMSB     : XxldspRR<0b0100001, 0b001, "kmmsb">;
  def KMMSB_U   : XxldspRR<0b0101001, 0b001, "kmmsb.u">;
  def KWMMUL    : XxldspRR<0b0110001, 0b001, "kwmmul">;
  def KWMMUL_U  : XxldspRR<0b0111001, 0b001, "kwmmul.u">;
  def SMMWB     : XxldspRR<0b0100010, 0b001, "smmwb">;
  def SMMWB_U   : XxldspRR<0b0101010, 0b001, "smmwb.u">;
  def SMMWT     : XxldspRR<0b0110010, 0b001, "smmwt">;
  def SMMWT_U   : XxldspRR<0b0111010, 0b001, "smmwt.u">;
  def KMMAWB    : XxldspRR<0b0100011, 0b001, "kmmawb">;
  def KMMAWB_U  : XxldspRR<0b0101011, 0b001, "kmmawb.u">;
  def KMMAWT    : XxldspRR<0b0110011, 0b001, "kmmawt">;
  def KMMAWT_U  : XxldspRR<0b0111011, 0b001, "kmmawt.u">;
  def KMMWB2    : XxldspRR<0b1000111, 0b001, "kmmwb2">;
  def KMMWB2_U  : XxldspRR<0b1001111, 0b001, "kmmwb2.u">;
  def KMMWT2    : XxldspRR<0b1010111, 0b001, "kmmwt2">;
  def KMMWT2_U  : XxldspRR<0b1011111, 0b001, "kmmwt2.u">;
  def KMMAWB2   : XxldspRR<0b1100111, 0b001, "kmmawb2">;
  def KMMAWB2_U : XxldspRR<0b1101111, 0b001, "kmmawb2.u">;
  def KMMAWT2   : XxldspRR<0b1110111, 0b001, "kmmawt2">;
  def KMMAWT2_U : XxldspRR<0b1111111, 0b001, "kmmawt2.u">;
  def SMBB16    : XxldspRR<0b0000100, 0b001, "smbb16">;
  def SMBT16    : XxldspRR<0b0001100, 0b001, "smbt16">;
  def SMTT16    : XxldspRR<0b0010100, 0b001, "smtt16">;
  def KMDA      : XxldspRR<0b0011100, 0b001, "kmda">;
  def KMXDA     : XxldspRR<0b0011101, 0b001, "kmxda">;
  def SMDS      : XxldspRR<0b0101100, 0b001, "smds">;
  def SMDRS     : XxldspRR<0b0110100, 0b001, "smdrs">;
  def SMXDS     : XxldspRR<0b0111100, 0b001, "smxds">;
  def KMABB     : XxldspRR<0b0101101, 0b001, "kmabb">;
  def KMABT     : XxldspRR<0b0110101, 0b001, "kmabt">;
  def KMATT     : XxldspRR<0b0111101, 0b001, "kmatt">;
  def KMADA     : XxldspRR<0b0100100, 0b001, "kmada">;
  def KMAXDA    : XxldspRR<0b0100101, 0b001, "kmaxda">;
  def KMADS     : XxldspRR<0b0101110, 0b001, "kmads">;
  def KMADRS    : XxldspRR<0b0110110, 0b001, "kmadrs">;
  def KMAXDS    : XxldspRR<0b0111110, 0b001, "kmaxds">;
  def KMSDA     : XxldspRR<0b0100110, 0b001, "kmsda">;
  def KMSXDA    : XxldspRR<0b0100111, 0b001, "kmsxda">;
  def SMAL      : XxldspRR<0b0101111, 0b001, "smal">;
  def PBSAD     : XxldspRR<0b1111110, 0b000, "pbsad">;
  def PBSADA    : XxldspRR<0b1111111, 0b000, "pbsada">;
  def SMAQA     : XxldspRR<0b1100100, 0b000, "smaqa">;
  def UMAQA     : XxldspRR<0b1100110, 0b000, "umaqa">;
  def SMAQA_SU  : XxldspRR<0b1100101, 0b000, "smaqa.su">;
  def ADD64     : XxldspRR<0b1100000, 0b001, "add64">;
  def RADD64    : XxldspRR<0b1000000, 0b001, "radd64">;
  def URADD64   : XxldspRR<0b1010000, 0b001, "uradd64">;
  def KADD64    : XxldspRR<0b1001000, 0b001, "kadd64">;
  def UKADD64   : XxldspRR<0b1011000, 0b001, "ukadd64">;
  def SUB64     : XxldspRR<0b1100001, 0b001, "sub64">;
  def RSUB64    : XxldspRR<0b1000001, 0b001, "rsub64">;
  def URSUB64   : XxldspRR<0b1010001, 0b001, "ursub64">;
  def KSUB64    : XxldspRR<0b1001001, 0b001, "ksub64">;
  def UKSUB64   : XxldspRR<0b1011001, 0b001, "uksub64">;
  def SMAR64    : XxldspRR<0b1000010, 0b001, "smar64">;
  def SMSR64    : XxldspRR<0b1000011, 0b001, "smsr64">;
  def UMAR64    : XxldspRR<0b1010010, 0b001, "umar64">;
  def UMSR64    : XxldspRR<0b1010011, 0b001, "umsr64">;
  def KMAR64    : XxldspRR<0b1001010, 0b001, "kmar64">;
  def KMSR64    : XxldspRR<0b1001011, 0b001, "kmsr64">;
  def UKMAR64   : XxldspRR<0b1011010, 0b001, "ukmar64">;
  def UKMSR64   : XxldspRR<0b1011011, 0b001, "ukmsr64">;
  def SMALBB    : XxldspRR<0b1000100, 0b001, "smalbb">;
  def SMALBT    : XxldspRR<0b1001100, 0b001, "smalbt">;
  def SMALTT    : XxldspRR<0b1010100, 0b001, "smaltt">;
  def SMALDA    : XxldspRR<0b1000110, 0b001, "smalda">;
  def SMALXDA   : XxldspRR<0b1001110, 0b001, "smalxda">;
  def SMALDS    : XxldspRR<0b1000101, 0b001, "smalds">;
  def SMALDRS   : XxldspRR<0b1001101, 0b001, "smaldrs">;
  def SMALXDS   : XxldspRR<0b1010101, 0b001, "smalxds">;
  def SMSLDA    : XxldspRR<0b1010110, 0b001, "smslda">;
  def SMSLXDA   : XxldspRR<0b1011110, 0b001, "smslxda">;
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
  def KDMABB    : XxldspRR<0b1101001, 0b001, "kdmabb">;
  def KDMABT    : XxldspRR<0b1110001, 0b001, "kdmabt">;
  def KDMATT    : XxldspRR<0b1111001, 0b001, "kdmatt">;
  def RADDW     : XxldspRR<0b0010000, 0b001, "raddw">;
  def URADDW    : XxldspRR<0b0011000, 0b001, "uraddw">;
  def RSUBW     : XxldspRR<0b0010001, 0b001, "rsubw">;
  def URSUBW    : XxldspRR<0b0011001, 0b001, "ursubw">;
  def MAXW      : XxldspRR<0b1111001, 0b000, "maxw">;
  def MINW      : XxldspRR<0b1111000, 0b000, "minw">;
  def MULR64    : XxldspRR<0b1111000, 0b001, "mulr64">;
  def MULSR64   : XxldspRR<0b1110000, 0b001, "mulsr64">;
  def AVE       : XxldspRR<0b1110000, 0b000, "ave">;
  def SRA_U     : XxldspRR<0b0010010, 0b001, "sra.u">;
  def BITREV    : XxldspRR<0b1110011, 0b000, "bitrev">;
  def WEXT      : XxldspRR<0b1100111, 0b000, "wext">;
  def MADDR32   : XxldspRR<0b1100010, 0b001, "maddr32">;
  def MSUBR32   : XxldspRR<0b1100011, 0b001, "msubr32">;

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
  def expd80    : XxldspR<0b0010010, 0b00000, 0b111, "expd80">;
  def expd81    : XxldspR<0b0010010, 0b00001, 0b111, "expd81">;
  def expd82    : XxldspR<0b0010010, 0b00010, 0b111, "expd82">;
  def expd83    : XxldspR<0b0010010, 0b00011, 0b111, "expd83">;
  def expd84    : XxldspR<0b0010010, 0b00100, 0b111, "expd84">;
  def expd85    : XxldspR<0b0010010, 0b00101, 0b111, "expd85">;
  def expd86    : XxldspR<0b0010010, 0b00110, 0b111, "expd86">;
  def expd87    : XxldspR<0b0010010, 0b00111, 0b111, "expd87">;

  def SRAI8     : XxldspR_i3<0b0111100, 0b00, 0b000, "srai8">;
  def SRAI8_U   : XxldspR_i3<0b0111100, 0b01, 0b000, "srai8.u">;
  def SRLI8     : XxldspR_i3<0b0111101, 0b00, 0b000, "srli8">;
  def SRLI8_U   : XxldspR_i3<0b0111101, 0b01, 0b000, "srli8.u">;
  def SLLI8     : XxldspR_i3<0b0111110, 0b00, 0b000, "slli8">;
  def KSLLI8    : XxldspR_i3<0b0111110, 0b01, 0b000, "kslli8">;
  def SCLIP8    : XxldspR_i3<0b1000110, 0b00, 0b000, "sclip8">;
  def UCLIP8    : XxldspR_i3<0b1000110, 0b10, 0b000, "uclip8">;
  def INSB      : XxldspR_i3<0b1010110, 0b00, 0b000, "insb">;

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
  def WEXTI     : XxldspR_i5<0b1101111, 0b000, "wexti">;

  def SRAI_U    : XxldspR_i6<0b110101, 0b001, "srai.u">;
  def BITREVI   : XxldspR_i6<0b111010, 0b000, "bitrevi">;

  def BPICK     : XxldspR4<0b00, 0b011, "bpick">;
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
  def KDMABB16  : XxldspRR<0b1101100, 0b001, "kdmabb16">;
  def KDMABT16  : XxldspRR<0b1110100, 0b001, "kdmabt16">;
  def KDMATT16  : XxldspRR<0b1111100, 0b001, "kdmatt16">;
  def SMBT32    : XxldspRR<0b0001100, 0b010, "smbt32">;
  def SMTT32    : XxldspRR<0b0010100, 0b010, "smtt32">;
  def KMABB32   : XxldspRR<0b0101101, 0b010, "kmabb32">;
  def KMABT32   : XxldspRR<0b0110101, 0b010, "kmabt32">;
  def KMATT32   : XxldspRR<0b0111101, 0b010, "kmatt32">;
  def KMDA32    : XxldspRR<0b0011100, 0b010, "kmda32">;
  def KMXDA32   : XxldspRR<0b0011101, 0b010, "kmxda32">;
  def KMAXDA32  : XxldspRR<0b0100101, 0b010, "kmaxda32">;
  def KMADS32   : XxldspRR<0b0101110, 0b010, "kmads32">;
  def KMADRS32  : XxldspRR<0b0110110, 0b010, "kmadrs32">;
  def KMAXDS32  : XxldspRR<0b0111110, 0b010, "kmaxds32">;
  def KMSDA32   : XxldspRR<0b0100110, 0b010, "kmsda32">;
  def KMSXDA32  : XxldspRR<0b0100111, 0b010, "kmsxda32">;
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

let Predicates = [HasVendorXxldspn1x], DecoderNamespace = "Xxldspn1x",
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def DKHM8     : XxldspRR<0b1000111, 0b111, "dkhm8">;
  def DKHM16    : XxldspRR<0b1000011, 0b111, "dkhm16">;
  def DKSLRA8   : XxldspRR<0b0101111, 0b111, "dkslra8">;
  def DKSLRA16  : XxldspRR<0b0101011, 0b111, "dkslra16">;
  def DKADD8    : XxldspRR<0b0001100, 0b111, "dkadd8">;
  def DKADD16   : XxldspRR<0b0001000, 0b111, "dkadd16">;
  def DKSUB8    : XxldspRR<0b0001101, 0b111, "dksub8">;
  def DKSUB16   : XxldspRR<0b0001001, 0b111, "dksub16">;

  def DKABS8    : XxldspR<0b1010110, 0b10000, 0b111, "dkabs8">;
  def DKABS16   : XxldspR<0b1010110, 0b10001, 0b111, "dkabs16">;
}

let Predicates = [HasVendorXxldspn2x], DecoderNamespace = "Xxldspn2x",
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def DKHMX8         : XxldspRR_cust3<0b0000000, 0b000, "dkhmx8">;
  def DKHMX16        : XxldspRR_cust3<0b0000001, 0b000, "dkhmx16">;
  def DSMMUL         : XxldspRR_cust3<0b0000010, 0b000, "dsmmul">;
  def DSMMUL_U       : XxldspRR_cust3<0b0000011, 0b000, "dsmmul.u">;
  def DKWMMUL        : XxldspRR_cust3<0b0000100, 0b000, "dkwmmul">;
  def DKWMMUL_U      : XxldspRR_cust3<0b0000101, 0b000, "dkwmmul.u">;
  def DKSLRA32       : XxldspRR_cust3<0b0000111, 0b000, "dkslra32">;
  def DKADD32        : XxldspRR_cust3<0b0001000, 0b000, "dkadd32">;
  def DKSUB32        : XxldspRR_cust3<0b0001001, 0b000, "dksub32">;
  def DRADD16        : XxldspRR_cust3<0b0101110, 0b000, "dradd16">;
  def DSUB16         : XxldspRR_cust3<0b0101111, 0b000, "dsub16">;
  def DRADD32        : XxldspRR_cust3<0b0110000, 0b000, "dradd32">;
  def DSUB32         : XxldspRR_cust3<0b0110001, 0b000, "dsub32">;
  def DKMDA          : XxldspRR_cust3<0b0110010, 0b000, "dkmda">;
  def DKMXDA         : XxldspRR_cust3<0b0110011, 0b000, "dkmxda">;
  def DSMDRS         : XxldspRR_cust3<0b0110100, 0b000, "dsmdrs">;
  def DSMXDS         : XxldspRR_cust3<0b0110101, 0b000, "dsmxds">;
  def DSMBB32        : XxldspRR_cust3<0b0110110, 0b000, "dsmbb32">;
  def DSMBB32_SRA14  : XxldspRR_cust3<0b0110111, 0b000, "dsmbb32.sra14">;
  def DSMBB32_SRA32  : XxldspRR_cust3<0b0111000, 0b000, "dsmbb32.sra32">;
  def DSMBT32        : XxldspRR_cust3<0b0111001, 0b000, "dsmbt32">;
  def DSMBT32_SRA14  : XxldspRR_cust3<0b0111010, 0b000, "dsmbt32.sra14">;
  def DSMBT32_SRA32  : XxldspRR_cust3<0b0111011, 0b000, "dsmbt32.sra32">;
  def DSMTT32        : XxldspRR_cust3<0b0111100, 0b000, "dsmtt32">;
  def DSMTT32_SRA14  : XxldspRR_cust3<0b0111101, 0b000, "dsmtt32.sra14">;
  def DSMTT32_SRA32  : XxldspRR_cust3<0b0111110, 0b000, "dsmtt32.sra32">;
  def DPKBB32        : XxldspRR_cust3<0b0111111, 0b000, "dpkbb32">;
  def DPKBT32        : XxldspRR_cust3<0b1000000, 0b000, "dpkbt32">;
  def DPACK32        : XxldspRR_cust3<0b1100110, 0b000, "dpack32">;
  def DPKTT32        : XxldspRR_cust3<0b1000001, 0b000, "dpktt32">;
  def DPKTB32        : XxldspRR_cust3<0b1000010, 0b000, "dpktb32">;
  def DPKTB16        : XxldspRR_cust3<0b1000011, 0b000, "dpktb16">;
  def DPKBB16        : XxldspRR_cust3<0b1000100, 0b000, "dpkbb16">;
  def DPKBT16        : XxldspRR_cust3<0b1000101, 0b000, "dpkbt16">;
  def DPKTT16        : XxldspRR_cust3<0b1000110, 0b000, "dpktt16">;
  def DSRA16         : XxldspRR_cust3<0b1000111, 0b000, "dsra16">;
  def DADD16         : XxldspRR_cust3<0b1001000, 0b000, "dadd16">;
  def DADD32         : XxldspRR_cust3<0b1001001, 0b000, "dadd32">;
  def DSMBB16        : XxldspRR_cust3<0b1001010, 0b000, "dsmbb16">;
  def DSMBT16        : XxldspRR_cust3<0b1001011, 0b000, "dsmbt16">;
  def DSMTT16        : XxldspRR_cust3<0b1001100, 0b000, "dsmtt16">;
  def DRCRSA16       : XxldspRR_cust3<0b1001101, 0b000, "drcrsa16">;
  def DRCRAS16       : XxldspRR_cust3<0b1001110, 0b000, "drcras16">;
  def DKCRSA16       : XxldspRR_cust3<0b1001111, 0b000, "dkcrsa16">;
  def DKCRAS16       : XxldspRR_cust3<0b1010000, 0b000, "dkcras16">;
  def DRSUB16        : XxldspRR_cust3<0b1010001, 0b000, "drsub16">;
  def DRSUB32        : XxldspRR_cust3<0b1010010, 0b000, "drsub32">;
  def DSTSA32        : XxldspRR_cust3<0b1010011, 0b000, "dstsa32">;
  def DSTAS32        : XxldspRR_cust3<0b1010100, 0b000, "dstas32">;
  def DKCRAS32       : XxldspRR_cust3<0b1010101, 0b000, "dkcras32">;
  def DKCRSA32       : XxldspRR_cust3<0b1010110, 0b000, "dkcrsa32">;
  def DCRSA32        : XxldspRR_cust3<0b1010111, 0b000, "dcrsa32">;
  def DCRAS32        : XxldspRR_cust3<0b1011000, 0b000, "dcras32">;
  def DKSTSA16       : XxldspRR_cust3<0b1011001, 0b000, "dkstsa16">;
  def DKSTAS16       : XxldspRR_cust3<0b1011010, 0b000, "dkstas16">;
  def DRCRSA32       : XxldspRR_cust3<0b1011110, 0b000, "drcrsa32">;
  def DRCRAS32       : XxldspRR_cust3<0b1110010, 0b000, "drcras32">;
  def DMSR16         : XxldspRR_cust3<0b1011111, 0b000, "dmsr16">;
  def DMSR17         : XxldspRR_cust3<0b1100000, 0b000, "dmsr17">;
  def DMSR33         : XxldspRR_cust3<0b1100001, 0b000, "dmsr33">;
  def DMXSR33        : XxldspRR_cust3<0b1110011, 0b000, "dmxsr33">;

  def DSCLIP8        : XxldspR_i5_cust3<0b1011011, 0b000, "dsclip8">;
  def DSCLIP16       : XxldspR_i5_cust3<0b1011100, 0b000, "dsclip16">;
  def DSCLIP32       : XxldspR_i5_cust3<0b1011101, 0b000, "dsclip32">;

  def dkclip64       : XxldspR_cust3<0b0000110, 0b00001, 0b000, "dkclip64">;
  def dredas16       : XxldspR_cust3<0b0000110, 0b00010, 0b000, "dredas16">;
  def dredsa16       : XxldspR_cust3<0b0000110, 0b00011, 0b000, "dredsa16">;
  def dsunpkd810     : XxldspR_cust3<0b0000110, 0b00100, 0b000, "dsunpkd810">;
  def dsunpkd820     : XxldspR_cust3<0b0000110, 0b00101, 0b000, "dsunpkd820">;
  def dsunpkd830     : XxldspR_cust3<0b0000110, 0b00110, 0b000, "dsunpkd830">;
  def dsunpkd831     : XxldspR_cust3<0b0000110, 0b00111, 0b000, "dsunpkd831">;
  def dsunpkd832     : XxldspR_cust3<0b0000110, 0b01000, 0b000, "dsunpkd832">;
  def dzunpkd810     : XxldspR_cust3<0b0000110, 0b01001, 0b000, "dzunpkd810">;
  def dzunpkd820     : XxldspR_cust3<0b0000110, 0b01010, 0b000, "dzunpkd820">;
  def dzunpkd830     : XxldspR_cust3<0b0000110, 0b01011, 0b000, "dzunpkd830">;
  def dzunpkd831     : XxldspR_cust3<0b0000110, 0b01100, 0b000, "dzunpkd831">;
  def dzunpkd832     : XxldspR_cust3<0b0000110, 0b01101, 0b000, "dzunpkd832">;
}

let Predicates = [HasVendorXxldspn3x], DecoderNamespace = "Xxldspn3x",
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def DKMMAC      : XxldspRR_cust3<0b0001010, 0b000, "dkmmac">;
  def DKMMAC_U    : XxldspRR_cust3<0b0001011, 0b000, "dkmmac.u">;
  def DKMMSB      : XxldspRR_cust3<0b0001100, 0b000, "dkmmsb">;
  def DKMMSB_U    : XxldspRR_cust3<0b0001101, 0b000, "dkmmsb.u">;
  def DKMADA      : XxldspRR_cust3<0b0001110, 0b000, "dkmada">;
  def DKMAXDA     : XxldspRR_cust3<0b0001111, 0b000, "dkmaxda">;
  def DKMADS      : XxldspRR_cust3<0b0010000, 0b000, "dkmads">;
  def DKMADRS     : XxldspRR_cust3<0b0010001, 0b000, "dkmadrs">;
  def DKMAXDS     : XxldspRR_cust3<0b0010010, 0b000, "dkmaxds">;
  def DKMSDA      : XxldspRR_cust3<0b0010011, 0b000, "dkmsda">;
  def DKMSXDA     : XxldspRR_cust3<0b0010100, 0b000, "dkmsxda">;
  def DSMAQA      : XxldspRR_cust3<0b0010101, 0b000, "dsmaqa">;
  def DSMAQA_SU   : XxldspRR_cust3<0b0010110, 0b000, "dsmaqa.su">;
  def DUMAQA      : XxldspRR_cust3<0b0010111, 0b000, "dumaqa">;
  def DKMDA32     : XxldspRR_cust3<0b0011000, 0b000, "dkmda32">;
  def DKMXDA32    : XxldspRR_cust3<0b0011001, 0b000, "dkmxda32">;
  def DKMADA32    : XxldspRR_cust3<0b0011010, 0b000, "dkmada32">;
  def DKMAXDA32   : XxldspRR_cust3<0b0011011, 0b000, "dkmaxda32">;
  def DKMADS32    : XxldspRR_cust3<0b0011100, 0b000, "dkmads32">;
  def DKMADRS32   : XxldspRR_cust3<0b0011101, 0b000, "dkmadrs32">;
  def DKMAXDS32   : XxldspRR_cust3<0b0011110, 0b000, "dkmaxds32">;
  def DKMSDA32    : XxldspRR_cust3<0b0011111, 0b000, "dkmsda32">;
  def DKMSXDA32   : XxldspRR_cust3<0b0100000, 0b000, "dkmsxda32">;
  def DSMDS32     : XxldspRR_cust3<0b0100001, 0b000, "dsmds32">;
  def DSMDRS32    : XxldspRR_cust3<0b0100010, 0b000, "dsmdrs32">;
  def DSMXDS32    : XxldspRR_cust3<0b0100011, 0b000, "dsmxds32">;
  def DSMALDA     : XxldspRR_cust3<0b0100100, 0b000, "dsmalda">;
  def DSMALXDA    : XxldspRR_cust3<0b0100101, 0b000, "dsmalxda">;
  def DSMALDS     : XxldspRR_cust3<0b0100110, 0b000, "dsmalds">;
  def DSMALDRS    : XxldspRR_cust3<0b0100111, 0b000, "dsmaldrs">;
  def DSMALXDS    : XxldspRR_cust3<0b0101000, 0b000, "dsmalxds">;
  def DSMSLDA     : XxldspRR_cust3<0b0101001, 0b000, "dsmslda">;
  def DSMSLXDA    : XxldspRR_cust3<0b0101010, 0b000, "dsmslxda">;
  def DDSMAQA     : XxldspRR_cust3<0b0101011, 0b000, "ddsmaqa">;
  def DDSMAQA_SU  : XxldspRR_cust3<0b0101100, 0b000, "ddsmaqa.su">;
  def DDUMAQA     : XxldspRR_cust3<0b0101101, 0b000, "ddumaqa">;
  def DSMADA16    : XxldspRR_cust3<0b1100010, 0b000, "dsmada16">;
  def DSMAXDA16   : XxldspRR_cust3<0b1100011, 0b000, "dsmaxda16">;
  def DKSMS32_U   : XxldspRR_cust3<0b1100100, 0b000, "dksms32.u">;
  def DMADA32     : XxldspRR_cust3<0b1100101, 0b000, "dmada32">;
  def DSMA32_U    : XxldspRR_cust3<0b1101000, 0b000, "dsma32_u">;
  def DSMXS32_U   : XxldspRR_cust3<0b1101001, 0b000, "dsmxs32.u">;
  def DSMXA32_U   : XxldspRR_cust3<0b1101010, 0b000, "dsmxa32.u">;
  def DSMS32_U    : XxldspRR_cust3<0b1101011, 0b000, "dsms32.u">;
  def DSMALBB     : XxldspRR_cust3<0b1101100, 0b000, "dsmalbb">;
  def DSMALBT     : XxldspRR_cust3<0b1101101, 0b000, "dsmalbt">;
  def DSMALTT     : XxldspRR_cust3<0b1101110, 0b000, "dsmaltt">;
  def DKMABB32    : XxldspRR_cust3<0b1101111, 0b000, "dkmabb32">;
  def DKMABT32    : XxldspRR_cust3<0b1110000, 0b000, "dkmabt32">;
  def DKMATT32    : XxldspRR_cust3<0b1110001, 0b000, "dkmatt32">;
}
