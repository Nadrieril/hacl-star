module Memcpy

open LowStar.Buffer
module B = LowStar.Buffer
module BV = LowStar.BufferView
open LowStar.Modifies
module M = LowStar.Modifies
open LowStar.ModifiesPat
open FStar.HyperStack.ST
module HS = FStar.HyperStack
open Interop
open Words_s
open Types_s

let pre_cond (h:HS.mem) (dst:b8) (src:b8) = live h dst /\ live h src /\ bufs_disjoint [dst;src] /\ length dst % 8 == 0 /\ length src % 8 == 0 /\ length dst == 16 /\ length src == 16

let post_cond (h:HS.mem) (h':HS.mem) (dst:b8) (src:b8) =
  live h dst /\ live h src /\ 
  live h' dst /\ live h' src /\
  length dst % 8 == 0 /\ length src % 8 == 0 /\
  (let dst_b = BV.mk_buffer_view dst Views.view64 in
  let src_b = BV.mk_buffer_view src Views.view64 in
  Seq.equal (BV.as_seq h' dst_b) (BV.as_seq h' src_b))

let full_post_cond (h:HS.mem) (h':HS.mem) (dst:b8) (src:b8)  =
  post_cond h h' dst src  /\
  M.modifies (M.loc_buffer dst) h h'

[@ (CCConv "stdcall") ]
val memcpy: dst:b8 -> src:b8 -> Stack unit
	(requires (fun h -> pre_cond h dst src ))
	(ensures (fun h0 _ h1 -> full_post_cond h0 h1 dst src ))
