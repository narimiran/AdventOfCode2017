let rec generate v factor m =
  let divisor = 2147483647 in
  let nv = ref (v * factor) in
  while !nv >= divisor do
    nv := (!nv land divisor) + (!nv lsr 31)
  done;
  if !nv land (m - 1) = 0 then !nv
  else generate !nv factor m

let solve iter mA mB =
  let fA = 16807 in
  let fB = 48271 in
  let a = ref 699 in
  let b = ref 124 in
  let tot = ref 0 in
  for _ = 1 to iter do
    a := generate !a fA mA;
    b := generate !b fB mB;
    if !a land 0xffff = !b land 0xffff then incr tot
  done;
  !tot |> Printf.printf "%d\n"


let first = solve 40_000_000 1 1
let second = solve 5_000_000 4 8
