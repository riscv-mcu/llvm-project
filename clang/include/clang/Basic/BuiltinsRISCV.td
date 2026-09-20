//==- BuiltinsRISCV.td - RISC-V Builtin function database ---*- tablegen -*-==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the RISC-V-specific builtin function database.
//
//===----------------------------------------------------------------------===//

include "clang/Basic/BuiltinsBase.td"

class RISCVBuiltin<string prototype, string features = ""> : TargetBuiltin {
  let Spellings = ["__builtin_riscv_" # NAME];
  let Prototype = prototype;
  let Features = features;
}

let Attributes = [NoThrow, Const] in {
//===----------------------------------------------------------------------===//
// Zbb extension.
//===----------------------------------------------------------------------===//
def orc_b_32 : RISCVBuiltin<"unsigned int(unsigned int)", "zbb">;
def orc_b_64 : RISCVBuiltin<"uint64_t(uint64_t)", "zbb,64bit">;
def clz_32 : RISCVBuiltin<"unsigned int(unsigned int)", "zbb|xtheadbb">;
def clz_64 : RISCVBuiltin<"unsigned int(uint64_t)", "zbb|xtheadbb,64bit">;
def ctz_32 : RISCVBuiltin<"unsigned int(unsigned int)", "zbb">;
def ctz_64 : RISCVBuiltin<"unsigned int(uint64_t)", "zbb,64bit">;

//===----------------------------------------------------------------------===//
// Zbc or Zbkc extension.
//===----------------------------------------------------------------------===//
def clmul_32 : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)", "zbc|zbkc">;
def clmul_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)", "zbc|zbkc,64bit">;
def clmulh_32 : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)", "zbc|zbkc,32bit">;
def clmulh_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)", "zbc|zbkc,64bit">;
def clmulr_32 : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)", "zbc,32bit">;
def clmulr_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)", "zbc,64bit">;

//===----------------------------------------------------------------------===//
// Zbkx extension.
//===----------------------------------------------------------------------===//
let Features = "zbkx,32bit" in {
def xperm4_32 : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xperm8_32 : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
} // Features = "zbkx,32bit"

let Features = "zbkx,64bit" in {
def xperm4_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xperm8_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
} // Features = "zbkx,64bit"

//===----------------------------------------------------------------------===//
// Zbkb extension.
//===----------------------------------------------------------------------===//
def brev8_32 : RISCVBuiltin<"unsigned int(unsigned int)", "zbkb">;
def brev8_64 : RISCVBuiltin<"uint64_t(uint64_t)", "zbkb,64bit">;
def zip_32 : RISCVBuiltin<"unsigned int(unsigned int)", "zbkb,32bit">;
def unzip_32 : RISCVBuiltin<"unsigned int(unsigned int)", "zbkb,32bit">;

//===----------------------------------------------------------------------===//
// Zknd extension.
//===----------------------------------------------------------------------===//
let Features = "zknd,32bit" in {
def aes32dsi : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, _Constant unsigned int)">;
def aes32dsmi : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, _Constant unsigned int)">;
} // Features = "zknd,32bit"

let Features = "zknd,64bit" in {
def aes64ds : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def aes64dsm : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def aes64im : RISCVBuiltin<"uint64_t(uint64_t)">;
} // Features = "zknd,64bit"

//===----------------------------------------------------------------------===//
// Zknd & Zkne extension.
//===----------------------------------------------------------------------===//
let Features = "zknd|zkne,64bit" in {
def aes64ks1i : RISCVBuiltin<"uint64_t(uint64_t, _Constant unsigned int)">;
def aes64ks2 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
} // Features = "zknd|zkne,64bit"

//===----------------------------------------------------------------------===//
// Zkne extension.
//===----------------------------------------------------------------------===//
let Features = "zkne,32bit" in {
def aes32esi : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, _Constant unsigned int)">;
def aes32esmi : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, _Constant unsigned int)">;
} // Features = "zkne,32bit"

let Features = "zkne,64bit" in {
def aes64es : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def aes64esm : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
} // Features = "zkne,64bit"

//===----------------------------------------------------------------------===//
// Zknh extension.
//===----------------------------------------------------------------------===//
let Features = "zknh" in {
def sha256sig0 : RISCVBuiltin<"unsigned int(unsigned int)">;
def sha256sig1 : RISCVBuiltin<"unsigned int(unsigned int)">;
def sha256sum0 : RISCVBuiltin<"unsigned int(unsigned int)">;
def sha256sum1 : RISCVBuiltin<"unsigned int(unsigned int)">;
} // Features = "zknh"

let Features = "zknh,32bit" in {
def sha512sig0h : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def sha512sig0l : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def sha512sig1h : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def sha512sig1l : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def sha512sum0r : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def sha512sum1r : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
} // Features = "zknh,32bit"

let Features = "zknh,64bit" in {
def sha512sig0 : RISCVBuiltin<"uint64_t(uint64_t)">;
def sha512sig1 : RISCVBuiltin<"uint64_t(uint64_t)">;
def sha512sum0 : RISCVBuiltin<"uint64_t(uint64_t)">;
def sha512sum1 : RISCVBuiltin<"uint64_t(uint64_t)">;
} // Features = "zknh,64bit"

//===----------------------------------------------------------------------===//
// Zksed extension.
//===----------------------------------------------------------------------===//
let Features = "zksed" in {
def sm4ed : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, _Constant unsigned int )">;
def sm4ks : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, _Constant unsigned int)">;
} // Features = "zksed"

//===----------------------------------------------------------------------===//
// Zksh extension.
//===----------------------------------------------------------------------===//
let Features = "zksh" in {
def sm3p0 : RISCVBuiltin<"unsigned int(unsigned int)">;
def sm3p1 : RISCVBuiltin<"unsigned int(unsigned int)">;
} // Features = "zksh"

} // Attributes = [Const, NoThrow]

//===----------------------------------------------------------------------===//
// Zihintntl extension.
//===----------------------------------------------------------------------===//
let Features = "zihintntl", Attributes = [CustomTypeChecking] in {
def ntl_load : RISCVBuiltin<"void(...)">;
def ntl_store : RISCVBuiltin<"void(...)">;
} // Features = "zihintntl", Attributes = [CustomTypeChecking]

let Attributes = [NoThrow] in {
let Features = "xxldsp,32bit" in {
def xldsp_rdov_32 : RISCVBuiltin<"unsigned int()">;
}

let Features = "xxldsp,64bit" in {
def xldsp_rdov_64 : RISCVBuiltin<"uint64_t()">;
}

let Features = "xxldsp" in {
def xldsp_clrov : RISCVBuiltin<"void()">;
}
}

let Attributes = [NoThrow, Const] in {
// Xxldsp
let Features = "xxldsp,32bit" in {
def xldsp_add16_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_radd16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_uradd16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kadd16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ukadd16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sub16_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_rsub16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ursub16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ksub16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_uksub16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_cras16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_rcras16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_urcras16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kcras16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ukcras16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_crsa16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_rcrsa16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_urcrsa16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kcrsa16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ukcrsa16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_stas16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_rstas16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_urstas16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kstas16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ukstas16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_stsa16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_rstsa16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_urstsa16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kstsa16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ukstsa16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_add8_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_radd8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_uradd8_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kadd8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ukadd8_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sub8_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_rsub8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ursub8_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ksub8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_uksub8_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sra16_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sra16_u_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_srl16_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_srl16_u_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sll16_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ksll16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kslra16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kslra16_u_32  : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sra8_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sra8_u_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_srl8_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_srl8_u_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sll8_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ksll8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kslra8_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kslra8_u_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_cmpeq16_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_scmplt16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_scmple16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ucmplt16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ucmple16_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_cmpeq8_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_scmplt8_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_scmple8_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ucmplt8_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ucmple8_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_khm16_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_khmx16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_khm8_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_khmx8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smin16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_umin16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smax16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_umax16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smin8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_umin8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smax8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_umax8_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_pkbb16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_pkbt16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_pktt16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_pktb16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smmul_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smmul_u_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kwmmul_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kwmmul_u_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smmwb_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smmwb_u_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smmwt_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smmwt_u_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kmmwb2_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kmmwb2_u_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kmmwt2_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kmmwt2_u_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smbb16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smbt16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smtt16_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kmda_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kmxda_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smds_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smdrs_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smxds_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_pbsad_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kaddh_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ksubh_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_khmbb_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_khmbt_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_khmtt_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ukaddh_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_uksubh_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kaddw_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ukaddw_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ksubw_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_uksubw_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kdmbb_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kdmbt_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kdmtt_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kslraw_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_kslraw_u_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ksllw_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_raddw_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_uraddw_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_rsubw_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ursubw_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_maxw_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_minw_32       : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_ave_32        : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_sra_u_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_bitrev_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int)">;
def xldsp_smul16_32     : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_smulx16_32    : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_umul16_32     : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_umulx16_32    : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_smul8_32      : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_smulx8_32     : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_umul8_32      : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_umulx8_32     : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_mulr64_32     : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;
def xldsp_mulsr64_32    : RISCVBuiltin<"uint64_t(unsigned int, unsigned int)">;

def xldsp_smal_32       : RISCVBuiltin<"uint64_t(uint64_t, unsigned int)">;

def xldsp_add64_32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_radd64_32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uradd64_32 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kadd64_32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukadd64_32 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sub64_32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rsub64_32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ursub64_32 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksub64_32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uksub64_32 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;

def xldsp_smar64_32  : RISCVBuiltin<"int64_t(int64_t, int, int)">;
def xldsp_smsr64_32  : RISCVBuiltin<"int64_t(int64_t, int, int)">;
def xldsp_umar64_32  : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_umsr64_32  : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_kmar64_32  : RISCVBuiltin<"int64_t(int64_t, int, int)">;
def xldsp_kmsr64_32  : RISCVBuiltin<"int64_t(int64_t, int, int)">;
def xldsp_ukmar64_32 : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_ukmsr64_32 : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smalbb_32  : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smalbt_32  : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smaltt_32  : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smalda_32  : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smalxda_32 : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smalds_32  : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smaldrs_32 : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smalxds_32 : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smslda_32  : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;
def xldsp_smslxda_32 : RISCVBuiltin<"uint64_t(uint64_t, unsigned int, unsigned int)">;

def xldsp_wext_32    : RISCVBuiltin<"unsigned int(uint64_t, unsigned int)">;
def xldsp_wexti_32   : RISCVBuiltin<"unsigned int(uint64_t, _Constant unsigned int)">;

def xldsp_kmmac_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmac_u_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmsb_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmsb_u_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmawb_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmawb_u_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmawt_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmawt_u_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmawb2_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmawb2_u_32  : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmawt2_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmmawt2_u_32  : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmabb_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmabt_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmatt_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmada_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmaxda_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmads_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmadrs_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmaxds_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmsda_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kmsxda_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_pbsada_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_smaqa_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_umaqa_32      : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_smaqa_su_32   : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kdmabb_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kdmabt_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_kdmatt_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_maddr32_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_msubr32_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;

def xldsp_kabs16_32    : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clrs16_32    : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clz16_32     : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clo16_32     : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_kabs8_32     : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clrs8_32     : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clz8_32      : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clo8_32      : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_swap8_32     : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_swap16_32    : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_sunpkd810_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_sunpkd820_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_sunpkd830_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_sunpkd831_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_sunpkd832_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_zunpkd810_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_zunpkd820_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_zunpkd830_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_zunpkd831_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_zunpkd832_32 : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clrs32_32    : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clz32_32     : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_clo32_32     : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_kabsw_32     : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_expd80_32    : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_expd81_32    : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_expd82_32    : RISCVBuiltin<"unsigned int(unsigned int)">;
def xldsp_expd83_32    : RISCVBuiltin<"unsigned int(unsigned int)">;

def xldsp_srai8_32    : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_srai8_u_32  : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_srli8_32    : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_srli8_u_32  : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_slli8_32    : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_kslli8_32   : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_sclip8_32   : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_uclip8_32   : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_srai16_32   : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_srai16_u_32 : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_srli16_32   : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_srli16_u_32 : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_slli16_32   : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_kslli16_32  : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_sclip16_32  : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_uclip16_32  : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_sclip32_32  : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_uclip32_32  : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_kslliw_32   : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_srai_u_32   : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;
def xldsp_bitrevi_32  : RISCVBuiltin<"unsigned int(unsigned int, _Constant unsigned int)">;

def xldsp_bpick_32    : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, unsigned int)">;
def xldsp_insb_32     : RISCVBuiltin<"unsigned int(unsigned int, unsigned int, _Constant unsigned int)">;
}

let Features = "xxldsp,64bit" in {
def xldsp_add16_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_radd16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uradd16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kadd16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukadd16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sub16_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rsub16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ursub16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksub16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uksub16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_cras16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rcras16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_urcras16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kcras16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukcras16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_crsa16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rcrsa16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_urcrsa16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kcrsa16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukcrsa16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_stas16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rstas16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_urstas16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kstas16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukstas16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_stsa16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rstsa16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_urstsa16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kstsa16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukstsa16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_add8_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_radd8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uradd8_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kadd8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukadd8_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sub8_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rsub8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ursub8_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksub8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uksub8_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sra16_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sra16_u_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_srl16_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_srl16_u_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sll16_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksll16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kslra16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kslra16_u_64    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sra8_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sra8_u_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_srl8_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_srl8_u_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sll8_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksll8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kslra8_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kslra8_u_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_cmpeq16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_scmplt16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_scmple16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ucmplt16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ucmple16_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_cmpeq8_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_scmplt8_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_scmple8_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ucmplt8_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ucmple8_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khm16_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khmx16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khm8_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khmx8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smin16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umin16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smax16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umax16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smin8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umin8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smax8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umax8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pkbb16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pkbt16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pktt16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pktb16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smmul_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smmul_u_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kwmmul_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kwmmul_u_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smmwb_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smmwb_u_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smmwt_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smmwt_u_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kmmwb2_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kmmwb2_u_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kmmwt2_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kmmwt2_u_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smbb16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smbt16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smtt16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kmda_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kmxda_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smds_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smdrs_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smxds_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pbsad_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kaddh_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksubh_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khmbb_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khmbt_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khmtt_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukaddh_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uksubh_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kaddw_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukaddw_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksubw_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uksubw_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kdmbb_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kdmbt_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kdmtt_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kslraw_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kslraw_u_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksllw_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_raddw_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uraddw_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rsubw_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ursubw_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_maxw_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_minw_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ave_64          : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sra_u_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_bitrev_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;

def xldsp_smul16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smulx16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umul16_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umulx16_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smul8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smulx8_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umul8_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umulx8_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_mulr64_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_mulsr64_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;

def xldsp_smal_64         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;

def xldsp_add64_64   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_radd64_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uradd64_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kadd64_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukadd64_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sub64_64   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rsub64_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ursub64_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksub64_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uksub64_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;

def xldsp_smar64_64  : RISCVBuiltin<"int64_t(int64_t, int64_t, int64_t)">;
def xldsp_smsr64_64  : RISCVBuiltin<"int64_t(int64_t, int64_t, int64_t)">;
def xldsp_umar64_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_umsr64_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmar64_64  : RISCVBuiltin<"int64_t(int64_t, int64_t, int64_t)">;
def xldsp_kmsr64_64  : RISCVBuiltin<"int64_t(int64_t, int64_t, int64_t)">;
def xldsp_ukmar64_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_ukmsr64_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smalbb_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smalbt_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smaltt_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smalda_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smalxda_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smalds_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smaldrs_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smalxds_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smslda_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smslxda_64 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;

def xldsp_wext_64  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_wexti_64 : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;

def xldsp_kmmac_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmac_u_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmsb_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmsb_u_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmawb_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmawb_u_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmawt_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmawt_u_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmawb2_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmawb2_u_64    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmawt2_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmmawt2_u_64    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmabb_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmabt_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmatt_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmada_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmaxda_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmads_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmadrs_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmaxds_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmsda_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmsxda_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_pbsada_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smaqa_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_umaqa_64        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_smaqa_su_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kdmabb_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kdmabt_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kdmatt_64       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_maddr32_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_msubr32_64      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;

def xldsp_kabs16_64     : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clrs16_64     : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clz16_64      : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clo16_64      : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_kabs8_64      : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clrs8_64      : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clz8_64       : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clo8_64       : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_swap8_64      : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_swap16_64     : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_sunpkd810_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_sunpkd820_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_sunpkd830_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_sunpkd831_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_sunpkd832_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_zunpkd810_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_zunpkd820_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_zunpkd830_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_zunpkd831_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_zunpkd832_64  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clrs32_64     : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clz32_64      : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_clo32_64      : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_kabsw_64      : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_expd80_64     : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_expd81_64     : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_expd82_64     : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_expd83_64     : RISCVBuiltin<"uint64_t(uint64_t)">;

def xldsp_srai8_64    : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srai8_u_64  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srli8_64    : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srli8_u_64  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_slli8_64    : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_kslli8_64   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_sclip8_64   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_uclip8_64   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srai16_64   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srai16_u_64 : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srli16_64   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srli16_u_64 : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_slli16_64   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_kslli16_64  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_sclip16_64  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_uclip16_64  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_sclip32_64  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_uclip32_64  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_kslliw_64   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srai_u_64   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_bitrevi_64  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;

def xldsp_bpick_64    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_insb_64     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, _Constant uint64_t)">;

def xldsp_add32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_radd32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uradd32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kadd32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukadd32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sub32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rsub32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ursub32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksub32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_uksub32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_cras32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rcras32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_urcras32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kcras32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukcras32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_crsa32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rcrsa32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_urcrsa32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kcrsa32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukcrsa32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_stas32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rstas32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_urstas32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kstas32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukstas32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_stsa32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_rstsa32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_urstsa32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kstsa32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ukstsa32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sra32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sra32_u   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_srl32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_srl32_u   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_sll32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_ksll32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kslra32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kslra32_u : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smin32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umin32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smax32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_umax32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khmbb16   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khmbt16   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_khmtt16   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kdmbb16   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kdmbt16   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kdmtt16   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smbt32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smtt32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kmda32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_kmxda32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smds32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smdrs32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_smxds32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pkbb32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pkbt32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pktt32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_pktb32    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;

def xldsp_kdmabb16  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kdmabt16  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kdmatt16  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmabb32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmabt32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmatt32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmaxda32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmads32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmadrs32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmaxds32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmsda32   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_kmsxda32  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;

def xldsp_kabs32    : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_expd84    : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_expd85    : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_expd86    : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_expd87    : RISCVBuiltin<"uint64_t(uint64_t)">;

def xldsp_srai32    : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srai32_u  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srli32    : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_srli32_u  : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_slli32    : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_kslli32   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
def xldsp_sraiw_u   : RISCVBuiltin<"uint64_t(uint64_t, _Constant uint64_t)">;
}


let Features = "xxldspn1x,32bit" in {
def xldsp_dkhm8   : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkhm16  : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkadd8  : RISCVBuiltin<"int64_t(int64_t, int64_t)">;
def xldsp_dkadd16 : RISCVBuiltin<"int64_t(int64_t, int64_t)">;
def xldsp_dksub8  : RISCVBuiltin<"int64_t(int64_t, int64_t)">;
def xldsp_dksub16 : RISCVBuiltin<"int64_t(int64_t, int64_t)">;

def xldsp_dkabs8  : RISCVBuiltin<"int64_t(int64_t)">;
def xldsp_dkabs16 : RISCVBuiltin<"int64_t(int64_t)">;

def xldsp_dkslra8   : RISCVBuiltin<"int64_t(int64_t, int)">;
def xldsp_dkslra16  : RISCVBuiltin<"int64_t(int64_t, int)">;
}

let Features = "xxldspn2x,32bit" in {
def xldsp_dkhmx8        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkhmx16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmmul        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmmul_u      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkwmmul       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkwmmul_u     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkadd32       : RISCVBuiltin<"int64_t(int64_t, int64_t)">;
def xldsp_dksub32       : RISCVBuiltin<"int64_t(int64_t, int64_t)">;
def xldsp_dradd16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsub16        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dradd32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsub32        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkmda         : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkmxda        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmdrs        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmxds        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmbb32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmbb32_sra14 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmbb32_sra32 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmbt32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmbt32_sra14 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmbt32_sra32 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmtt32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmtt32_sra14 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmtt32_sra32 : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dpkbb32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dpkbt32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dpktt32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dpktb32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dpktb16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dpkbb16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dpkbt16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dpktt16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsra16        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dadd16        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dadd32        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmbb16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmbt16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmtt16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_drcrsa16      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_drcras16      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkcrsa16      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkcras16      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_drsub16       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_drsub32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dstsa32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dstas32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkcras32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkcrsa32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dcrsa32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dcras32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkstsa16      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkstas16      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_drcrsa32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_drcras32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dmsr16        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dmsr17        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dmsr33        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dmxsr33       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;

def xldsp_dkabs32     : RISCVBuiltin<"int64_t(int64_t)">;
def xldsp_dsunpkd810  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dsunpkd820  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dsunpkd830  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dsunpkd831  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dsunpkd832  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dzunpkd810  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dzunpkd820  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dzunpkd830  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dzunpkd831  : RISCVBuiltin<"uint64_t(uint64_t)">;
def xldsp_dzunpkd832  : RISCVBuiltin<"uint64_t(uint64_t)">;

def xldsp_dkslra32    : RISCVBuiltin<"int64_t(int64_t, int)">;

def xldsp_dkclip64    : RISCVBuiltin<"unsigned int(uint64_t)">;
def xldsp_dredas16    : RISCVBuiltin<"int(int64_t)">;
def xldsp_dredsa16    : RISCVBuiltin<"int(int64_t)">;

def xldsp_dsclip8     : RISCVBuiltin<"uint64_t(uint64_t, _Constant unsigned int)">;
def xldsp_dsclip16    : RISCVBuiltin<"uint64_t(uint64_t, _Constant unsigned int)">;
def xldsp_dsclip32    : RISCVBuiltin<"uint64_t(uint64_t, _Constant unsigned int)">;

def xldsp_dpack32     : RISCVBuiltin<"int64_t(int, int)">;
}

let Features = "xxldspn3x,32bit" in {
def xldsp_dkmda32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dkmxda32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmds32       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmdrs32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;
def xldsp_dsmxds32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t)">;

def xldsp_dkmmac        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmmac_u      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmmsb        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmmsb_u      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmada        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmaxda       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmads        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmadrs       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmaxds       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmsda        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmsxda       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmaqa        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmaqa_su     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dumaqa        : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmada32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmaxda32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmads32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmadrs32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmaxds32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmsda32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmsxda32     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmalda       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmalxda      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmalds       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmaldrs      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmalxds      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmslda       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmslxda      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_ddsmaqa       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_ddsmaqa_su    : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_ddumaqa       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dksms32_u     : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmalbb       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmalbt       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dsmaltt       : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmabb32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmabt32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;
def xldsp_dkmatt32      : RISCVBuiltin<"uint64_t(uint64_t, uint64_t, uint64_t)">;

def xldsp_dsmada16      : RISCVBuiltin<"unsigned int(unsigned int, uint64_t, uint64_t)">;
def xldsp_dsmaxda16     : RISCVBuiltin<"unsigned int(unsigned int, uint64_t, uint64_t)">;
def xldsp_dmada32       : RISCVBuiltin<"unsigned int(unsigned int, uint64_t, uint64_t)">;

def xldsp_dsma32_u      : RISCVBuiltin<"int(int64_t, int64_t)">;
def xldsp_dsmxs32_u     : RISCVBuiltin<"int(int64_t, int64_t)">;
def xldsp_dsmxa32_u     : RISCVBuiltin<"int(int64_t, int64_t)">;
def xldsp_dsms32_u      : RISCVBuiltin<"int(int64_t, int64_t)">;

}
}
