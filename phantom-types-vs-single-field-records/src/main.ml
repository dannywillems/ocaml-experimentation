type 'a t = { inner : 'a }

let () =
  let x = { inner = Bls12_381.Fr.one } in
  Printf.printf
    "Reachable words inner: %d\nSize inner: %d\n"
    (Obj.reachable_words (Obj.repr x))
    (Obj.size (Obj.repr x)) ;
  let x' = Bls12_381.Fr.one in
  Printf.printf
    "Reachable words plain: %d\nSize plain: %d\n"
    (Obj.reachable_words (Obj.repr x'))
    (Obj.size (Obj.repr x'))
