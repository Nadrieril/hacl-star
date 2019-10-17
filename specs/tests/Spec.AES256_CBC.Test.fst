module Spec.AES256_CBC.Test

open Lib.IntTypes
open Lib.RawIntTypes
open Lib.Sequence
open Spec.AES256_CBC
open Lib.LoopCombinators

#set-options "--lax"

let test1_input_key = of_list (List.Tot.map u8 [
  0x60; 0x3d; 0xeb; 0x10; 0x15; 0xca; 0x71; 0xbe;
  0x2b; 0x73; 0xae; 0xf0; 0x85; 0x7d; 0x77; 0x81;
  0x1f; 0x35; 0x2c; 0x07; 0x3b; 0x61; 0x08; 0xd7;
  0x2d; 0x98; 0x10; 0xa3; 0x09; 0x14; 0xdf; 0xf4
])

let test1_input_iv = of_list (List.Tot.map u8 [
  0x00; 0x01; 0x02; 0x03; 0x04; 0x05; 0x06; 0x07;
  0x08; 0x09; 0x0A; 0x0B; 0x0C; 0x0D; 0x0E; 0x0F
])

let test1_input_plaintext = of_list (List.Tot.map u8 [
  0x6b; 0xc1; 0xbe; 0xe2; 0x2e; 0x40; 0x9f; 0x96;
  0xe9; 0x3d; 0x7e; 0x11; 0x73; 0x93; 0x17; 0x2a
])

let test1_output_ciphertext = of_list (List.Tot.map u8 [
  0xf5; 0x8c; 0x4c; 0x04; 0xd6; 0xe5; 0xf1; 0xba;
  0x77; 0x9e; 0xab; 0xfb; 0x5f; 0x7b; 0xfb; 0xd6;
  0x48; 0x5a; 0x5c; 0x81; 0x51; 0x9c; 0xf3; 0x78;
  0xfa; 0x36; 0xd4; 0x2b; 0x85; 0x47; 0xed; 0xc0
])

let test2_input_key = of_list (List.Tot.map u8 [
  0x60; 0x3d; 0xeb; 0x10; 0x15; 0xca; 0x71; 0xbe;
  0x2b; 0x73; 0xae; 0xf0; 0x85; 0x7d; 0x77; 0x81;
  0x1f; 0x35; 0x2c; 0x07; 0x3b; 0x61; 0x08; 0xd7;
  0x2d; 0x98; 0x10; 0xa3; 0x09; 0x14; 0xdf; 0xf4
])

let test2_input_iv = of_list (List.Tot.map u8 [
  0x00; 0x01; 0x02; 0x03; 0x04; 0x05; 0x06; 0x07;
  0x08; 0x09; 0x0A; 0x0B; 0x0C; 0x0D; 0x0E; 0x0F
])

let test2_input_plaintext = of_list (List.Tot.map u8 [
    0x6b; 0xc1; 0xbe; 0xe2; 0x2e; 0x40; 0x9f; 0x96;
    0xe9; 0x3d; 0x7e; 0x11; 0x73; 0x93; 0x17; 0x2a;
    0xae; 0x2d; 0x8a; 0x57; 0x1e; 0x03; 0xac; 0x9c;
    0x9e; 0xb7; 0x6f; 0xac; 0x45; 0xaf; 0x8e; 0x51;
    0x30; 0xc8; 0x1c; 0x46; 0xa3; 0x5c; 0xe4; 0x11;
    0xe5; 0xfb; 0xc1; 0x19; 0x1a; 0x0a; 0x52; 0xef;
    0xf6; 0x9f; 0x24; 0x45; 0xdf; 0x4f; 0x9b; 0x17;
    0xad; 0x2b; 0x41; 0x7b; 0xe6; 0x6c; 0x37; 0x10
])

let test2_output_ciphertext = of_list (List.Tot.map u8 [
    0xf5; 0x8c; 0x4c; 0x04; 0xd6; 0xe5; 0xf1; 0xba;
    0x77; 0x9e; 0xab; 0xfb; 0x5f; 0x7b; 0xfb; 0xd6;
    0x9c; 0xfc; 0x4e; 0x96; 0x7e; 0xdb; 0x80; 0x8d;
    0x67; 0x9f; 0x77; 0x7b; 0xc6; 0x70; 0x2c; 0x7d;
    0x39; 0xf2; 0x33; 0x69; 0xa9; 0xd9; 0xba; 0xcf;
    0xa5; 0x30; 0xe2; 0x63; 0x04; 0x23; 0x14; 0x61;
    0xb2; 0xeb; 0x05; 0xe2; 0xc3; 0x9b; 0xe9; 0xfc;
    0xda; 0x6c; 0x19; 0x07; 0x8c; 0x6a; 0x9d; 0x1b;
    0x3f; 0x46; 0x17; 0x96; 0xd6; 0xb0; 0xd6; 0xb2;
    0xe0; 0xc2; 0xa7; 0x2b; 0x4d; 0x80; 0xe6; 0x44
])

let test3_input_key = of_list (List.Tot.map u8 [
    0x67; 0x2d; 0x38; 0xdd; 0x4b; 0x90; 0xaa; 0xde;
    0x77; 0x68; 0x79; 0xeb; 0x9e; 0x2a; 0xda; 0xc0;
    0x56; 0x61; 0xb5; 0x24; 0xe0; 0x68; 0x21; 0xc4;
    0x34; 0xe3; 0xec; 0x53; 0x58; 0xd0; 0xc8; 0xce
])

let test3_input_iv = of_list (List.Tot.map u8 [
    0xfb; 0xff; 0xa2; 0xa3; 0x4e; 0xe5; 0x08; 0x38;
    0xcb; 0xee; 0x1b; 0x3a; 0x3c; 0xf1; 0x3f; 0xfc
])

let test3_input_plaintext = of_list (List.Tot.map u8 [
    0x0a; 0x01; 0x41; 0x80; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;
    0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00
])

let test3_output_ciphertext = of_list (List.Tot.map u8 [
    0x3c; 0x5d; 0x07; 0x0d; 0x1b; 0x75; 0xc4; 0x18;
    0xce; 0xf7; 0x69; 0xbd; 0x73; 0x78; 0xa5; 0x89;
    0x69; 0x53; 0x7a; 0x00; 0xe0; 0xff; 0x60; 0xcb;
    0xb9; 0x9d; 0xef; 0xb4; 0x86; 0xfc; 0xfb; 0x43;
    0x38; 0x42; 0x64; 0xda; 0x4e; 0xa9; 0x82; 0x1c;
    0x13; 0x36; 0xf0; 0x2d; 0x98; 0x8d; 0xa3; 0x89;
    0x44; 0x45; 0x33; 0x31; 0xc4; 0xb3; 0x01; 0x81;
    0x70; 0x4c; 0xbc; 0xec; 0x5a; 0x79; 0x2a; 0xb8;
    0x7c; 0x5c; 0xcf; 0xf2; 0x56; 0xe0; 0xb4; 0xd6;
    0x1b; 0xa6; 0xa3; 0x0a; 0x69; 0x64; 0x78; 0x38;
    0x75; 0x01; 0x88; 0x82; 0xe6; 0x6b; 0xfb; 0xd9;
    0x44; 0x5a; 0xc4; 0x4f; 0xee; 0x9d; 0xc6; 0x7e;
    0xdc; 0x2a; 0xd9; 0xde; 0x78; 0xad; 0xbe; 0x0e;
    0xb7; 0xe9; 0xcb; 0x99; 0x02; 0x72; 0x18; 0x3c;
    0xe5; 0xfa; 0xc6; 0x82; 0xee; 0x51; 0x06; 0xf6;
    0x7d; 0x73; 0x2c; 0xd1; 0x6d; 0xfb; 0x73; 0x12;
    0x39; 0x59; 0x0b; 0xa6; 0x7d; 0xc8; 0x27; 0xe8;
    0x49; 0xc4; 0x9a; 0x9f; 0xb5; 0xed; 0x8e; 0xed;
    0x41; 0xd8; 0x5d; 0x5e; 0x6d; 0xe3; 0x29; 0x4e;
    0x74; 0xf3; 0x52; 0x4c; 0x64; 0x89; 0xc2; 0xf2
])

let test_compare_buffers (msg:string) (expected:seq uint8) (computed:seq uint8) =
  IO.print_string "\n";
  IO.print_string msg;
  IO.print_string "\nexpected (";
  IO.print_uint32_dec (UInt32.uint_to_t (length expected));
  IO.print_string "):\n";
  FStar.List.iter (fun a -> IO.print_uint8_hex_pad (u8_to_UInt8 a)) (to_list expected);
  IO.print_string "\n";
  IO.print_string "computed (";
  IO.print_uint32_dec (UInt32.uint_to_t (length computed));
  IO.print_string "):\n";
  FStar.List.iter (fun a -> IO.print_uint8_hex_pad (u8_to_UInt8 a)) (to_list computed);
  IO.print_string "\n";
  let result =
    if length computed <> length expected then false else
    for_all2 #uint8 #uint8 #(length computed) (fun x y -> uint_to_nat #U8 x = uint_to_nat #U8 y)
      computed expected
  in
  if result then IO.print_string "\nSuccess !\n"
  else IO.print_string "\nFailed !\n"

let test() : FStar.All.ML unit =
  let computed1 = aes256_cbc_encrypt test1_input_key test1_input_iv test1_input_plaintext (length test1_input_plaintext) in
  test_compare_buffers "TEST1: encryption of one block" test1_output_ciphertext computed1;
  let computed2 = aes256_cbc_decrypt test1_input_key test1_input_iv computed1 (length computed1) in
  begin match computed2 with
  | Some computed2 ->
    test_compare_buffers "TEST2: decryption of the previous block" test1_input_plaintext computed2
  | None -> IO.print_string "TEST2: decryption of the previous block : Failure\n"
  end;

  let computed3 = aes256_cbc_encrypt test2_input_key test2_input_iv test2_input_plaintext (length test2_input_plaintext) in
  test_compare_buffers "TEST3: encryption of message" test2_output_ciphertext computed3;
  let computed4 = aes256_cbc_decrypt test2_input_key test2_input_iv computed3 (length computed3) in
  begin match computed4 with
  | Some computed4 ->
    test_compare_buffers "TEST4: decryption of the previous message" test2_input_plaintext computed4
  | None -> IO.print_string "TEST4: decryption of the previous message : Failure\n"
  end;
  let computed4 = aes256_cbc_encrypt test3_input_key test3_input_iv test3_input_plaintext (length test3_input_plaintext) in
  test_compare_buffers "TEST4: encryption of Signal message" test3_output_ciphertext computed4;
  let computed5 = aes256_cbc_decrypt test3_input_key test3_input_iv computed4 (length computed4) in
  begin match computed5 with
  | Some computed5 ->
    test_compare_buffers "TEST5: decryption of the previous Signal message" test3_input_plaintext computed5
  | None -> IO.print_string "TEST5: decryption of the previous Signal message : Failure\n"
  end
