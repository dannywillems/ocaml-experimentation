open Core_bench

type 'a t = { inner : 'a }

let b1 =
  let x1_r = { inner = Bls12_381.Fr.one } in
  let x2_r = { inner = Bls12_381.Fr.one } in
  Bench.Test.create ~name:"Bench within records" (fun () ->
      Bls12_381.Fr.(x1_r.inner + x2_r.inner))

let b2 =
  let x1 = Bls12_381.Fr.one in
  let x2 = Bls12_381.Fr.one in
  Bench.Test.create ~name:"Bench without records" (fun () ->
      Bls12_381.Fr.(x1 + x2))

let () = Command_unix.run (Core_bench.Bench.make_command [b1; b2])
