module Strset = Set.Make(String)

let input =
  CCIO.(with_in "inputs/04.txt" read_lines_l)
  |> List.map (String.split_on_char ' ')

let count_valid lines =
  let only_distinct_words line =
    let original_length = List.length line in
    let distinct_length = line |> Strset.of_list |> Strset.cardinal in
    original_length = distinct_length
  in
  lines |> List.filter only_distinct_words |> List.length

let anagrams lines =
  let sort_chars line =
    line
    |> CCString.to_list
    |> List.sort Char.compare
    |> CCString.of_list
  in
  List.map (List.map sort_chars) lines


let solve = CCFun.(count_valid %> Printf.printf "%d\n")

let part_1 = input |> solve
let part_2 = input |> anagrams |> solve
