let input, len =
  CCIO.(with_in "inputs/01.txt" read_all)
  |> CCString.to_array
  |> Array.map (fun x -> Char.code x - Char.code '0')
  |> fun x -> x, Array.length x


let find_sum jump =
  let pairwise_with_step step xs =
    Array.mapi (fun i n -> (n, xs.((i+step) mod len))) xs
  in
  input
  |> pairwise_with_step jump
  |> Array.fold_left
    (fun acc (a, b) -> if a = b then acc + a else acc)
    0
  |> Printf.printf "%d\n"


let first = find_sum 1
let second = find_sum (len / 2)
