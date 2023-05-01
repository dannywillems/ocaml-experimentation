Phantom types vs single-field records
==============================

Comparing performances of phantom types (`type 'a t = 'a`) vs single field records (`type 'a t = { inner: 'a }`)

When a record has only one field, does OCaml get rid of the record field to remove one indirection?
A record will require one indirection, and will take 2 additional words (one for the
header, one for the memory location of the content of the first field).

Testing with [bls12-381](https://gitlab.com/nomadic-labs/cryptography/ocaml-bls12-381) which does use a custom block for some structures like `Bls12_381.Fr`. The idea is to try with composite values or custom blocks.

## Results

On OCaml 4.14.0, the following program:
```
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
```

gives
```
Reachable words inner: 8
Size inner: 1
Reachable words plain: 6
Size plain: 5
```

## Run

```
opam switch create ./ 4.14.0
opam install ocamlformat.0.25.1 merlin core_bench core_unix bls12-381
```
