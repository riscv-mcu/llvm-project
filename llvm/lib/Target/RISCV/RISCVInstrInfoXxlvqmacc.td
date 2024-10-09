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
class XxlvqmaccInstr<bits<7> funct7, bits<3> funct3, string opcodestr>
    : RVInstR<funct7, funct3, OPC_CUSTOM_3, (outs VR:$rd),
              (ins VR:$rs1, VR:$rs2), opcodestr, "$rd, $rs1, $rs2">;
}

let Predicates = [HasVendorXxlvqmacc], DecoderNamespace = "Xxlvqmacc" in {
  def VQMACCU  : XxlvqmaccInstr<0b1111010, 0b001, "xl.vqmaccu.vv">;
  def VQMACC   : XxlvqmaccInstr<0b1111011, 0b001, "xl.vqmacc.vv">;
  def VQMACCUS : XxlvqmaccInstr<0b1111100, 0b001, "xl.vqmaccus.vv">;
  def VQMACCSU : XxlvqmaccInstr<0b1111101, 0b001, "xl.vqmaccsu.vv">;
}

