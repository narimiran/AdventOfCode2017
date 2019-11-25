let steps = 12667664
let states = [|
  [| (1,  1, 1); (0, -1, 2) |];
  [| (1, -1, 0); (1,  1, 3) |];
  [| (0, -1, 1); (0, -1, 4) |];
  [| (1,  1, 0); (0,  1, 1) |];
  [| (1, -1, 5); (1, -1, 2) |];
  [| (1,  1, 3); (1,  1, 0) |];
|]

let solve steps =
  let start_pos = 6000 in
  let tape = Array.make 6100 0
  in
  let rec aux pos state rem =
    if rem = 0 then Array.fold_left (+) 0 tape
    else
      let (write, move, state') = states.(state).(tape.(pos)) in
      tape.(pos) <- write;
      aux (pos+move) state' (rem-1)
  in
  aux start_pos 0 steps

let solution = solve steps |> Printf.printf "%d\n"
