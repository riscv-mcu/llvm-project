/*===---- riscv_bitmanip.h - RISC-V Zb* intrinsics --------------------------===
 *
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 *===-----------------------------------------------------------------------===
 */

#ifndef _RISCV_RVP_INTRINSIC_H
#define _RISCV_RVP_INTRINSIC_H

#include <stdint.h>

#if defined(__riscv_xxldsp)
#define __rv__clrov() \
  (__builtin_riscv_xldsp_clrov ())

#if __riscv_xlen == 32
#define __rv__rdov() \
  (__builtin_riscv_xldsp_rdov_32 ())
#define __rv__add16(a,b) \
  (__builtin_riscv_xldsp_add16_32 ((a), (b)))
#define __rv__radd16(a,b) \
  (__builtin_riscv_xldsp_radd16_32 ((a), (b)))
#define __rv__uradd16(a,b) \
  (__builtin_riscv_xldsp_uradd16_32 ((a), (b)))
#define __rv__kadd16(a,b) \
  (__builtin_riscv_xldsp_kadd16_32 ((a), (b)))
#define __rv__ukadd16(a,b) \
  (__builtin_riscv_xldsp_ukadd16_32 ((a), (b)))
#define __rv__sub16(a,b) \
  (__builtin_riscv_xldsp_sub16_32 ((a), (b)))
#define __rv__rsub16(a,b) \
  (__builtin_riscv_xldsp_rsub16_32 ((a), (b)))
#define __rv__ursub16(a,b) \
  (__builtin_riscv_xldsp_ursub16_32 ((a), (b)))
#define __rv__ksub16(a,b) \
  (__builtin_riscv_xldsp_ksub16_32 ((a), (b)))
#define __rv__uksub16(a,b) \
  (__builtin_riscv_xldsp_uksub16_32 ((a), (b)))
#define __rv__cras16(a,b) \
  (__builtin_riscv_xldsp_cras16_32 ((a), (b)))
#define __rv__rcras16(a,b) \
  (__builtin_riscv_xldsp_rcras16_32 ((a), (b)))
#define __rv__urcras16(a,b) \
  (__builtin_riscv_xldsp_urcras16_32 ((a), (b)))
#define __rv__kcras16(a,b) \
  (__builtin_riscv_xldsp_kcras16_32 ((a), (b)))
#define __rv__ukcras16(a,b) \
  (__builtin_riscv_xldsp_ukcras16_32 ((a), (b)))
#define __rv__crsa16(a,b) \
  (__builtin_riscv_xldsp_crsa16_32 ((a), (b)))
#define __rv__rcrsa16(a,b) \
  (__builtin_riscv_xldsp_rcrsa16_32 ((a), (b)))
#define __rv__urcrsa16(a,b) \
  (__builtin_riscv_xldsp_urcrsa16_32 ((a), (b)))
#define __rv__kcrsa16(a,b) \
  (__builtin_riscv_xldsp_kcrsa16_32 ((a), (b)))
#define __rv__ukcrsa16(a,b) \
  (__builtin_riscv_xldsp_ukcrsa16_32 ((a), (b)))
#define __rv__stas16(a,b) \
  (__builtin_riscv_xldsp_stas16_32 ((a), (b)))
#define __rv__rstas16(a,b) \
  (__builtin_riscv_xldsp_rstas16_32 ((a), (b)))
#define __rv__urstas16(a,b) \
  (__builtin_riscv_xldsp_urstas16_32 ((a), (b)))
#define __rv__kstas16(a,b) \
  (__builtin_riscv_xldsp_kstas16_32 ((a), (b)))
#define __rv__ukstas16(a,b) \
  (__builtin_riscv_xldsp_ukstas16_32 ((a), (b)))
#define __rv__stsa16(a,b) \
  (__builtin_riscv_xldsp_stsa16_32 ((a), (b)))
#define __rv__rstsa16(a,b) \
  (__builtin_riscv_xldsp_rstsa16_32 ((a), (b)))
#define __rv__urstsa16(a,b) \
  (__builtin_riscv_xldsp_urstsa16_32 ((a), (b)))
#define __rv__kstsa16(a,b) \
  (__builtin_riscv_xldsp_kstsa16_32 ((a), (b)))
#define __rv__ukstsa16(a,b) \
  (__builtin_riscv_xldsp_ukstsa16_32 ((a), (b)))
#define __rv__add8(a,b) \
  (__builtin_riscv_xldsp_add8_32 ((a), (b)))
#define __rv__radd8(a,b) \
  (__builtin_riscv_xldsp_radd8_32 ((a), (b)))
#define __rv__uradd8(a,b) \
  (__builtin_riscv_xldsp_uradd8_32 ((a), (b)))
#define __rv__kadd8(a,b) \
  (__builtin_riscv_xldsp_kadd8_32 ((a), (b)))
#define __rv__ukadd8(a,b) \
  (__builtin_riscv_xldsp_ukadd8_32 ((a), (b)))
#define __rv__sub8(a,b) \
  (__builtin_riscv_xldsp_sub8_32 ((a), (b)))
#define __rv__rsub8(a,b) \
  (__builtin_riscv_xldsp_rsub8_32 ((a), (b)))
#define __rv__ursub8(a,b) \
  (__builtin_riscv_xldsp_ursub8_32 ((a), (b)))
#define __rv__ksub8(a,b) \
  (__builtin_riscv_xldsp_ksub8_32 ((a), (b)))
#define __rv__uksub8(a,b) \
  (__builtin_riscv_xldsp_uksub8_32 ((a), (b)))
#define __rv__sra16(a,b) \
  (__builtin_riscv_xldsp_sra16_32 ((a), (b)))
#define __rv__sra16_u(a,b) \
  (__builtin_riscv_xldsp_sra16_u_32 ((a), (b)))
#define __rv__srl16(a,b) \
  (__builtin_riscv_xldsp_srl16_32 ((a), (b)))
#define __rv__srl16_u(a,b) \
  (__builtin_riscv_xldsp_srl16_u_32 ((a), (b)))
#define __rv__sll16(a,b) \
  (__builtin_riscv_xldsp_sll16_32 ((a), (b)))
#define __rv__ksll16(a,b) \
  (__builtin_riscv_xldsp_ksll16_32 ((a), (b)))
#define __rv__kslra16(a,b) \
  (__builtin_riscv_xldsp_kslra16_32 ((a), (b)))
#define __rv__kslra16_u(a,b) \
  (__builtin_riscv_xldsp_kslra16_u_32 ((a), (b)))
#define __rv__sra8(a,b) \
  (__builtin_riscv_xldsp_sra8_32 ((a), (b)))
#define __rv__sra8_u(a,b) \
  (__builtin_riscv_xldsp_sra8_u_32 ((a), (b)))
#define __rv__srl8(a,b) \
  (__builtin_riscv_xldsp_srl8_32 ((a), (b)))
#define __rv__srl8_u(a,b) \
  (__builtin_riscv_xldsp_srl8_u_32 ((a), (b)))
#define __rv__sll8(a,b) \
  (__builtin_riscv_xldsp_sll8_32 ((a), (b)))
#define __rv__ksll8(a,b) \
  (__builtin_riscv_xldsp_ksll8_32 ((a), (b)))
#define __rv__kslra8(a,b) \
  (__builtin_riscv_xldsp_kslra8_32 ((a), (b)))
#define __rv__kslra8_u(a,b) \
  (__builtin_riscv_xldsp_kslra8_u_32 ((a), (b)))
#define __rv__cmpeq16(a,b) \
  (__builtin_riscv_xldsp_cmpeq16_32 ((a), (b)))
#define __rv__scmplt16(a,b) \
  (__builtin_riscv_xldsp_scmplt16_32 ((a), (b)))
#define __rv__scmple16(a,b) \
  (__builtin_riscv_xldsp_scmple16_32 ((a), (b)))
#define __rv__ucmplt16(a,b) \
  (__builtin_riscv_xldsp_ucmplt16_32 ((a), (b)))
#define __rv__ucmple16(a,b) \
  (__builtin_riscv_xldsp_ucmple16_32 ((a), (b)))
#define __rv__cmpeq8(a,b) \
  (__builtin_riscv_xldsp_cmpeq8_32 ((a), (b)))
#define __rv__scmplt8(a,b) \
  (__builtin_riscv_xldsp_scmplt8_32 ((a), (b)))
#define __rv__scmple8(a,b) \
  (__builtin_riscv_xldsp_scmple8_32 ((a), (b)))
#define __rv__ucmplt8(a,b) \
  (__builtin_riscv_xldsp_ucmplt8_32 ((a), (b)))
#define __rv__ucmple8(a,b) \
  (__builtin_riscv_xldsp_ucmple8_32 ((a), (b)))
#define __rv__khm16(a,b) \
  (__builtin_riscv_xldsp_khm16_32 ((a), (b)))
#define __rv__khmx16(a,b) \
  (__builtin_riscv_xldsp_khmx16_32 ((a), (b)))
#define __rv__khm8(a,b) \
  (__builtin_riscv_xldsp_khm8_32 ((a), (b)))
#define __rv__khmx8(a,b) \
  (__builtin_riscv_xldsp_khmx8_32 ((a), (b)))
#define __rv__smin16(a,b) \
  (__builtin_riscv_xldsp_smin16_32 ((a), (b)))
#define __rv__umin16(a,b) \
  (__builtin_riscv_xldsp_umin16_32 ((a), (b)))
#define __rv__smax16(a,b) \
  (__builtin_riscv_xldsp_smax16_32 ((a), (b)))
#define __rv__umax16(a,b) \
  (__builtin_riscv_xldsp_umax16_32 ((a), (b)))
#define __rv__smin8(a,b) \
  (__builtin_riscv_xldsp_smin8_32 ((a), (b)))
#define __rv__umin8(a,b) \
  (__builtin_riscv_xldsp_umin8_32 ((a), (b)))
#define __rv__smax8(a,b) \
  (__builtin_riscv_xldsp_smax8_32 ((a), (b)))
#define __rv__umax8(a,b) \
  (__builtin_riscv_xldsp_umax8_32 ((a), (b)))
#define __rv__pkbb16(a,b) \
  (__builtin_riscv_xldsp_pkbb16_32 ((a), (b)))
#define __rv__pkbt16(a,b) \
  (__builtin_riscv_xldsp_pkbt16_32 ((a), (b)))
#define __rv__pktt16(a,b) \
  (__builtin_riscv_xldsp_pktt16_32 ((a), (b)))
#define __rv__pktb16(a,b) \
  (__builtin_riscv_xldsp_pktb16_32 ((a), (b)))
#define __rv__smmul(a,b) \
  (__builtin_riscv_xldsp_smmul_32 ((a), (b)))
#define __rv__smmul_u(a,b) \
  (__builtin_riscv_xldsp_smmul_u_32 ((a), (b)))
#define __rv__kwmmul(a,b) \
  (__builtin_riscv_xldsp_kwmmul_32 ((a), (b)))
#define __rv__kwmmul_u(a,b) \
  (__builtin_riscv_xldsp_kwmmul_u_32 ((a), (b)))
#define __rv__smmwb(a,b) \
  (__builtin_riscv_xldsp_smmwb_32 ((a), (b)))
#define __rv__smmwb_u(a,b) \
  (__builtin_riscv_xldsp_smmwb_u_32 ((a), (b)))
#define __rv__smmwt(a,b) \
  (__builtin_riscv_xldsp_smmwt_32 ((a), (b)))
#define __rv__smmwt_u(a,b) \
  (__builtin_riscv_xldsp_smmwt_u_32 ((a), (b)))
#define __rv__kmmwb2(a,b) \
  (__builtin_riscv_xldsp_kmmwb2_32 ((a), (b)))
#define __rv__kmmwb2_u(a,b) \
  (__builtin_riscv_xldsp_kmmwb2_u_32 ((a), (b)))
#define __rv__kmmwt2(a,b) \
  (__builtin_riscv_xldsp_kmmwt2_32 ((a), (b)))
#define __rv__kmmwt2_u(a,b) \
  (__builtin_riscv_xldsp_kmmwt2_u_32 ((a), (b)))
#define __rv__smbb16(a,b) \
  (__builtin_riscv_xldsp_smbb16_32 ((a), (b)))
#define __rv__smbt16(a,b) \
  (__builtin_riscv_xldsp_smbt16_32 ((a), (b)))
#define __rv__smtt16(a,b) \
  (__builtin_riscv_xldsp_smtt16_32 ((a), (b)))
#define __rv__kmda(a,b) \
  (__builtin_riscv_xldsp_kmda_32 ((a), (b)))
#define __rv__kmxda(a,b) \
  (__builtin_riscv_xldsp_kmxda_32 ((a), (b)))
#define __rv__smds(a,b) \
  (__builtin_riscv_xldsp_smds_32 ((a), (b)))
#define __rv__smdrs(a,b) \
  (__builtin_riscv_xldsp_smdrs_32 ((a), (b)))
#define __rv__smxds(a,b) \
  (__builtin_riscv_xldsp_smxds_32 ((a), (b)))
#define __rv__pbsad(a,b) \
  (__builtin_riscv_xldsp_pbsad_32 ((a), (b)))
#define __rv__kaddh(a,b) \
  (__builtin_riscv_xldsp_kaddh_32 ((a), (b)))
#define __rv__ksubh(a,b) \
  (__builtin_riscv_xldsp_ksubh_32 ((a), (b)))
#define __rv__khmbb(a,b) \
  (__builtin_riscv_xldsp_khmbb_32 ((a), (b)))
#define __rv__khmbt(a,b) \
  (__builtin_riscv_xldsp_khmbt_32 ((a), (b)))
#define __rv__khmtt(a,b) \
  (__builtin_riscv_xldsp_khmtt_32 ((a), (b)))
#define __rv__ukaddh(a,b) \
  (__builtin_riscv_xldsp_ukaddh_32 ((a), (b)))
#define __rv__uksubh(a,b) \
  (__builtin_riscv_xldsp_uksubh_32 ((a), (b)))
#define __rv__kaddw(a,b) \
  (__builtin_riscv_xldsp_kaddw_32 ((a), (b)))
#define __rv__ukaddw(a,b) \
  (__builtin_riscv_xldsp_ukaddw_32 ((a), (b)))
#define __rv__ksubw(a,b) \
  (__builtin_riscv_xldsp_ksubw_32 ((a), (b)))
#define __rv__uksubw(a,b) \
  (__builtin_riscv_xldsp_uksubw_32 ((a), (b)))
#define __rv__kdmbb(a,b) \
  (__builtin_riscv_xldsp_kdmbb_32 ((a), (b)))
#define __rv__kdmbt(a,b) \
  (__builtin_riscv_xldsp_kdmbt_32 ((a), (b)))
#define __rv__kdmtt(a,b) \
  (__builtin_riscv_xldsp_kdmtt_32 ((a), (b)))
#define __rv__kslraw(a,b) \
  (__builtin_riscv_xldsp_kslraw_32 ((a), (b)))
#define __rv__kslraw_u(a,b) \
  (__builtin_riscv_xldsp_kslraw_u_32 ((a), (b)))
#define __rv__ksllw(a,b) \
  (__builtin_riscv_xldsp_ksllw_32 ((a), (b)))
#define __rv__raddw(a,b) \
  (__builtin_riscv_xldsp_raddw_32 ((a), (b)))
#define __rv__uraddw(a,b) \
  (__builtin_riscv_xldsp_uraddw_32 ((a), (b)))
#define __rv__rsubw(a,b) \
  (__builtin_riscv_xldsp_rsubw_32 ((a), (b)))
#define __rv__ursubw(a,b) \
  (__builtin_riscv_xldsp_ursubw_32 ((a), (b)))
#define __rv__maxw(a,b) \
  (__builtin_riscv_xldsp_maxw_32 ((a), (b)))
#define __rv__minw(a,b) \
  (__builtin_riscv_xldsp_minw_32 ((a), (b)))
#define __rv__ave(a,b) \
  (__builtin_riscv_xldsp_ave_32 ((a), (b)))
#define __rv__sra_u(a,b) \
  (__builtin_riscv_xldsp_sra_u_32 ((a), (b)))
#define __rv__bitrev(a,b) \
  (__builtin_riscv_xldsp_bitrev_32 ((a), (b)))
#define __rv__smul16(a,b) \
  (__builtin_riscv_xldsp_smul16_32 ((a), (b)))
#define __rv__smulx16(a,b) \
  (__builtin_riscv_xldsp_smulx16_32 ((a), (b)))
#define __rv__umul16(a,b) \
  (__builtin_riscv_xldsp_umul16_32 ((a), (b)))
#define __rv__umulx16(a,b) \
  (__builtin_riscv_xldsp_umulx16_32 ((a), (b)))
#define __rv__smul8(a,b) \
  (__builtin_riscv_xldsp_smul8_32 ((a), (b)))
#define __rv__smulx8(a,b) \
  (__builtin_riscv_xldsp_smulx8_32 ((a), (b)))
#define __rv__umul8(a,b) \
  (__builtin_riscv_xldsp_umul8_32 ((a), (b)))
#define __rv__umulx8(a,b) \
  (__builtin_riscv_xldsp_umulx8_32 ((a), (b)))
#define __rv__mulr64(a,b) \
  (__builtin_riscv_xldsp_mulr64_32 ((a), (b)))
#define __rv__mulsr64(a,b) \
  (__builtin_riscv_xldsp_mulsr64_32 ((a), (b)))
#define __rv__smal(a, b) \
  (__builtin_riscv_xldsp_smal_32 ((a), (b)))
#define __rv__sadd64(a, b) \
  (__builtin_riscv_xldsp_add64_32 ((a), (b)))
#define __rv__uadd64(a, b) \
  (__builtin_riscv_xldsp_add64_32 ((a), (b)))
#define __rv__radd64(a, b) \
  (__builtin_riscv_xldsp_radd64_32 ((a), (b)))
#define __rv__uradd64(a, b) \
  (__builtin_riscv_xldsp_uradd64_32 ((a), (b)))
#define __rv__kadd64(a, b) \
  (__builtin_riscv_xldsp_kadd64_32 ((a), (b)))
#define __rv__ukadd64(a, b) \
  (__builtin_riscv_xldsp_ukadd64_32 ((a), (b)))
#define __rv__ssub64(a, b) \
  (__builtin_riscv_xldsp_sub64_32 ((a), (b)))
#define __rv__usub64(a, b) \
  (__builtin_riscv_xldsp_sub64_32 ((a), (b)))
#define __rv__rsub64(a, b) \
  (__builtin_riscv_xldsp_rsub64_32 ((a), (b)))
#define __rv__ursub64(a, b) \
  (__builtin_riscv_xldsp_ursub64_32 ((a), (b)))
#define __rv__ksub64(a, b) \
  (__builtin_riscv_xldsp_ksub64_32 ((a), (b)))
#define __rv__uksub64(a, b) \
  (__builtin_riscv_xldsp_uksub64_32 ((a), (b)))
#define __rv__smar64(r, a, b) \
  (__builtin_riscv_xldsp_smar64_32 ((r), (a), (b)))
#define __rv__smsr64(r, a, b) \
  (__builtin_riscv_xldsp_smsr64_32 ((r), (a), (b)))
#define __rv__umar64(r, a, b) \
  (__builtin_riscv_xldsp_umar64_32 ((r), (a), (b)))
#define __rv__umsr64(r, a, b) \
  (__builtin_riscv_xldsp_umsr64_32 ((r), (a), (b)))
#define __rv__kmar64(r, a, b) \
  (__builtin_riscv_xldsp_kmar64_32 ((r), (a), (b)))
#define __rv__kmsr64(r, a, b) \
  (__builtin_riscv_xldsp_kmsr64_32 ((r), (a), (b)))
#define __rv__ukmar64(r, a, b) \
  (__builtin_riscv_xldsp_ukmar64_32 ((r), (a), (b)))
#define __rv__ukmsr64(r, a, b) \
  (__builtin_riscv_xldsp_ukmsr64_32 ((r), (a), (b)))
#define __rv__smalbb(r, a, b) \
  (__builtin_riscv_xldsp_smalbb_32 ((r), (a), (b)))
#define __rv__smalbt(r, a, b) \
  (__builtin_riscv_xldsp_smalbt_32 ((r), (a), (b)))
#define __rv__smaltt(r, a, b) \
  (__builtin_riscv_xldsp_smaltt_32 ((r), (a), (b)))
#define __rv__smalda(r, a, b) \
  (__builtin_riscv_xldsp_smalda_32 ((r), (a), (b)))
#define __rv__smalxda(r, a, b) \
  (__builtin_riscv_xldsp_smalxda_32 ((r), (a), (b)))
#define __rv__smalds(r, a, b) \
  (__builtin_riscv_xldsp_smalds_32 ((r), (a), (b)))
#define __rv__smaldrs(r, a, b) \
  (__builtin_riscv_xldsp_smaldrs_32 ((r), (a), (b)))
#define __rv__smalxds(r, a, b) \
  (__builtin_riscv_xldsp_smalxds_32 ((r), (a), (b)))
#define __rv__smslda(r, a, b) \
  (__builtin_riscv_xldsp_smslda_32 ((r), (a), (b)))
#define __rv__smslxda(r, a, b) \
  (__builtin_riscv_xldsp_smslxda_32 ((r), (a), (b)))
#define __rv__wext(a,b) \
  (__builtin_riscv_xldsp_wext_32 ((a), (b)))
#define __rv__wexti(a,b) \
  (__builtin_riscv_xldsp_wexti_32 ((a), (b)))
#define __rv__kmmac(r, a, b) \
  (__builtin_riscv_xldsp_kmmac_32 ((r), (a), (b)))
#define __rv__kmmac_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmac_u_32 ((r), (a), (b)))
#define __rv__kmmsb(r, a, b) \
  (__builtin_riscv_xldsp_kmmsb_32 ((r), (a), (b)))
#define __rv__kmmsb_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmsb_u_32 ((r), (a), (b)))
#define __rv__kmmawb(r, a, b) \
  (__builtin_riscv_xldsp_kmmawb_32 ((r), (a), (b)))
#define __rv__kmmawb_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmawb_u_32 ((r), (a), (b)))
#define __rv__kmmawt(r, a, b) \
  (__builtin_riscv_xldsp_kmmawt_32 ((r), (a), (b)))
#define __rv__kmmawt_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmawt_u_32 ((r), (a), (b)))
#define __rv__kmmawb2(r, a, b) \
  (__builtin_riscv_xldsp_kmmawb2_32 ((r), (a), (b)))
#define __rv__kmmawb2_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmawb2_u_32 ((r), (a), (b)))
#define __rv__kmmawt2(r, a, b) \
  (__builtin_riscv_xldsp_kmmawt2_32 ((r), (a), (b)))
#define __rv__kmmawt2_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmawt2_u_32 ((r), (a), (b)))
#define __rv__kmabb(r, a, b) \
  (__builtin_riscv_xldsp_kmabb_32 ((r), (a), (b)))
#define __rv__kmabt(r, a, b) \
  (__builtin_riscv_xldsp_kmabt_32 ((r), (a), (b)))
#define __rv__kmatt(r, a, b) \
  (__builtin_riscv_xldsp_kmatt_32 ((r), (a), (b)))
#define __rv__kmada(r, a, b) \
  (__builtin_riscv_xldsp_kmada_32 ((r), (a), (b)))
#define __rv__kmaxda(r, a, b) \
  (__builtin_riscv_xldsp_kmaxda_32 ((r), (a), (b)))
#define __rv__kmads(r, a, b) \
  (__builtin_riscv_xldsp_kmads_32 ((r), (a), (b)))
#define __rv__kmadrs(r, a, b) \
  (__builtin_riscv_xldsp_kmadrs_32 ((r), (a), (b)))
#define __rv__kmaxds(r, a, b) \
  (__builtin_riscv_xldsp_kmaxds_32 ((r), (a), (b)))
#define __rv__kmsda(r, a, b) \
  (__builtin_riscv_xldsp_kmsda_32 ((r), (a), (b)))
#define __rv__kmsxda(r, a, b) \
  (__builtin_riscv_xldsp_kmsxda_32 ((r), (a), (b)))
#define __rv__pbsada(r, a, b) \
  (__builtin_riscv_xldsp_pbsada_32 ((r), (a), (b)))
#define __rv__smaqa(r, a, b) \
  (__builtin_riscv_xldsp_smaqa_32 ((r), (a), (b)))
#define __rv__umaqa(r, a, b) \
  (__builtin_riscv_xldsp_umaqa_32 ((r), (a), (b)))
#define __rv__smaqa_su(r, a, b) \
  (__builtin_riscv_xldsp_smaqa_su_32 ((r), (a), (b)))
#define __rv__kdmabb(r, a, b) \
  (__builtin_riscv_xldsp_kdmabb_32 ((r), (a), (b)))
#define __rv__kdmabt(r, a, b) \
  (__builtin_riscv_xldsp_kdmabt_32 ((r), (a), (b)))
#define __rv__kdmatt(r, a, b) \
  (__builtin_riscv_xldsp_kdmatt_32 ((r), (a), (b)))
#define __rv__maddr32(r, a, b) \
  (__builtin_riscv_xldsp_maddr32_32 ((r), (a), (b)))
#define __rv__msubr32(r, a, b) \
  (__builtin_riscv_xldsp_msubr32_32 ((r), (a), (b)))
#define __rv__kabs16(a) \
  (__builtin_riscv_xldsp_kabs16_32 ((a)))
#define __rv__clrs16(a) \
  (__builtin_riscv_xldsp_clrs16_32 ((a)))
#define __rv__clz16(a) \
  (__builtin_riscv_xldsp_clz16_32 ((a)))
#define __rv__clo16(a) \
  (__builtin_riscv_xldsp_clo16_32 ((a)))
#define __rv__kabs8(a) \
  (__builtin_riscv_xldsp_kabs8_32 ((a)))
#define __rv__clrs8(a) \
  (__builtin_riscv_xldsp_clrs8_32 ((a)))
#define __rv__clz8(a) \
  (__builtin_riscv_xldsp_clz8_32 ((a)))
#define __rv__clo8(a) \
  (__builtin_riscv_xldsp_clo8_32 ((a)))
#define __rv__swap8(a) \
  (__builtin_riscv_xldsp_swap8_32 ((a)))
#define __rv__swap16(a) \
  (__builtin_riscv_xldsp_swap16_32 ((a)))
#define __rv__sunpkd810(a) \
  (__builtin_riscv_xldsp_sunpkd810_32 ((a)))
#define __rv__sunpkd820(a) \
  (__builtin_riscv_xldsp_sunpkd820_32 ((a)))
#define __rv__sunpkd830(a) \
  (__builtin_riscv_xldsp_sunpkd830_32 ((a)))
#define __rv__sunpkd831(a) \
  (__builtin_riscv_xldsp_sunpkd831_32 ((a)))
#define __rv__sunpkd832(a) \
  (__builtin_riscv_xldsp_sunpkd832_32 ((a)))
#define __rv__zunpkd810(a) \
  (__builtin_riscv_xldsp_zunpkd810_32 ((a)))
#define __rv__zunpkd820(a) \
  (__builtin_riscv_xldsp_zunpkd820_32 ((a)))
#define __rv__zunpkd830(a) \
  (__builtin_riscv_xldsp_zunpkd830_32 ((a)))
#define __rv__zunpkd831(a) \
  (__builtin_riscv_xldsp_zunpkd831_32 ((a)))
#define __rv__zunpkd832(a) \
  (__builtin_riscv_xldsp_zunpkd832_32 ((a)))
#define __rv__clrs32(a) \
  (__builtin_riscv_xldsp_clrs32_32 ((a)))
#define __rv__clz32(a) \
  (__builtin_riscv_xldsp_clz32_32 ((a)))
#define __rv__clo32(a) \
  (__builtin_riscv_xldsp_clo32_32 ((a)))
#define __rv__kabsw(a) \
  (__builtin_riscv_xldsp_kabsw_32 ((a)))
#define __rv__srai8(a, b) \
  (__builtin_riscv_xldsp_srai8_32 ((a), (b)))
#define __rv__srai8_u(a, b) \
  (__builtin_riscv_xldsp_srai8_u_32 ((a), (b)))
#define __rv__srli8(a, b) \
  (__builtin_riscv_xldsp_srli8_32 ((a), (b)))
#define __rv__srli8_u(a, b) \
  (__builtin_riscv_xldsp_srli8_u_32 ((a), (b)))
#define __rv__slli8(a, b) \
  (__builtin_riscv_xldsp_slli8_32 ((a), (b)))
#define __rv__kslli8(a, b) \
  (__builtin_riscv_xldsp_kslli8_32 ((a), (b)))
#define __rv__sclip8(a, b) \
  (__builtin_riscv_xldsp_sclip8_32 ((a), (b)))
#define __rv__uclip8(a, b) \
  (__builtin_riscv_xldsp_uclip8_32 ((a), (b)))
#define __rv__srai16(a, b) \
  (__builtin_riscv_xldsp_srai16_32 ((a), (b)))
#define __rv__srai16_u(a, b) \
  (__builtin_riscv_xldsp_srai16_u_32 ((a), (b)))
#define __rv__srli16(a, b) \
  (__builtin_riscv_xldsp_srli16_32 ((a), (b)))
#define __rv__srli16_u(a, b) \
  (__builtin_riscv_xldsp_srli16_u_32 ((a), (b)))
#define __rv__slli16(a, b) \
  (__builtin_riscv_xldsp_slli16_32 ((a), (b)))
#define __rv__kslli16(a, b) \
  (__builtin_riscv_xldsp_kslli16_32 ((a), (b)))
#define __rv__sclip16(a, b) \
  (__builtin_riscv_xldsp_sclip16_32 ((a), (b)))
#define __rv__uclip16(a, b) \
  (__builtin_riscv_xldsp_uclip16_32 ((a), (b)))
#define __rv__sclip32(a, b) \
  (__builtin_riscv_xldsp_sclip32_32 ((a), (b)))
#define __rv__uclip32(a, b) \
  (__builtin_riscv_xldsp_uclip32_32 ((a), (b)))
#define __rv__kslliw(a, b) \
  (__builtin_riscv_xldsp_kslliw_32 ((a), (b)))
#define __rv__srai_u(a, b) \
  (__builtin_riscv_xldsp_srai_u_32 ((a), (b)))
#define __rv__bitrevi(a, b) \
  (__builtin_riscv_xldsp_bitrevi_32 ((a), (b)))
#define __rv__bpick(r, a, b) \
  (__builtin_riscv_xldsp_bpick_32 ((r), (a), (b)))
#define __rv__insb(a, b, c) \
  (__builtin_riscv_xldsp_insb_32 ((a), (b), (c)))
#else
#define __rv__rdov() \
  (__builtin_riscv_xldsp_rdov_64 ())
#define __rv__add16(a, b) \
  (__builtin_riscv_xldsp_add16_64 ((a), (b)))
#define __rv__radd16(a, b) \
  (__builtin_riscv_xldsp_radd16_64 ((a), (b)))
#define __rv__uradd16(a, b) \
  (__builtin_riscv_xldsp_uradd16_64 ((a), (b)))
#define __rv__kadd16(a, b) \
  (__builtin_riscv_xldsp_kadd16_64 ((a), (b)))
#define __rv__ukadd16(a, b) \
  (__builtin_riscv_xldsp_ukadd16_64 ((a), (b)))
#define __rv__sub16(a, b) \
  (__builtin_riscv_xldsp_sub16_64 ((a), (b)))
#define __rv__rsub16(a, b) \
  (__builtin_riscv_xldsp_rsub16_64 ((a), (b)))
#define __rv__ursub16(a, b) \
  (__builtin_riscv_xldsp_ursub16_64 ((a), (b)))
#define __rv__ksub16(a, b) \
  (__builtin_riscv_xldsp_ksub16_64 ((a), (b)))
#define __rv__uksub16(a, b) \
  (__builtin_riscv_xldsp_uksub16_64 ((a), (b)))
#define __rv__cras16(a, b) \
  (__builtin_riscv_xldsp_cras16_64 ((a), (b)))
#define __rv__rcras16(a, b) \
  (__builtin_riscv_xldsp_rcras16_64 ((a), (b)))
#define __rv__urcras16(a, b) \
  (__builtin_riscv_xldsp_urcras16_64 ((a), (b)))
#define __rv__kcras16(a, b) \
  (__builtin_riscv_xldsp_kcras16_64 ((a), (b)))
#define __rv__ukcras16(a, b) \
  (__builtin_riscv_xldsp_ukcras16_64 ((a), (b)))
#define __rv__crsa16(a, b) \
  (__builtin_riscv_xldsp_crsa16_64 ((a), (b)))
#define __rv__rcrsa16(a, b) \
  (__builtin_riscv_xldsp_rcrsa16_64 ((a), (b)))
#define __rv__urcrsa16(a, b) \
  (__builtin_riscv_xldsp_urcrsa16_64 ((a), (b)))
#define __rv__kcrsa16(a, b) \
  (__builtin_riscv_xldsp_kcrsa16_64 ((a), (b)))
#define __rv__ukcrsa16(a, b) \
  (__builtin_riscv_xldsp_ukcrsa16_64 ((a), (b)))
#define __rv__stas16(a, b) \
  (__builtin_riscv_xldsp_stas16_64 ((a), (b)))
#define __rv__rstas16(a, b) \
  (__builtin_riscv_xldsp_rstas16_64 ((a), (b)))
#define __rv__urstas16(a, b) \
  (__builtin_riscv_xldsp_urstas16_64 ((a), (b)))
#define __rv__kstas16(a, b) \
  (__builtin_riscv_xldsp_kstas16_64 ((a), (b)))
#define __rv__ukstas16(a, b) \
  (__builtin_riscv_xldsp_ukstas16_64 ((a), (b)))
#define __rv__stsa16(a, b) \
  (__builtin_riscv_xldsp_stsa16_64 ((a), (b)))
#define __rv__rstsa16(a, b) \
  (__builtin_riscv_xldsp_rstsa16_64 ((a), (b)))
#define __rv__urstsa16(a, b) \
  (__builtin_riscv_xldsp_urstsa16_64 ((a), (b)))
#define __rv__kstsa16(a, b) \
  (__builtin_riscv_xldsp_kstsa16_64 ((a), (b)))
#define __rv__ukstsa16(a, b) \
  (__builtin_riscv_xldsp_ukstsa16_64 ((a), (b)))
#define __rv__add8(a, b) \
  (__builtin_riscv_xldsp_add8_64 ((a), (b)))
#define __rv__radd8(a, b) \
  (__builtin_riscv_xldsp_radd8_64 ((a), (b)))
#define __rv__uradd8(a, b) \
  (__builtin_riscv_xldsp_uradd8_64 ((a), (b)))
#define __rv__kadd8(a, b) \
  (__builtin_riscv_xldsp_kadd8_64 ((a), (b)))
#define __rv__ukadd8(a, b) \
  (__builtin_riscv_xldsp_ukadd8_64 ((a), (b)))
#define __rv__sub8(a, b) \
  (__builtin_riscv_xldsp_sub8_64 ((a), (b)))
#define __rv__rsub8(a, b) \
  (__builtin_riscv_xldsp_rsub8_64 ((a), (b)))
#define __rv__ursub8(a, b) \
  (__builtin_riscv_xldsp_ursub8_64 ((a), (b)))
#define __rv__ksub8(a, b) \
  (__builtin_riscv_xldsp_ksub8_64 ((a), (b)))
#define __rv__uksub8(a, b) \
  (__builtin_riscv_xldsp_uksub8_64 ((a), (b)))
#define __rv__sra16(a, b) \
  (__builtin_riscv_xldsp_sra16_64 ((a), (b)))
#define __rv__sra16_u(a, b) \
  (__builtin_riscv_xldsp_sra16_u_64 ((a), (b)))
#define __rv__srl16(a, b) \
  (__builtin_riscv_xldsp_srl16_64 ((a), (b)))
#define __rv__srl16_u(a, b) \
  (__builtin_riscv_xldsp_srl16_u_64 ((a), (b)))
#define __rv__sll16(a, b) \
  (__builtin_riscv_xldsp_sll16_64 ((a), (b)))
#define __rv__ksll16(a, b) \
  (__builtin_riscv_xldsp_ksll16_64 ((a), (b)))
#define __rv__kslra16(a, b) \
  (__builtin_riscv_xldsp_kslra16_64 ((a), (b)))
#define __rv__kslra16_u(a, b) \
  (__builtin_riscv_xldsp_kslra16_u_64 ((a), (b)))
#define __rv__sra8(a, b) \
  (__builtin_riscv_xldsp_sra8_64 ((a), (b)))
#define __rv__sra8_u(a, b) \
  (__builtin_riscv_xldsp_sra8_u_64 ((a), (b)))
#define __rv__srl8(a, b) \
  (__builtin_riscv_xldsp_srl8_64 ((a), (b)))
#define __rv__srl8_u(a, b) \
  (__builtin_riscv_xldsp_srl8_u_64 ((a), (b)))
#define __rv__sll8(a, b) \
  (__builtin_riscv_xldsp_sll8_64 ((a), (b)))
#define __rv__ksll8(a, b) \
  (__builtin_riscv_xldsp_ksll8_64 ((a), (b)))
#define __rv__kslra8(a, b) \
  (__builtin_riscv_xldsp_kslra8_64 ((a), (b)))
#define __rv__kslra8_u(a, b) \
  (__builtin_riscv_xldsp_kslra8_u_64 ((a), (b)))
#define __rv__cmpeq16(a, b) \
  (__builtin_riscv_xldsp_cmpeq16_64 ((a), (b)))
#define __rv__scmplt16(a, b) \
  (__builtin_riscv_xldsp_scmplt16_64 ((a), (b)))
#define __rv__scmple16(a, b) \
  (__builtin_riscv_xldsp_scmple16_64 ((a), (b)))
#define __rv__ucmplt16(a, b) \
  (__builtin_riscv_xldsp_ucmplt16_64 ((a), (b)))
#define __rv__ucmple16(a, b) \
  (__builtin_riscv_xldsp_ucmple16_64 ((a), (b)))
#define __rv__cmpeq8(a, b) \
  (__builtin_riscv_xldsp_cmpeq8_64 ((a), (b)))
#define __rv__scmplt8(a, b) \
  (__builtin_riscv_xldsp_scmplt8_64 ((a), (b)))
#define __rv__scmple8(a, b) \
  (__builtin_riscv_xldsp_scmple8_64 ((a), (b)))
#define __rv__ucmplt8(a, b) \
  (__builtin_riscv_xldsp_ucmplt8_64 ((a), (b)))
#define __rv__ucmple8(a, b) \
  (__builtin_riscv_xldsp_ucmple8_64 ((a), (b)))
#define __rv__khm16(a, b) \
  (__builtin_riscv_xldsp_khm16_64 ((a), (b)))
#define __rv__khmx16(a, b) \
  (__builtin_riscv_xldsp_khmx16_64 ((a), (b)))
#define __rv__khm8(a, b) \
  (__builtin_riscv_xldsp_khm8_64 ((a), (b)))
#define __rv__khmx8(a, b) \
  (__builtin_riscv_xldsp_khmx8_64 ((a), (b)))
#define __rv__smin16(a, b) \
  (__builtin_riscv_xldsp_smin16_64 ((a), (b)))
#define __rv__umin16(a, b) \
  (__builtin_riscv_xldsp_umin16_64 ((a), (b)))
#define __rv__smax16(a, b) \
  (__builtin_riscv_xldsp_smax16_64 ((a), (b)))
#define __rv__umax16(a, b) \
  (__builtin_riscv_xldsp_umax16_64 ((a), (b)))
#define __rv__smin8(a, b) \
  (__builtin_riscv_xldsp_smin8_64 ((a), (b)))
#define __rv__umin8(a, b) \
  (__builtin_riscv_xldsp_umin8_64 ((a), (b)))
#define __rv__smax8(a, b) \
  (__builtin_riscv_xldsp_smax8_64 ((a), (b)))
#define __rv__umax8(a, b) \
  (__builtin_riscv_xldsp_umax8_64 ((a), (b)))
#define __rv__pkbb16(a, b) \
  (__builtin_riscv_xldsp_pkbb16_64 ((a), (b)))
#define __rv__pkbt16(a, b) \
  (__builtin_riscv_xldsp_pkbt16_64 ((a), (b)))
#define __rv__pktt16(a, b) \
  (__builtin_riscv_xldsp_pktt16_64 ((a), (b)))
#define __rv__pktb16(a, b) \
  (__builtin_riscv_xldsp_pktb16_64 ((a), (b)))
#define __rv__smmul(a, b) \
  (__builtin_riscv_xldsp_smmul_64 ((a), (b)))
#define __rv__smmul_u(a, b) \
  (__builtin_riscv_xldsp_smmul_u_64 ((a), (b)))
#define __rv__kwmmul(a, b) \
  (__builtin_riscv_xldsp_kwmmul_64 ((a), (b)))
#define __rv__kwmmul_u(a, b) \
  (__builtin_riscv_xldsp_kwmmul_u_64 ((a), (b)))
#define __rv__smmwb(a, b) \
  (__builtin_riscv_xldsp_smmwb_64 ((a), (b)))
#define __rv__smmwb_u(a, b) \
  (__builtin_riscv_xldsp_smmwb_u_64 ((a), (b)))
#define __rv__smmwt(a, b) \
  (__builtin_riscv_xldsp_smmwt_64 ((a), (b)))
#define __rv__smmwt_u(a, b) \
  (__builtin_riscv_xldsp_smmwt_u_64 ((a), (b)))
#define __rv__kmmwb2(a, b) \
  (__builtin_riscv_xldsp_kmmwb2_64 ((a), (b)))
#define __rv__kmmwb2_u(a, b) \
  (__builtin_riscv_xldsp_kmmwb2_u_64 ((a), (b)))
#define __rv__kmmwt2(a, b) \
  (__builtin_riscv_xldsp_kmmwt2_64 ((a), (b)))
#define __rv__kmmwt2_u(a, b) \
  (__builtin_riscv_xldsp_kmmwt2_u_64 ((a), (b)))
#define __rv__smbb16(a, b) \
  (__builtin_riscv_xldsp_smbb16_64 ((a), (b)))
#define __rv__smbt16(a, b) \
  (__builtin_riscv_xldsp_smbt16_64 ((a), (b)))
#define __rv__smtt16(a, b) \
  (__builtin_riscv_xldsp_smtt16_64 ((a), (b)))
#define __rv__kmda(a, b) \
  (__builtin_riscv_xldsp_kmda_64 ((a), (b)))
#define __rv__kmxda(a, b) \
  (__builtin_riscv_xldsp_kmxda_64 ((a), (b)))
#define __rv__smds(a, b) \
  (__builtin_riscv_xldsp_smds_64 ((a), (b)))
#define __rv__smdrs(a, b) \
  (__builtin_riscv_xldsp_smdrs_64 ((a), (b)))
#define __rv__smxds(a, b) \
  (__builtin_riscv_xldsp_smxds_64 ((a), (b)))
#define __rv__pbsad(a, b) \
  (__builtin_riscv_xldsp_pbsad_64 ((a), (b)))
#define __rv__kaddh(a, b) \
  (__builtin_riscv_xldsp_kaddh_64 ((a), (b)))
#define __rv__ksubh(a, b) \
  (__builtin_riscv_xldsp_ksubh_64 ((a), (b)))
#define __rv__khmbb(a, b) \
  (__builtin_riscv_xldsp_khmbb_64 ((a), (b)))
#define __rv__khmbt(a, b) \
  (__builtin_riscv_xldsp_khmbt_64 ((a), (b)))
#define __rv__khmtt(a, b) \
  (__builtin_riscv_xldsp_khmtt_64 ((a), (b)))
#define __rv__ukaddh(a, b) \
  (__builtin_riscv_xldsp_ukaddh_64 ((a), (b)))
#define __rv__uksubh(a, b) \
  (__builtin_riscv_xldsp_uksubh_64 ((a), (b)))
#define __rv__kaddw(a, b) \
  (__builtin_riscv_xldsp_kaddw_64 ((a), (b)))
#define __rv__ukaddw(a, b) \
  (__builtin_riscv_xldsp_ukaddw_64 ((a), (b)))
#define __rv__ksubw(a, b) \
  (__builtin_riscv_xldsp_ksubw_64 ((a), (b)))
#define __rv__uksubw(a, b) \
  (__builtin_riscv_xldsp_uksubw_64 ((a), (b)))
#define __rv__kdmbb(a, b) \
  (__builtin_riscv_xldsp_kdmbb_64 ((a), (b)))
#define __rv__kdmbt(a, b) \
  (__builtin_riscv_xldsp_kdmbt_64 ((a), (b)))
#define __rv__kdmtt(a, b) \
  (__builtin_riscv_xldsp_kdmtt_64 ((a), (b)))
#define __rv__kslraw(a, b) \
  (__builtin_riscv_xldsp_kslraw_64 ((a), (b)))
#define __rv__kslraw_u(a, b) \
  (__builtin_riscv_xldsp_kslraw_u_64 ((a), (b)))
#define __rv__ksllw(a, b) \
  (__builtin_riscv_xldsp_ksllw_64 ((a), (b)))
#define __rv__raddw(a, b) \
  (__builtin_riscv_xldsp_raddw_64 ((a), (b)))
#define __rv__uraddw(a, b) \
  (__builtin_riscv_xldsp_uraddw_64 ((a), (b)))
#define __rv__rsubw(a, b) \
  (__builtin_riscv_xldsp_rsubw_64 ((a), (b)))
#define __rv__ursubw(a, b) \
  (__builtin_riscv_xldsp_ursubw_64 ((a), (b)))
#define __rv__maxw(a, b) \
  (__builtin_riscv_xldsp_maxw_64 ((a), (b)))
#define __rv__minw(a, b) \
  (__builtin_riscv_xldsp_minw_64 ((a), (b)))
#define __rv__ave(a, b) \
  (__builtin_riscv_xldsp_ave_64 ((a), (b)))
#define __rv__sra_u(a, b) \
  (__builtin_riscv_xldsp_sra_u_64 ((a), (b)))
#define __rv__bitrev(a, b) \
  (__builtin_riscv_xldsp_bitrev_64 ((a), (b)))
#define __rv__smul16(a, b) \
  (__builtin_riscv_xldsp_smul16_64 ((a), (b)))
#define __rv__smulx16(a, b) \
  (__builtin_riscv_xldsp_smulx16_64 ((a), (b)))
#define __rv__umul16(a, b) \
  (__builtin_riscv_xldsp_umul16_64 ((a), (b)))
#define __rv__umulx16(a, b) \
  (__builtin_riscv_xldsp_umulx16_64 ((a), (b)))
#define __rv__smul8(a, b) \
  (__builtin_riscv_xldsp_smul8_64 ((a), (b)))
#define __rv__smulx8(a, b) \
  (__builtin_riscv_xldsp_smulx8_64 ((a), (b)))
#define __rv__umul8(a, b) \
  (__builtin_riscv_xldsp_umul8_64 ((a), (b)))
#define __rv__umulx8(a, b) \
  (__builtin_riscv_xldsp_umulx8_64 ((a), (b)))
#define __rv__mulr64(a, b) \
  (__builtin_riscv_xldsp_mulr64_64 ((a), (b)))
#define __rv__mulsr64(a, b) \
  (__builtin_riscv_xldsp_mulsr64_64 ((a), (b)))
#define __rv__smal(a, b) \
  (__builtin_riscv_xldsp_smal_64 ((a), (b)))
#define __rv__sadd64(a, b) \
  (__builtin_riscv_xldsp_add64_64 ((a), (b)))
#define __rv__uadd64(a, b) \
  (__builtin_riscv_xldsp_add64_64 ((a), (b)))
#define __rv__radd64(a, b) \
  (__builtin_riscv_xldsp_radd64_64 ((a), (b)))
#define __rv__uradd64(a, b) \
  (__builtin_riscv_xldsp_uradd64_64 ((a), (b)))
#define __rv__kadd64(a, b) \
  (__builtin_riscv_xldsp_kadd64_64 ((a), (b)))
#define __rv__ukadd64(a, b) \
  (__builtin_riscv_xldsp_ukadd64_64 ((a), (b)))
#define __rv__ssub64(a, b) \
  (__builtin_riscv_xldsp_sub64_64 ((a), (b)))
#define __rv__usub64(a, b) \
  (__builtin_riscv_xldsp_sub64_64 ((a), (b)))
#define __rv__rsub64(a, b) \
  (__builtin_riscv_xldsp_rsub64_64 ((a), (b)))
#define __rv__ursub64(a, b) \
  (__builtin_riscv_xldsp_ursub64_64 ((a), (b)))
#define __rv__ksub64(a, b) \
  (__builtin_riscv_xldsp_ksub64_64 ((a), (b)))
#define __rv__uksub64(a, b) \
  (__builtin_riscv_xldsp_uksub64_64 ((a), (b)))
#define __rv__smar64(r, a, b) \
  (__builtin_riscv_xldsp_smar64_64 ((r), (a), (b)))
#define __rv__smsr64(r, a, b) \
  (__builtin_riscv_xldsp_smsr64_64 ((r), (a), (b)))
#define __rv__umar64(r, a, b) \
  (__builtin_riscv_xldsp_umar64_64 ((r), (a), (b)))
#define __rv__umsr64(r, a, b) \
  (__builtin_riscv_xldsp_umsr64_64 ((r), (a), (b)))
#define __rv__kmar64(r, a, b) \
  (__builtin_riscv_xldsp_kmar64_64 ((r), (a), (b)))
#define __rv__kmsr64(r, a, b) \
  (__builtin_riscv_xldsp_kmsr64_64 ((r), (a), (b)))
#define __rv__ukmar64(r, a, b) \
  (__builtin_riscv_xldsp_ukmar64_64 ((r), (a), (b)))
#define __rv__ukmsr64(r, a, b) \
  (__builtin_riscv_xldsp_ukmsr64_64 ((r), (a), (b)))
#define __rv__smalbb(r, a, b) \
  (__builtin_riscv_xldsp_smalbb_64 ((r), (a), (b)))
#define __rv__smalbt(r, a, b) \
  (__builtin_riscv_xldsp_smalbt_64 ((r), (a), (b)))
#define __rv__smaltt(r, a, b) \
  (__builtin_riscv_xldsp_smaltt_64 ((r), (a), (b)))
#define __rv__smalda(r, a, b) \
  (__builtin_riscv_xldsp_smalda_64 ((r), (a), (b)))
#define __rv__smalxda(r, a, b) \
  (__builtin_riscv_xldsp_smalxda_64 ((r), (a), (b)))
#define __rv__smalds(r, a, b) \
  (__builtin_riscv_xldsp_smalds_64 ((r), (a), (b)))
#define __rv__smaldrs(r, a, b) \
  (__builtin_riscv_xldsp_smaldrs_64 ((r), (a), (b)))
#define __rv__smalxds(r, a, b) \
  (__builtin_riscv_xldsp_smalxds_64 ((r), (a), (b)))
#define __rv__smslda(r, a, b) \
  (__builtin_riscv_xldsp_smslda_64 ((r), (a), (b)))
#define __rv__smslxda(r, a, b) \
  (__builtin_riscv_xldsp_smslxda_64 ((r), (a), (b)))
#define __rv__wext(a, b) \
  (__builtin_riscv_xldsp_wext_64 ((a), (b)))
#define __rv__wexti(a, b) \
  (__builtin_riscv_xldsp_wexti_64 ((a), (b)))
#define __rv__kmmac(r, a, b) \
  (__builtin_riscv_xldsp_kmmac_64 ((r), (a), (b)))
#define __rv__kmmac_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmac_u_64 ((r), (a), (b)))
#define __rv__kmmsb(r, a, b) \
  (__builtin_riscv_xldsp_kmmsb_64 ((r), (a), (b)))
#define __rv__kmmsb_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmsb_u_64 ((r), (a), (b)))
#define __rv__kmmawb(r, a, b) \
  (__builtin_riscv_xldsp_kmmawb_64 ((r), (a), (b)))
#define __rv__kmmawb_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmawb_u_64 ((r), (a), (b)))
#define __rv__kmmawt(r, a, b) \
  (__builtin_riscv_xldsp_kmmawt_64 ((r), (a), (b)))
#define __rv__kmmawt_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmawt_u_64 ((r), (a), (b)))
#define __rv__kmmawb2(r, a, b) \
  (__builtin_riscv_xldsp_kmmawb2_64 ((r), (a), (b)))
#define __rv__kmmawb2_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmawb2_u_64 ((r), (a), (b)))
#define __rv__kmmawt2(r, a, b) \
  (__builtin_riscv_xldsp_kmmawt2_64 ((r), (a), (b)))
#define __rv__kmmawt2_u(r, a, b) \
  (__builtin_riscv_xldsp_kmmawt2_u_64 ((r), (a), (b)))
#define __rv__kmabb(r, a, b) \
  (__builtin_riscv_xldsp_kmabb_64 ((r), (a), (b)))
#define __rv__kmabt(r, a, b) \
  (__builtin_riscv_xldsp_kmabt_64 ((r), (a), (b)))
#define __rv__kmatt(r, a, b) \
  (__builtin_riscv_xldsp_kmatt_64 ((r), (a), (b)))
#define __rv__kmada(r, a, b) \
  (__builtin_riscv_xldsp_kmada_64 ((r), (a), (b)))
#define __rv__kmaxda(r, a, b) \
  (__builtin_riscv_xldsp_kmaxda_64 ((r), (a), (b)))
#define __rv__kmads(r, a, b) \
  (__builtin_riscv_xldsp_kmads_64 ((r), (a), (b)))
#define __rv__kmadrs(r, a, b) \
  (__builtin_riscv_xldsp_kmadrs_64 ((r), (a), (b)))
#define __rv__kmaxds(r, a, b) \
  (__builtin_riscv_xldsp_kmaxds_64 ((r), (a), (b)))
#define __rv__kmsda(r, a, b) \
  (__builtin_riscv_xldsp_kmsda_64 ((r), (a), (b)))
#define __rv__kmsxda(r, a, b) \
  (__builtin_riscv_xldsp_kmsxda_64 ((r), (a), (b)))
#define __rv__pbsada(r, a, b) \
  (__builtin_riscv_xldsp_pbsada_64 ((r), (a), (b)))
#define __rv__smaqa(r, a, b) \
  (__builtin_riscv_xldsp_smaqa_64 ((r), (a), (b)))
#define __rv__umaqa(r, a, b) \
  (__builtin_riscv_xldsp_umaqa_64 ((r), (a), (b)))
#define __rv__smaqa_su(r, a, b) \
  (__builtin_riscv_xldsp_smaqa_su_64 ((r), (a), (b)))
#define __rv__kdmabb(r, a, b) \
  (__builtin_riscv_xldsp_kdmabb_64 ((r), (a), (b)))
#define __rv__kdmabt(r, a, b) \
  (__builtin_riscv_xldsp_kdmabt_64 ((r), (a), (b)))
#define __rv__kdmatt(r, a, b) \
  (__builtin_riscv_xldsp_kdmatt_64 ((r), (a), (b)))
#define __rv__maddr32(r, a, b) \
  (__builtin_riscv_xldsp_maddr32_64 ((r), (a), (b)))
#define __rv__msubr32(r, a, b) \
  (__builtin_riscv_xldsp_msubr32_64 ((r), (a), (b)))
#define __rv__kabs16(a) \
  (__builtin_riscv_xldsp_kabs16_64 ((a)))
#define __rv__clrs16(a) \
  (__builtin_riscv_xldsp_clrs16_64 ((a)))
#define __rv__clz16(a) \
  (__builtin_riscv_xldsp_clz16_64 ((a)))
#define __rv__clo16(a) \
  (__builtin_riscv_xldsp_clo16_64 ((a)))
#define __rv__kabs8(a) \
  (__builtin_riscv_xldsp_kabs8_64 ((a)))
#define __rv__clrs8(a) \
  (__builtin_riscv_xldsp_clrs8_64 ((a)))
#define __rv__clz8(a) \
  (__builtin_riscv_xldsp_clz8_64 ((a)))
#define __rv__clo8(a) \
  (__builtin_riscv_xldsp_clo8_64 ((a)))
#define __rv__swap8(a) \
  (__builtin_riscv_xldsp_swap8_64 ((a)))
#define __rv__swap16(a) \
  (__builtin_riscv_xldsp_swap16_64 ((a)))
#define __rv__sunpkd810(a) \
  (__builtin_riscv_xldsp_sunpkd810_64 ((a)))
#define __rv__sunpkd820(a) \
  (__builtin_riscv_xldsp_sunpkd820_64 ((a)))
#define __rv__sunpkd830(a) \
  (__builtin_riscv_xldsp_sunpkd830_64 ((a)))
#define __rv__sunpkd831(a) \
  (__builtin_riscv_xldsp_sunpkd831_64 ((a)))
#define __rv__sunpkd832(a) \
  (__builtin_riscv_xldsp_sunpkd832_64 ((a)))
#define __rv__zunpkd810(a) \
  (__builtin_riscv_xldsp_zunpkd810_64 ((a)))
#define __rv__zunpkd820(a) \
  (__builtin_riscv_xldsp_zunpkd820_64 ((a)))
#define __rv__zunpkd830(a) \
  (__builtin_riscv_xldsp_zunpkd830_64 ((a)))
#define __rv__zunpkd831(a) \
  (__builtin_riscv_xldsp_zunpkd831_64 ((a)))
#define __rv__zunpkd832(a) \
  (__builtin_riscv_xldsp_zunpkd832_64 ((a)))
#define __rv__clrs32(a) \
  (__builtin_riscv_xldsp_clrs32_64 ((a)))
#define __rv__clz32(a) \
  (__builtin_riscv_xldsp_clz32_64 ((a)))
#define __rv__clo32(a) \
  (__builtin_riscv_xldsp_clo32_64 ((a)))
#define __rv__kabsw(a) \
  (__builtin_riscv_xldsp_kabsw_64 ((a)))
#define __rv__srai8(a, b) \
  (__builtin_riscv_xldsp_srai8_64 ((a), (b)))
#define __rv__srai8_u(a, b) \
  (__builtin_riscv_xldsp_srai8_u_64 ((a), (b)))
#define __rv__srli8(a, b) \
  (__builtin_riscv_xldsp_srli8_64 ((a), (b)))
#define __rv__srli8_u(a, b) \
  (__builtin_riscv_xldsp_srli8_u_64 ((a), (b)))
#define __rv__slli8(a, b) \
  (__builtin_riscv_xldsp_slli8_64 ((a), (b)))
#define __rv__kslli8(a, b) \
  (__builtin_riscv_xldsp_kslli8_64 ((a), (b)))
#define __rv__sclip8(a, b) \
  (__builtin_riscv_xldsp_sclip8_64 ((a), (b)))
#define __rv__uclip8(a, b) \
  (__builtin_riscv_xldsp_uclip8_64 ((a), (b)))
#define __rv__srai16(a, b) \
  (__builtin_riscv_xldsp_srai16_64 ((a), (b)))
#define __rv__srai16_u(a, b) \
  (__builtin_riscv_xldsp_srai16_u_64 ((a), (b)))
#define __rv__srli16(a, b) \
  (__builtin_riscv_xldsp_srli16_64 ((a), (b)))
#define __rv__srli16_u(a, b) \
  (__builtin_riscv_xldsp_srli16_u_64 ((a), (b)))
#define __rv__slli16(a, b) \
  (__builtin_riscv_xldsp_slli16_64 ((a), (b)))
#define __rv__kslli16(a, b) \
  (__builtin_riscv_xldsp_kslli16_64 ((a), (b)))
#define __rv__sclip16(a, b) \
  (__builtin_riscv_xldsp_sclip16_64 ((a), (b)))
#define __rv__uclip16(a, b) \
  (__builtin_riscv_xldsp_uclip16_64 ((a), (b)))
#define __rv__sclip32(a, b) \
  (__builtin_riscv_xldsp_sclip32_64 ((a), (b)))
#define __rv__uclip32(a, b) \
  (__builtin_riscv_xldsp_uclip32_64 ((a), (b)))
#define __rv__kslliw(a, b) \
  (__builtin_riscv_xldsp_kslliw_64 ((a), (b)))
#define __rv__srai_u(a, b) \
  (__builtin_riscv_xldsp_srai_u_64 ((a), (b)))
#define __rv__bitrevi(a, b) \
  (__builtin_riscv_xldsp_bitrevi_64 ((a), (b)))
#define __rv__bpick(r, a, b) \
  (__builtin_riscv_xldsp_bpick_64 ((r), (a), (b)))
#define __rv__insb(a, b, c) \
  (__builtin_riscv_xldsp_insb_64 ((a), (b), (c)))
#define __rv__add32(a, b) \
  (__builtin_riscv_xldsp_add32 ((a), (b)))
#define __rv__radd32(a, b) \
  (__builtin_riscv_xldsp_radd32 ((a), (b)))
#define __rv__uradd32(a, b) \
  (__builtin_riscv_xldsp_uradd32 ((a), (b)))
#define __rv__kadd32(a, b) \
  (__builtin_riscv_xldsp_kadd32 ((a), (b)))
#define __rv__ukadd32(a, b) \
  (__builtin_riscv_xldsp_ukadd32 ((a), (b)))
#define __rv__sub32(a, b) \
  (__builtin_riscv_xldsp_sub32 ((a), (b)))
#define __rv__rsub32(a, b) \
  (__builtin_riscv_xldsp_rsub32 ((a), (b)))
#define __rv__ursub32(a, b) \
  (__builtin_riscv_xldsp_ursub32 ((a), (b)))
#define __rv__ksub32(a, b) \
  (__builtin_riscv_xldsp_ksub32 ((a), (b)))
#define __rv__uksub32(a, b) \
  (__builtin_riscv_xldsp_uksub32 ((a), (b)))
#define __rv__cras32(a, b) \
  (__builtin_riscv_xldsp_cras32 ((a), (b)))
#define __rv__rcras32(a, b) \
  (__builtin_riscv_xldsp_rcras32 ((a), (b)))
#define __rv__urcras32(a, b) \
  (__builtin_riscv_xldsp_urcras32 ((a), (b)))
#define __rv__kcras32(a, b) \
  (__builtin_riscv_xldsp_kcras32 ((a), (b)))
#define __rv__ukcras32(a, b) \
  (__builtin_riscv_xldsp_ukcras32 ((a), (b)))
#define __rv__crsa32(a, b) \
  (__builtin_riscv_xldsp_crsa32 ((a), (b)))
#define __rv__rcrsa32(a, b) \
  (__builtin_riscv_xldsp_rcrsa32 ((a), (b)))
#define __rv__urcrsa32(a, b) \
  (__builtin_riscv_xldsp_urcrsa32 ((a), (b)))
#define __rv__kcrsa32(a, b) \
  (__builtin_riscv_xldsp_kcrsa32 ((a), (b)))
#define __rv__ukcrsa32(a, b) \
  (__builtin_riscv_xldsp_ukcrsa32 ((a), (b)))
#define __rv__stas32(a, b) \
  (__builtin_riscv_xldsp_stas32 ((a), (b)))
#define __rv__rstas32(a, b) \
  (__builtin_riscv_xldsp_rstas32 ((a), (b)))
#define __rv__urstas32(a, b) \
  (__builtin_riscv_xldsp_urstas32 ((a), (b)))
#define __rv__kstas32(a, b) \
  (__builtin_riscv_xldsp_kstas32 ((a), (b)))
#define __rv__ukstas32(a, b) \
  (__builtin_riscv_xldsp_ukstas32 ((a), (b)))
#define __rv__stsa32(a, b) \
  (__builtin_riscv_xldsp_stsa32 ((a), (b)))
#define __rv__rstsa32(a, b) \
  (__builtin_riscv_xldsp_rstsa32 ((a), (b)))
#define __rv__urstsa32(a, b) \
  (__builtin_riscv_xldsp_urstsa32 ((a), (b)))
#define __rv__kstsa32(a, b) \
  (__builtin_riscv_xldsp_kstsa32 ((a), (b)))
#define __rv__ukstsa32(a, b) \
  (__builtin_riscv_xldsp_ukstsa32 ((a), (b)))
#define __rv__sra32(a, b) \
  (__builtin_riscv_xldsp_sra32 ((a), (b)))
#define __rv__sra32_u(a, b) \
  (__builtin_riscv_xldsp_sra32_u ((a), (b)))
#define __rv__srl32(a, b) \
  (__builtin_riscv_xldsp_srl32 ((a), (b)))
#define __rv__srl32_u(a, b) \
  (__builtin_riscv_xldsp_srl32_u ((a), (b)))
#define __rv__sll32(a, b) \
  (__builtin_riscv_xldsp_sll32 ((a), (b)))
#define __rv__ksll32(a, b) \
  (__builtin_riscv_xldsp_ksll32 ((a), (b)))
#define __rv__kslra32(a, b) \
  (__builtin_riscv_xldsp_kslra32 ((a), (b)))
#define __rv__kslra32_u(a, b) \
  (__builtin_riscv_xldsp_kslra32_u ((a), (b)))
#define __rv__smin32(a, b) \
  (__builtin_riscv_xldsp_smin32 ((a), (b)))
#define __rv__umin32(a, b) \
  (__builtin_riscv_xldsp_umin32 ((a), (b)))
#define __rv__smax32(a, b) \
  (__builtin_riscv_xldsp_smax32 ((a), (b)))
#define __rv__umax32(a, b) \
  (__builtin_riscv_xldsp_umax32 ((a), (b)))
#define __rv__khmbb16(a, b) \
  (__builtin_riscv_xldsp_khmbb16 ((a), (b)))
#define __rv__khmbt16(a, b) \
  (__builtin_riscv_xldsp_khmbt16 ((a), (b)))
#define __rv__khmtt16(a, b) \
  (__builtin_riscv_xldsp_khmtt16 ((a), (b)))
#define __rv__kdmbb16(a, b) \
  (__builtin_riscv_xldsp_kdmbb16 ((a), (b)))
#define __rv__kdmbt16(a, b) \
  (__builtin_riscv_xldsp_kdmbt16 ((a), (b)))
#define __rv__kdmtt16(a, b) \
  (__builtin_riscv_xldsp_kdmtt16 ((a), (b)))
#define __rv__smbt32(a, b) \
  (__builtin_riscv_xldsp_smbt32 ((a), (b)))
#define __rv__smtt32(a, b) \
  (__builtin_riscv_xldsp_smtt32 ((a), (b)))
#define __rv__kmda32(a, b) \
  (__builtin_riscv_xldsp_kmda32 ((a), (b)))
#define __rv__kmxda32(a, b) \
  (__builtin_riscv_xldsp_kmxda32 ((a), (b)))
#define __rv__smds32(a, b) \
  (__builtin_riscv_xldsp_smds32 ((a), (b)))
#define __rv__smdrs32(a, b) \
  (__builtin_riscv_xldsp_smdrs32 ((a), (b)))
#define __rv__smxds32(a, b) \
  (__builtin_riscv_xldsp_smxds32 ((a), (b)))
#define __rv__pkbb32(a, b) \
  (__builtin_riscv_xldsp_pkbb32 ((a), (b)))
#define __rv__pkbt32(a, b) \
  (__builtin_riscv_xldsp_pkbt32 ((a), (b)))
#define __rv__pktt32(a, b) \
  (__builtin_riscv_xldsp_pktt32 ((a), (b)))
#define __rv__pktb32(a, b) \
  (__builtin_riscv_xldsp_pktb32 ((a), (b)))
#define __rv__kdmabb16(r, a, b) \
  (__builtin_riscv_xldsp_kdmabb16 ((r), (a), (b)))
#define __rv__kdmabt16(r, a, b) \
  (__builtin_riscv_xldsp_kdmabt16 ((r), (a), (b)))
#define __rv__kdmatt16(r, a, b) \
  (__builtin_riscv_xldsp_kdmatt16 ((r), (a), (b)))
#define __rv__kmabb32(r, a, b) \
  (__builtin_riscv_xldsp_kmabb32 ((r), (a), (b)))
#define __rv__kmabt32(r, a, b) \
  (__builtin_riscv_xldsp_kmabt32 ((r), (a), (b)))
#define __rv__kmatt32(r, a, b) \
  (__builtin_riscv_xldsp_kmatt32 ((r), (a), (b)))
#define __rv__kmaxda32(r, a, b) \
  (__builtin_riscv_xldsp_kmaxda32 ((r), (a), (b)))
#define __rv__kmads32(r, a, b) \
  (__builtin_riscv_xldsp_kmads32 ((r), (a), (b)))
#define __rv__kmadrs32(r, a, b) \
  (__builtin_riscv_xldsp_kmadrs32 ((r), (a), (b)))
#define __rv__kmaxds32(r, a, b) \
  (__builtin_riscv_xldsp_kmaxds32 ((r), (a), (b)))
#define __rv__kmsda32(r, a, b) \
  (__builtin_riscv_xldsp_kmsda32 ((r), (a), (b)))
#define __rv__kmsxda32(r, a, b) \
  (__builtin_riscv_xldsp_kmsxda32 ((r), (a), (b)))
#define __rv__kabs32(a) \
  (__builtin_riscv_xldsp_kabs32 ((a)))
#define __rv__srai32(a, b) \
  (__builtin_riscv_xldsp_srai32 ((a), (b)))
#define __rv__srai32_u(a, b) \
  (__builtin_riscv_xldsp_srai32_u ((a), (b)))
#define __rv__srli32(a, b) \
  (__builtin_riscv_xldsp_srli32 ((a), (b)))
#define __rv__srli32_u(a, b) \
  (__builtin_riscv_xldsp_srli32_u ((a), (b)))
#define __rv__slli32(a, b) \
  (__builtin_riscv_xldsp_slli32 ((a), (b)))
#define __rv__kslli32(a, b) \
  (__builtin_riscv_xldsp_kslli32 ((a), (b)))
#define __rv__sraiw_u(a, b) \
  (__builtin_riscv_xldsp_sraiw_u ((a), (b)))
#endif

// NUCLEI custom intrinsics
#if __riscv_xlen == 32
#define __expd80(a) \
  (__builtin_riscv_xldsp_expd80_32 ((a)))
#define __expd81(a) \
  (__builtin_riscv_xldsp_expd81_32 ((a)))
#define __expd82(a) \
  (__builtin_riscv_xldsp_expd82_32 ((a)))
#define __expd83(a) \
  (__builtin_riscv_xldsp_expd83_32 ((a)))
#else
#define __expd80(a) \
  (__builtin_riscv_xldsp_expd80_64 ((a)))
#define __expd81(a) \
  (__builtin_riscv_xldsp_expd81_64 ((a)))
#define __expd82(a) \
  (__builtin_riscv_xldsp_expd82_64 ((a)))
#define __expd83(a) \
  (__builtin_riscv_xldsp_expd83_64 ((a)))
#define __expd84(a) \
  (__builtin_riscv_xldsp_expd84 ((a)))
#define __expd85(a) \
  (__builtin_riscv_xldsp_expd85 ((a)))
#define __expd86(a) \
  (__builtin_riscv_xldsp_expd86 ((a)))
#define __expd87(a) \
  (__builtin_riscv_xldsp_expd87 ((a)))
#endif
#endif

// Nuclei custom dsp N1
#if defined(__riscv_xxldspn1x)
#if __riscv_xlen == 32
#define __dkhm8(a, b) \
  (__builtin_riscv_xldsp_dkhm8 ((a), (b)))
#define __dkhm16(a, b) \
  (__builtin_riscv_xldsp_dkhm16 ((a), (b)))
#define __dkabs8(a) \
  (__builtin_riscv_xldsp_dkabs8 ((a)))
#define __dkabs16(a) \
  (__builtin_riscv_xldsp_dkabs16 ((a)))
#define __dkslra8(a, b) \
  (__builtin_riscv_xldsp_dkslra8 ((a), (b)))
#define __dkslra16(a, b) \
  (__builtin_riscv_xldsp_dkslra16 ((a), (b)))
#define __dkadd8(a, b) \
  (__builtin_riscv_xldsp_dkadd8 ((a), (b)))
#define __dkadd16(a, b) \
  (__builtin_riscv_xldsp_dkadd16 ((a), (b)))
#define __dksub8(a, b) \
  (__builtin_riscv_xldsp_dksub8 ((a), (b)))
#define __dksub16(a, b) \
  (__builtin_riscv_xldsp_dksub16 ((a), (b)))
#endif
#endif

// Nuclei custom dsp N2
#if defined(__riscv_xxldspn2x)
#if __riscv_xlen == 32
#define __dkhmx8(a, b) \
  (__builtin_riscv_xldsp_dkhmx8 ((a), (b)))
#define __dkhmx16(a, b) \
  (__builtin_riscv_xldsp_dkhmx16 ((a), (b)))
#define __dsmmul(a, b) \
  (__builtin_riscv_xldsp_dsmmul ((a), (b)))
#define __dsmmul_u(a, b) \
  (__builtin_riscv_xldsp_dsmmul_u ((a), (b)))
#define __dkwmmul(a, b) \
  (__builtin_riscv_xldsp_dkwmmul ((a), (b)))
#define __dkwmmul_u(a, b) \
  (__builtin_riscv_xldsp_dkwmmul_u ((a), (b)))
#define __dkabs32(a) \
  (__builtin_riscv_xldsp_dkabs32 ((a)))
#define __dkslra32(a, b) \
  (__builtin_riscv_xldsp_dkslra32 ((a), (b)))
#define __dkadd32(a, b) \
  (__builtin_riscv_xldsp_dkadd32 ((a), (b)))
#define __dksub32(a, b) \
  (__builtin_riscv_xldsp_dksub32 ((a), (b)))
#define __dradd16(a, b) \
  (__builtin_riscv_xldsp_dradd16 ((a), (b)))
#define __dsub16(a, b) \
  (__builtin_riscv_xldsp_dsub16 ((a), (b)))
#define __dradd32(a, b) \
  (__builtin_riscv_xldsp_dradd32 ((a), (b)))
#define __dsub32(a, b) \
  (__builtin_riscv_xldsp_dsub32 ((a), (b)))
#define __dkmda(a, b) \
  (__builtin_riscv_xldsp_dkmda ((a), (b)))
#define __dkmxda(a, b) \
  (__builtin_riscv_xldsp_dkmxda ((a), (b)))
#define __dsmdrs(a, b) \
  (__builtin_riscv_xldsp_dsmdrs ((a), (b)))
#define __dsmxds(a, b) \
  (__builtin_riscv_xldsp_dsmxds ((a), (b)))
#define __dsmbb32(a, b) \
  (__builtin_riscv_xldsp_dsmbb32 ((a), (b)))
#define __dsmbb32_sra14(a, b) \
  (__builtin_riscv_xldsp_dsmbb32_sra14 ((a), (b)))
#define __dsmbb32_sra32(a, b) \
  (__builtin_riscv_xldsp_dsmbb32_sra32 ((a), (b)))
#define __dsmbt32(a, b) \
  (__builtin_riscv_xldsp_dsmbt32 ((a), (b)))
#define __dsmbt32_sra14(a, b) \
  (__builtin_riscv_xldsp_dsmbt32_sra14 ((a), (b)))
#define __dsmbt32_sra32(a, b) \
  (__builtin_riscv_xldsp_dsmbt32_sra32 ((a), (b)))
#define __dsmtt32(a, b) \
  (__builtin_riscv_xldsp_dsmtt32 ((a), (b)))
#define __dsmtt32_sra14(a, b) \
  (__builtin_riscv_xldsp_dsmtt32_sra14 ((a), (b)))
#define __dsmtt32_sra32(a, b) \
  (__builtin_riscv_xldsp_dsmtt32_sra32 ((a), (b)))
#define __dpkbb32(a, b) \
  (__builtin_riscv_xldsp_dpkbb32 ((a), (b)))
#define __dpkbt32(a, b) \
  (__builtin_riscv_xldsp_dpkbt32 ((a), (b)))
#define __dpack32(a, b) \
  (__builtin_riscv_xldsp_dpack32 ((a), (b)))
#define __dpktt32(a, b) \
  (__builtin_riscv_xldsp_dpktt32 ((a), (b)))
#define __dpktb32(a, b) \
  (__builtin_riscv_xldsp_dpktb32 ((a), (b)))
#define __dpktb16(a, b) \
  (__builtin_riscv_xldsp_dpktb16 ((a), (b)))
#define __dpkbb16(a, b) \
  (__builtin_riscv_xldsp_dpkbb16 ((a), (b)))
#define __dpkbt16(a, b) \
  (__builtin_riscv_xldsp_dpkbt16 ((a), (b)))
#define __dpktt16(a, b) \
  (__builtin_riscv_xldsp_dpktt16 ((a), (b)))
#define __dsra16(a, b) \
  (__builtin_riscv_xldsp_dsra16 ((a), (b)))
#define __dadd16(a, b) \
  (__builtin_riscv_xldsp_dadd16 ((a), (b)))
#define __dadd32(a, b) \
  (__builtin_riscv_xldsp_dadd32 ((a), (b)))
#define __dsmbb16(a, b) \
  (__builtin_riscv_xldsp_dsmbb16 ((a), (b)))
#define __dsmbt16(a, b) \
  (__builtin_riscv_xldsp_dsmbt16 ((a), (b)))
#define __dsmtt16(a, b) \
  (__builtin_riscv_xldsp_dsmtt16 ((a), (b)))
#define __drcrsa16(a, b) \
  (__builtin_riscv_xldsp_drcrsa16 ((a), (b)))
#define __drcras16(a, b) \
  (__builtin_riscv_xldsp_drcras16 ((a), (b)))
#define __dkcrsa16(a, b) \
  (__builtin_riscv_xldsp_dkcrsa16 ((a), (b)))
#define __dkcras16(a, b) \
  (__builtin_riscv_xldsp_dkcras16 ((a), (b)))
#define __drsub16(a, b) \
  (__builtin_riscv_xldsp_drsub16 ((a), (b)))
#define __drsub32(a, b) \
  (__builtin_riscv_xldsp_drsub32 ((a), (b)))
#define __dstsa32(a, b) \
  (__builtin_riscv_xldsp_dstsa32 ((a), (b)))
#define __dstas32(a, b) \
  (__builtin_riscv_xldsp_dstas32 ((a), (b)))
#define __dkcras32(a, b) \
  (__builtin_riscv_xldsp_dkcras32 ((a), (b)))
#define __dkcrsa32(a, b) \
  (__builtin_riscv_xldsp_dkcrsa32 ((a), (b)))
#define __dcrsa32(a, b) \
  (__builtin_riscv_xldsp_dcrsa32 ((a), (b)))
#define __dcras32(a, b) \
  (__builtin_riscv_xldsp_dcras32 ((a), (b)))
#define __dkstsa16(a, b) \
  (__builtin_riscv_xldsp_dkstsa16 ((a), (b)))
#define __dkstas16(a, b) \
  (__builtin_riscv_xldsp_dkstas16 ((a), (b)))
#define __dsclip8(a, b) \
  (__builtin_riscv_xldsp_dsclip8 ((a), (b)))
#define __dsclip16(a, b) \
  (__builtin_riscv_xldsp_dsclip16 ((a), (b)))
#define __dsclip32(a, b) \
  (__builtin_riscv_xldsp_dsclip32 ((a), (b)))
#define __drcrsa32(a, b) \
  (__builtin_riscv_xldsp_drcrsa32 ((a), (b)))
#define __drcras32(a, b) \
  (__builtin_riscv_xldsp_drcras32 ((a), (b)))
#define __dkclip64(a) \
  (__builtin_riscv_xldsp_dkclip64 ((a)))
#define __dmsr16(a, b) \
  (__builtin_riscv_xldsp_dmsr16 ((a), (b)))
#define __dmsr17(a, b) \
  (__builtin_riscv_xldsp_dmsr17 ((a), (b)))
#define __dmsr33(a, b) \
  (__builtin_riscv_xldsp_dmsr33 ((a), (b)))
#define __dmxsr33(a, b) \
  (__builtin_riscv_xldsp_dmxsr33 ((a), (b)))
#define __dredas16(a) \
  (__builtin_riscv_xldsp_dredas16 ((a)))
#define __dredsa16(a) \
  (__builtin_riscv_xldsp_dredsa16 ((a)))
#define __dsunpkd810(a) \
  (__builtin_riscv_xldsp_dsunpkd810 ((a)))
#define __dsunpkd820(a) \
  (__builtin_riscv_xldsp_dsunpkd820 ((a)))
#define __dsunpkd830(a) \
  (__builtin_riscv_xldsp_dsunpkd830 ((a)))
#define __dsunpkd831(a) \
  (__builtin_riscv_xldsp_dsunpkd831 ((a)))
#define __dsunpkd832(a) \
  (__builtin_riscv_xldsp_dsunpkd832 ((a)))
#define __dzunpkd810(a) \
  (__builtin_riscv_xldsp_dzunpkd810 ((a)))
#define __dzunpkd820(a) \
  (__builtin_riscv_xldsp_dzunpkd820 ((a)))
#define __dzunpkd830(a) \
  (__builtin_riscv_xldsp_dzunpkd830 ((a)))
#define __dzunpkd831(a) \
  (__builtin_riscv_xldsp_dzunpkd831 ((a)))
#define __dzunpkd832(a) \
  (__builtin_riscv_xldsp_dzunpkd832 ((a)))
#endif
#endif

// Nuclei custom dsp N3
#if defined(__riscv_xxldspn3x)
#if __riscv_xlen == 32
#define __dkmmac(a, b, c) \
  (__builtin_riscv_xldsp_dkmmac ((a), (b), (c)))
#define __dkmmac_u(a, b, c) \
  (__builtin_riscv_xldsp_dkmmac_u ((a), (b), (c)))
#define __dkmmsb(a, b, c) \
  (__builtin_riscv_xldsp_dkmmsb ((a), (b), (c)))
#define __dkmmsb_u(a, b, c) \
  (__builtin_riscv_xldsp_dkmmsb_u ((a), (b), (c)))
#define __dkmada(a, b, c) \
  (__builtin_riscv_xldsp_dkmada ((a), (b), (c)))
#define __dkmaxda(a, b, c) \
  (__builtin_riscv_xldsp_dkmaxda ((a), (b), (c)))
#define __dkmads(a, b, c) \
  (__builtin_riscv_xldsp_dkmads ((a), (b), (c)))
#define __dkmadrs(a, b, c) \
  (__builtin_riscv_xldsp_dkmadrs ((a), (b), (c)))
#define __dkmaxds(a, b, c) \
  (__builtin_riscv_xldsp_dkmaxds ((a), (b), (c)))
#define __dkmsda(a, b, c) \
  (__builtin_riscv_xldsp_dkmsda ((a), (b), (c)))
#define __dkmsxda(a, b, c) \
  (__builtin_riscv_xldsp_dkmsxda ((a), (b), (c)))
#define __dsmaqa(a, b, c) \
  (__builtin_riscv_xldsp_dsmaqa ((a), (b), (c)))
#define __dsmaqa_su(a, b, c) \
  (__builtin_riscv_xldsp_dsmaqa_su ((a), (b), (c)))
#define __dumaqa(a, b, c) \
  (__builtin_riscv_xldsp_dumaqa ((a), (b), (c)))
#define __dkmda32(a, b) \
  (__builtin_riscv_xldsp_dkmda32 ((a), (b)))
#define __dkmxda32(a, b) \
  (__builtin_riscv_xldsp_dkmxda32 ((a), (b)))
#define __dkmada32(a, b, c) \
  (__builtin_riscv_xldsp_dkmada32 ((a), (b), (c)))
#define __dkmaxda32(a, b, c) \
  (__builtin_riscv_xldsp_dkmaxda32 ((a), (b), (c)))
#define __dkmads32(a, b, c) \
  (__builtin_riscv_xldsp_dkmads32 ((a), (b), (c)))
#define __dkmadrs32(a, b, c) \
  (__builtin_riscv_xldsp_dkmadrs32 ((a), (b), (c)))
#define __dkmaxds32(a, b, c) \
  (__builtin_riscv_xldsp_dkmaxds32 ((a), (b), (c)))
#define __dkmsda32(a, b, c) \
  (__builtin_riscv_xldsp_dkmsda32 ((a), (b), (c)))
#define __dkmsxda32(a, b, c) \
  (__builtin_riscv_xldsp_dkmsxda32 ((a), (b), (c)))
#define __dsmds32(a, b) \
  (__builtin_riscv_xldsp_dsmds32 ((a), (b)))
#define __dsmdrs32(a, b) \
  (__builtin_riscv_xldsp_dsmdrs32 ((a), (b)))
#define __dsmxds32(a, b) \
  (__builtin_riscv_xldsp_dsmxds32 ((a), (b)))
#define __dsmalda(a, b, c) \
  (__builtin_riscv_xldsp_dsmalda ((a), (b), (c)))
#define __dsmalxda(a, b, c) \
  (__builtin_riscv_xldsp_dsmalxda ((a), (b), (c)))
#define __dsmalds(a, b, c) \
  (__builtin_riscv_xldsp_dsmalds ((a), (b), (c)))
#define __dsmaldrs(a, b, c) \
  (__builtin_riscv_xldsp_dsmaldrs ((a), (b), (c)))
#define __dsmalxds(a, b, c) \
  (__builtin_riscv_xldsp_dsmalxds ((a), (b), (c)))
#define __dsmslda(a, b, c) \
  (__builtin_riscv_xldsp_dsmslda ((a), (b), (c)))
#define __dsmslxda(a, b, c) \
  (__builtin_riscv_xldsp_dsmslxda ((a), (b), (c)))
#define __ddsmaqa(a, b, c) \
  (__builtin_riscv_xldsp_ddsmaqa ((a), (b), (c)))
#define __ddsmaqa_su(a, b, c) \
  (__builtin_riscv_xldsp_ddsmaqa_su ((a), (b), (c)))
#define __ddumaqa(a, b, c) \
  (__builtin_riscv_xldsp_ddumaqa ((a), (b), (c)))
#define __dsmada16(a, b, c) \
  (__builtin_riscv_xldsp_dsmada16 ((a), (b), (c)))
#define __dsmaxda16(a, b, c) \
  (__builtin_riscv_xldsp_dsmaxda16 ((a), (b), (c)))
#define __dksms32_u(a, b, c) \
  (__builtin_riscv_xldsp_dksms32_u ((a), (b), (c)))
#define __dmada32(a, b, c) \
  (__builtin_riscv_xldsp_dmada32 ((a), (b), (c)))
#define __dsma32_u(a, b) \
  (__builtin_riscv_xldsp_dsma32_u ((a), (b)))
#define __dsmxs32_u(a, b) \
  (__builtin_riscv_xldsp_dsmxs32_u ((a), (b)))
#define __dsmxa32_u(a, b) \
  (__builtin_riscv_xldsp_dsmxa32_u ((a), (b)))
#define __dsms32_u(a, b) \
  (__builtin_riscv_xldsp_dsms32_u ((a), (b)))
#define __dsmalbb(a, b, c) \
  (__builtin_riscv_xldsp_dsmalbb ((a), (b), (c)))
#define __dsmalbt(a, b, c) \
  (__builtin_riscv_xldsp_dsmalbt ((a), (b), (c)))
#define __dsmaltt(a, b, c) \
  (__builtin_riscv_xldsp_dsmaltt ((a), (b), (c)))
#define __dkmabb32(a, b, c) \
  (__builtin_riscv_xldsp_dkmabb32 ((a), (b), (c)))
#define __dkmabt32(a, b, c) \
  (__builtin_riscv_xldsp_dkmabt32 ((a), (b), (c)))
#define __dkmatt32(a, b, c) \
  (__builtin_riscv_xldsp_dkmatt32 ((a), (b), (c)))
#endif
#endif

#endif
