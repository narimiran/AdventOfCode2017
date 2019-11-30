let input =
  CCIO.(with_in "inputs/01.txt" read_all)
  |> CCString.to_array
  |> Array.map (fun x -> Char.code x - Char.code '0')

let find_sum ~part input =
  let len = Array.length input in
  let jump = if part = 1 then 1 else len / 2 in
  let pairwise_with_step step xs =
    Array.mapi (fun i n -> (n, xs.((i + step) mod len))) xs
  in
  input
  |> pairwise_with_step jump
  |> Array.fold_left (fun acc (a, b) -> if a = b then acc + a else acc) 0
  |> Printf.printf "%d\n"

let () =
  input |> find_sum ~part:1;
  input |> find_sum ~part:2
