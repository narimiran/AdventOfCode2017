let input = CCIO.(with_in "inputs/10.txt" read_all)


let part_1 =
  let int_sizes =
    input
    |> String.split_on_char ','
    |> List.map int_of_string
  in
  let hash = KnotHash.knot_logic int_sizes 1 in
  hash.(0) * hash.(1) |> Printf.printf "%d\n"


let part_2 = input |> KnotHash.knot_hashing |> Printf.printf "%s\n"
