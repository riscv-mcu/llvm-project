//===-- RISCVInstrInfoXxlcz.td -----------------------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the Nuclei Custom Xxlcz extensions defined by Nuclei.
//
//===----------------------------------------------------------------------===//


let DecoderNamespace = "Xxlczbitop" in {
  class XxlczBitopRR<bits<7> funct7, bits<3> funct3, string opcodestr>
      : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd),
                (ins GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2">;

  class XxlczBitopRII<bits<2> funct2, bits<3> funct3, string opcodestr>
      : RVInstIBase<funct3, OPC_CUSTOM_3, (outs GPR:$rd),
                (ins GPR:$rs1, uimm5:$is3, uimm5:$is2),
                opcodestr, "$rd, $rs1, $is3, $is2"> {
    bits<5> is3;
    bits<5> is2;
    let Inst{31-30} = funct2;
    let Inst{29-25} = is3;
    let Inst{24-20} = is2;
  }

  class XxlczBitopR<bits<7> funct7, bits<3> funct3, string opcodestr>
      : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd), (ins GPR:$rs1),
                opcodestr, "$rd, $rs1"> {
     let rs2 = 0b00000;
  }
}

let Predicates = [HasVendorXxlczbitop, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def XL_EXTRACT  : XxlczBitopRII<0b00, 0b101, "xl.extract">;
  def XL_EXTRACTU : XxlczBitopRII<0b10, 0b101, "xl.extractu">;
  def XL_INSERT   : XxlczBitopRII<0b00, 0b110, "xl.insert">;
  def XL_BSET     : XxlczBitopRII<0b10, 0b110, "xl.bset">;
  def XL_BCLR     : XxlczBitopRII<0b00, 0b111, "xl.bclr">;

  def XL_EXTRACTR  : XxlczBitopRR<0b0100000, 0b101, "xl.extractr">;
  def XL_EXTRACTUR : XxlczBitopRR<0b1100000, 0b101, "xl.extractur">;
  def XL_BSETR     : XxlczBitopRR<0b1100000, 0b110, "xl.bsetr">;
  def XL_BCLRR     : XxlczBitopRR<0b0100000, 0b111, "xl.bclrr">;

  def XL_CLB : XxlczBitopR<0b1110101, 0b001, "xl.clb">;
  def XL_FL1 : XxlczBitopR<0b1110110, 0b001, "xl.fl1">;
  def XL_FF1 : XxlczBitopR<0b1110111, 0b001, "xl.ff1">;
  def XL_FL0 : XxlczBitopR<0b1111000, 0b001, "xl.fl0">;
  def XL_FF0 : XxlczBitopR<0b1111001, 0b001, "xl.ff0">;
}

def xl_mac_imm : Operand<XLenVT>, ImmLeaf<XLenVT, [{return isInt<9>(Imm);}]>;

class XxlczMac<bits<3> funct_xl_mac, bits<3> funct3, dag outs, dag ins,
              string opcodestr, string argstr>
  : RVInst<outs, ins, opcodestr, argstr, [], InstFormatOther> {
  bits<5> rd;
  bits<5> rs1;
  bits<9> imm9;

  let Inst{31-29} = funct_xl_mac;
  let Inst{28-20} = imm9;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = rd;
  let Inst{6-0} = OPC_CUSTOM_3.Value;
  let DecoderNamespace = "Xxlczmac";
}

let Predicates = [HasVendorXxlczmac, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def XL_MULI : XxlczMac<0b110, 0b001,
                (outs GPR:$rd), (ins GPR:$rs1, xl_mac_imm:$imm9),
                "xl.muli", "$rd, $rs1, $imm9">;
}

class XxlczSletRR<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd),
              (ins GPR:$rs1, GPR:$rs2), opcodestr, "$rd, $rs1, $rs2"> {
  let DecoderNamespace = "Xxlczslet";
}

let Predicates = [HasVendorXxlczslet, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def XL_SLET  : XxlczSletRR<0b1110011, 0b001, "xl.slet">;
  def XL_SLETU : XxlczSletRR<0b1110100, 0b001, "xl.sletu">;
}

let DecoderNamespace = "Xxlczbmrk" in {
  class XxlczBmrkB<bit F, bits<3> funct3, string opcodestr>
    : RVInst<(outs), (ins GPR:$rs1, GPR:$rs2, simm12_lsb0:$imm11), 
              opcodestr, "$rs1, $rs2, $imm11", [], InstFormatXLBmrk> {
    bits<5> rs1;
    bits<5> rs2;
    bits<11> imm11;

    let Inst{31} = F;
    let Inst{30-25} = imm11{9-4};
    let Inst{24-20} = rs2;
    let Inst{19-15} = rs1;
    let Inst{14-12} = funct3;
    let Inst{11-8} = imm11{3-0};
    let Inst{7} = imm11{10};
    let Inst{6-0} = OPC_CUSTOM_3.Value;

    let isBranch = 1;
    let isTerminator = 1;
  }

  class XxlczBmrkR<bits<7> funct7, bits<3> funct3, string opcodestr>
      : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs GPR:$rd), (ins GPR:$rs1),
                opcodestr, "$rd, $rs1"> {
     let rs2 = 0b00000;
  }
}

let Predicates = [HasVendorXxlczbmrk, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def XL_ADDRCHK  : XxlczBmrkB<0b0, 0b011, "xl.addrchk">;
  def XL_BEZM     : XxlczBmrkB<0b1, 0b011, "xl.bezm">;

  def XL_NZMSK : XxlczBmrkR<0b1110000, 0b001, "xl.nzmsk">;
  def XL_FFNZ  : XxlczBmrkR<0b1110001, 0b001, "xl.ffnz">;
}

def uimm10_lsb0 : RISCVOp,
                 ImmLeaf<XLenVT, [{return isShiftedUInt<9, 1>(Imm);}]> {
  let ParserMatchClass = UImmAsmOperand<10, "Lsb0">;
  let EncoderMethod = "getImmOpValue";
  let DecoderMethod = "decodeUImmOperand<10>";
  let OperandType = "OPERAND_UIMM10_LSB0";
  let MCOperandPredicate = [{
    int64_t Imm;
    if (!MCOp.evaluateAsConstantImm(Imm))
      return false;
    return isShiftedUInt<9, 1>(Imm);
  }];
}

let DecoderNamespace = "Xxlczbri" in {
  class XxlczBriI<bits<3> funct3, dag outs, dag ins,
                  string opcodestr, string argstr>
      : RVInstB<funct3, OPC_CUSTOM_3, outs, ins, opcodestr, argstr> {
    bits<5> imm5;
    let rs2 = imm5;
  }

  class XxlczAddiBne<bit funct1, bits<3> funct3, dag outs, dag ins,
                    string opcodestr, string argstr>
      : RVInstIBase<funct3, OPC_CUSTOM_3, outs, ins, opcodestr, argstr> {
    bits<2> scale;
    bits<9> imm9_1;

    let Inst{31} = funct1;
    let Inst{30-29} = scale;
    let Inst{28-20} = imm9_1;
  }
}

let Predicates = [HasVendorXxlczbri, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 0,
    isBranch = 1, isTerminator = 1 in {
  def XL_BEQI : XxlczBriI<0b010, (outs),
        (ins GPR:$rs1, simm5:$imm5, simm13_lsb0:$imm12),
        "xl.beqi", "$rs1, $imm5, $imm12">, Sched<[]>;
  def XL_BNEI : XxlczBriI<0b100, (outs),
        (ins GPR:$rs1, simm5:$imm5, simm13_lsb0:$imm12),
        "xl.bnei", "$rs1, $imm5, $imm12">, Sched<[]>;

  def XL_ADDIBNE : XxlczAddiBne<0b1, 0b111, (outs GPR:$rd),
        (ins GPR:$rs1, uimm2:$scale, uimm10_lsb0:$imm9_1),
        "xl.addibne", "$rd, $rs1, $scale, $imm9_1">, Sched<[]>;
}

class XxlczBitrev<bits<5> funct5, bits<3> funct3, dag outs, dag ins,
              string opcodestr, string argstr>
  : RVInstIBase<funct3, OPC_CUSTOM_3, outs, ins, opcodestr, argstr> {
  bits<2> is3;
  bits<5> is2;

  let Inst{31-27} = funct5;
  let Inst{26-25} = is3;
  let Inst{24-20} = is2;
  let DecoderNamespace = "Xxlczbitrev";
}

let Predicates = [HasVendorXxlczbitrev, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 0 in {
  def XL_BITREV : XxlczBitrev<0b10110, 0b001, (outs GPR:$rd),
                  (ins GPR:$rs1, uimm2:$is3, uimm5:$is2),
                  "xl.bitrev", "$rd, $rs1, $is3, $is2">;
}

def xl_pstinc_imm8 : Operand<XLenVT>, ImmLeaf<XLenVT, 
                    [{return isInt<8>(Imm);}]>;
def xl_pstinc_imm9_lsb0 : Operand<XLenVT>, ImmLeaf<XLenVT, 
                    [{return isShiftedInt<8, 1>(Imm);}]>;
def xl_pstinc_imm10_lsb00 : Operand<XLenVT>, ImmLeaf<XLenVT, 
                    [{return isShiftedInt<8, 2>(Imm);}]>;
def xl_pstinc_imm11_lsb000 : Operand<XLenVT>, ImmLeaf<XLenVT, 
                    [{return isShiftedInt<8, 3>(Imm);}]>;

let DecoderNamespace = "Xxlczpstinc", Constraints = "$rs1_wb = $rs1" in {
  class XxlczPstinc_load<bits<4> funct4, string opcodestr, dag ins>
      : RVInstIBase<0b001, OPC_CUSTOM_3, (outs GPR:$rd, GPR:$rs1_wb),
                    ins, opcodestr, "$rd, ${imm}(${rs1})"> {
    let Inst{31-28} = funct4;
  }

  class XxlczPstinc_store<bits<4> funct4, string opcodestr, dag ins>
      : RVInst<(outs GPR:$rs1_wb), ins, opcodestr,
                "$rs2, ${imm}(${rs1})", [], InstFormatOther> {
    bits<5> rs2;
    bits<5> rs1;

    let Inst{31-28} = funct4;
    let Inst{24-20} = rs2;
    let Inst{19-15} = rs1;
    let Inst{14-12} = 0b001;
    let Inst{6-0} = OPC_CUSTOM_3.Value;
  }

  class XxlczPstinc_load_F<bits<4> funct4, string opcodestr,
                           RegisterClass cls, dag ins>
      : RVInstIBase<0b101, OPC_CUSTOM_3, (outs cls:$rd, GPR:$rs1_wb),
                    ins, opcodestr, "$rd, ${imm}(${rs1})"> {
    let Inst{31-28} = funct4;
  }

  class XxlczPstinc_store_F<bits<4> funct4, string opcodestr, dag ins>
      : RVInst<(outs GPR:$rs1_wb), ins, opcodestr,
                "$rs2, ${imm}(${rs1})", [], InstFormatOther> {
    bits<5> rs2;
    bits<5> rs1;

    let Inst{31-28} = funct4;
    let Inst{24-20} = rs2;
    let Inst{19-15} = rs1;
    let Inst{14-12} = 0b101;
    let Inst{6-0} = OPC_CUSTOM_3.Value;
  }
}

let Predicates = [HasVendorXxlczpstinc, IsRV32],
    hasSideEffects = 0, mayLoad = 1, mayStore = 0 in {
  def XL_LB   : XxlczPstinc_load<0b0000, "xl.lb",
                (ins GPRMem:$rs1, xl_pstinc_imm8:$imm)> {
    bits<8> imm;
    let Inst{27-20} = imm{7-0};
    }
  def XL_LBU  : XxlczPstinc_load<0b0001, "xl.lbu",
                (ins GPRMem:$rs1, xl_pstinc_imm8:$imm)> {
    bits<8> imm;
    let Inst{27-20} = imm{7-0};
    }
  def XL_LH   : XxlczPstinc_load<0b0010, "xl.lh",
                (ins GPRMem:$rs1, xl_pstinc_imm9_lsb0:$imm)> {
    bits<9> imm;
    let Inst{27-20} = imm{8-1};
    }
  def XL_LHU  : XxlczPstinc_load<0b0011, "xl.lhu",
                (ins GPRMem:$rs1, xl_pstinc_imm9_lsb0:$imm)> {
    bits<9> imm;
    let Inst{27-20} = imm{8-1};
    }
  def XL_LW   : XxlczPstinc_load<0b0100, "xl.lw",
                (ins GPRMem:$rs1, xl_pstinc_imm10_lsb00:$imm)> {
    bits<10> imm;
    let Inst{27-20} = imm{9-2};
    }
}

let Predicates = [HasVendorXxlczpstinc, IsRV64],
    hasSideEffects = 0, mayLoad = 1, mayStore = 0 in {
  def XL_LWU  : XxlczPstinc_load<0b1000, "xl.lwu",
                (ins GPRMem:$rs1, xl_pstinc_imm10_lsb00:$imm)> {
    bits<10> imm;
    let Inst{27-20} = imm{9-2};
    }
  def XL_LD  : XxlczPstinc_load<0b1001, "xl.ld",
                (ins GPRMem:$rs1, xl_pstinc_imm11_lsb000:$imm)> {
    bits<11> imm;
    let Inst{27-20} = imm{10-3};
    }
}

let Predicates = [HasVendorXxlczpstinc, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 1 in {
  def XL_SB   : XxlczPstinc_store<0b0101, "xl.sb",
                (ins GPRMem:$rs1, GPR:$rs2, xl_pstinc_imm8:$imm)> {
    bits<8> imm;
    let Inst{27-25} = imm{7-5};
    let Inst{11-7} = imm{4-0};
    }
  def XL_SH   : XxlczPstinc_store<0b0110, "xl.sh",
                (ins GPRMem:$rs1, GPR:$rs2, xl_pstinc_imm9_lsb0:$imm)> {
    bits<9> imm;
    let Inst{27-25} = imm{8-6};
    let Inst{11-7} = imm{5-1};
    }
  def XL_SW   : XxlczPstinc_store<0b0111, "xl.sw",
                (ins GPRMem:$rs1, GPR:$rs2, xl_pstinc_imm10_lsb00:$imm)> {
    bits<10> imm;
    let Inst{27-25} = imm{9-7};
    let Inst{11-7} = imm{6-2};
    }
}

let Predicates = [HasVendorXxlczpstinc, IsRV64],
    hasSideEffects = 0, mayLoad = 0, mayStore = 1 in {
  def XL_SD  : XxlczPstinc_store<0b1010, "xl.sd",
                (ins GPRMem:$rs1, GPR:$rs2, xl_pstinc_imm11_lsb000:$imm)> {
    bits<11> imm;
    let Inst{27-25} = imm{10-8};
    let Inst{11-7} = imm{7-3};
    }
}

let Predicates = [HasVendorXxlczpstinc, HasStdExtF, IsRV32],
    hasSideEffects = 0, mayLoad = 1, mayStore = 0 in {
  def XL_FLH   : XxlczPstinc_load_F<0b0101, "xl.flh", FPR32,
                (ins GPRMem:$rs1, xl_pstinc_imm9_lsb0:$imm)> {
    bits<9> imm;
    let Inst{27-20} = imm{8-1};
    }
  def XL_FLW   : XxlczPstinc_load_F<0b0110, "xl.flw", FPR32,
                (ins GPRMem:$rs1, xl_pstinc_imm10_lsb00:$imm)> {
    bits<10> imm;
    let Inst{27-20} = imm{9-2};
    }
}

let Predicates = [HasVendorXxlczpstinc, HasStdExtD, IsRV64],
    hasSideEffects = 0, mayLoad = 1, mayStore = 0 in {
  def XL_FLD  : XxlczPstinc_load_F<0b0111, "xl.fld", FPR64,
                (ins GPRMem:$rs1, xl_pstinc_imm11_lsb000:$imm)> {
    bits<11> imm;
    let Inst{27-20} = imm{10-3};
    }
}

let Predicates = [HasVendorXxlczpstinc, HasStdExtF, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 1 in {
  def XL_FSH   : XxlczPstinc_store_F<0b1101, "xl.fsh",
                (ins GPRMem:$rs1, FPR32:$rs2, xl_pstinc_imm9_lsb0:$imm)> {
    bits<9> imm;
    let Inst{27-25} = imm{8-6};
    let Inst{11-7} = imm{5-1};
    }
  def XL_FSW   : XxlczPstinc_store_F<0b1110, "xl.fsw",
                (ins GPRMem:$rs1, FPR32:$rs2, xl_pstinc_imm10_lsb00:$imm)> {
    bits<10> imm;
    let Inst{27-25} = imm{9-7};
    let Inst{11-7} = imm{6-2};
    }
}

let Predicates = [HasVendorXxlczpstinc, HasStdExtD, IsRV64],
    hasSideEffects = 0, mayLoad = 0, mayStore = 1 in {
  def XL_FSD  : XxlczPstinc_store_F<0b1111, "xl.fsd",
                (ins GPRMem:$rs1, FPR64:$rs2, xl_pstinc_imm11_lsb000:$imm)> {
    bits<11> imm;
    let Inst{27-25} = imm{10-8};
    let Inst{11-7} = imm{7-3};
    }
}


def xl_gp_imm16 : Operand<XLenVT>, ImmLeaf<XLenVT, 
                    [{return isInt<16>(Imm);}]>;
def xl_gp_imm16_lsb0 : Operand<XLenVT>, ImmLeaf<XLenVT, 
                    [{return isShiftedInt<15, 1>(Imm);}]>;
def xl_gp_imm17_lsb00 : Operand<XLenVT>, ImmLeaf<XLenVT, 
                    [{return isShiftedInt<15, 2>(Imm);}]>;
def xl_gp_imm18_lsb000 : Operand<XLenVT>, ImmLeaf<XLenVT, 
                    [{return isShiftedInt<15, 3>(Imm);}]>;

let DecoderNamespace = "Xxlczgp" in {
  class Xxlczgp_load_16<bits<2> funct2_1, bits<2> funct2_0, string opcodestr>
    : RVInst<(outs GPR:$rd), (ins xl_gp_imm16:$imm), 
              opcodestr, "$rd, $imm", [], InstFormatOther> {
    bits<5> rd;
    bits<16> imm;

    let Inst{31-30} = funct2_1;
    let Inst{29-14} = imm;
    let Inst{13-12} = funct2_0;
    let Inst{11-7} = rd;
    let Inst{6-0} = OPC_CUSTOM_2.Value;
  }

  class Xxlczgp_load_15<bits<2> funct2, bits<3> funct3,
                       string opcodestr, dag ins>
    : RVInst<(outs GPR:$rd), ins, opcodestr, "$rd, $imm", [], InstFormatOther> {
    bits<5> rd;

    let Inst{31-30} = funct2;
    let Inst{14-12} = funct3;
    let Inst{11-7} = rd;
    let Inst{6-0} = OPC_CUSTOM_2.Value;
  }

  class Xxlczgp_store_16<bits<2> funct2_1, bits<2> funct2_0, string opcodestr>
    : RVInst<(outs), (ins GPR:$rs2, xl_gp_imm16:$imm), 
              opcodestr, "$rs2, $imm", [], InstFormatOther> {
    bits<5> rs2;
    bits<16> imm;

    let Inst{31-30} = funct2_1;
    let Inst{29-25} = imm{15-11};
    let Inst{24-20} = rs2;
    let Inst{19-14} = imm{10-5};
    let Inst{13-12} = funct2_0;
    let Inst{11-7} = imm{4-0};
    let Inst{6-0} = OPC_CUSTOM_2.Value;
  }

  class Xxlczgp_store_15<bits<2> funct2, bits<3> funct3,
                       string opcodestr, dag ins>
    : RVInst<(outs), ins, opcodestr, "$rs2, $imm", [], InstFormatOther> {
    bits<5> rs2;

    let Inst{31-30} = funct2;
    let Inst{24-20} = rs2;
    let Inst{14-12} = funct3;
    let Inst{6-0} = OPC_CUSTOM_2.Value;
  }
}

let Predicates = [HasVendorXxlczgp, IsRV32],
    hasSideEffects = 0, mayLoad = 1, mayStore = 0 in {
  def XL_LGP_B   : Xxlczgp_load_16<0b00, 0b00, "xl.lgp.b">;
  def XL_LGP_BU  : Xxlczgp_load_16<0b01, 0b00, "xl.lgp.bu">;

  def XL_LGP_H   : Xxlczgp_load_15<0b00, 0b001, "xl.lgp.h", 
                                  (ins xl_gp_imm16_lsb0:$imm)> {
    bits<16> imm;
    let Inst{29-15} = imm{15-1};
  }
  def XL_LGP_HU  : Xxlczgp_load_15<0b00, 0b101, "xl.lgp.hu", 
                                  (ins xl_gp_imm16_lsb0:$imm)> {
    bits<16> imm;
    let Inst{29-15} = imm{15-1};
  }
  def XL_LGP_W   : Xxlczgp_load_15<0b00, 0b010, "xl.lgp.w", 
                                  (ins xl_gp_imm17_lsb00:$imm)> {
    bits<17> imm;
    let Inst{29-15} = imm{16-2};
  }
}

let Predicates = [HasVendorXxlczgp, IsRV64],
    hasSideEffects = 0, mayLoad = 1, mayStore = 0 in {
  def XL_LGP_WU  : Xxlczgp_load_15<0b00, 0b110, "xl.lgp.wu", 
                                  (ins xl_gp_imm17_lsb00:$imm)> {
    bits<17> imm;
    let Inst{29-15} = imm{16-2};
  }
  def XL_LGP_D   : Xxlczgp_load_15<0b00, 0b011, "xl.lgp.d", 
                                  (ins xl_gp_imm18_lsb000:$imm)> {
    bits<18> imm;
    let Inst{29-15} = imm{17-3};
  }
}

let Predicates = [HasVendorXxlczpstinc, IsRV32],
    hasSideEffects = 0, mayLoad = 0, mayStore = 1 in {
  def XL_SGP_B   : Xxlczgp_store_16<0b11, 0b00, "xl.sgp.b">;
  def XL_SGP_H   : Xxlczgp_store_15<0b10, 0b001, "xl.sgp.h",
                  (ins GPR:$rs2, xl_gp_imm16_lsb0:$imm)> {
    bits<16> imm;
    let Inst{29-25} = imm{15-11};
    let Inst{19-15} = imm{10-6};
    let Inst{11-7} = imm{5-1};
  }
  def XL_SGP_W   : Xxlczgp_store_15<0b10, 0b010,"xl.sgp.w",
                  (ins GPR:$rs2, xl_gp_imm17_lsb00:$imm)> {
    bits<17> imm;
    let Inst{29-25} = imm{16-12};
    let Inst{19-15} = imm{11-7};
    let Inst{11-7} = imm{6-2};
  }
}

let Predicates = [HasVendorXxlczgp, IsRV64],
    hasSideEffects = 0, mayLoad = 0, mayStore = 1 in {
  def XL_SGP_D   : Xxlczgp_store_15<0b10, 0b011,"xl.sgp.d",
                  (ins GPR:$rs2, xl_gp_imm18_lsb000:$imm)> {
    bits<18> imm;
    let Inst{29-25} = imm{17-13};
    let Inst{19-15} = imm{12-8};
    let Inst{11-7} = imm{7-3};
  }
}
