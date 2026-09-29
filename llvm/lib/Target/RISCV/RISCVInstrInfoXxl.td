//===-- RISCVInstrInfoEclic.td - 'eclic v2' instructions -----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the RISC-V instructions from the Nuclei eclic v2
// This version is still experimental hasn't been ratified yet.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//


// Nuclei eclic V2 popxret instruction
let hasSideEffects = 1, mayLoad = 0, mayStore = 0 in {
def POPXRET : RVInst<(outs), (ins uimm5:$zimm),
                      "popxret", "${zimm}",[],InstFormatI>,Sched<[]> {
  bits<5> zimm;
  let Inst{31-20} = 0x94c;
  let Inst{19-15} = zimm;
  let Inst{14-12} = 0x5;
  let Inst{11-7}  = 0x0;
  let Inst{6-0}   = 0x73;
}
}