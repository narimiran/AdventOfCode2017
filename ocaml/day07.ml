module StrMap = Map.Make(String)
module StrSet = Set.Make(String)
module IntSet = Set.Make(Int)
module Regex = Str

let r = Regex.regexp {|\([a-z]+\) (\([0-9]+\))\($\| -> \(.+\)\)|}

let parse_row s =
  if Regex.string_match r s 0 then
    let name = Regex.matched_group 1 s in
    let weight = Regex.matched_group 2 s |> int_of_string in
    let kids =
      if Regex.matched_group 3 s = "" then []
      else CCString.split ~by:", " (Regex.matched_group 4 s)
    in
    (name, weight, kids)
  else ("", 0, [])

let input = List.map parse_row CCIO.(with_in "inputs/07.txt" read_lines_l)

let create_map f =
  List.fold_left f StrMap.empty
let get_weights =
  create_map (fun a (n, w, _) -> StrMap.add n w a)
let get_relations =
  create_map (fun a (n, _, k) -> StrMap.add n k a)

let weights = get_weights input
let relations = get_relations input


let rec total_node_weight node =
  let own_weight = StrMap.find node weights in
  let kids = StrMap.find node relations in
  let kids_weights = List.map total_node_weight kids in
  own_weight + List.fold_left (+) 0 kids_weights


let find_different_weights kids =
  if CCList.is_empty kids then None
  else
    let kids_weights = List.map total_node_weight kids in
    let w_set = IntSet.of_list kids_weights in
    if IntSet.cardinal w_set = 1 then None
    else
      let min_w = IntSet.min_elt w_set in
      let max_w = IntSet.max_elt w_set in
      let count v =
        kids_weights
        |> List.filter (fun w -> w = v)
        |> List.length in
      let min_count = count min_w in
      let max_count = count max_w in
      let (wrong_w, right_w) =
        if min_count < max_count then (min_w, max_w) else (max_w, min_w) in
      let wrong_i, _ =
        CCList.find_idx (fun x -> x = wrong_w) kids_weights
        |> Option.value ~default:(0, 0) in
      let wrong_kid = List.nth kids wrong_i in
      Some (wrong_kid, right_w)


let rec find_correct_weight node right_w =
  let kids = StrMap.find node relations in
  match find_different_weights kids with
  | Some (wrong_kid, right_w) ->
    find_correct_weight wrong_kid right_w
  | None ->
    let kids_weights = List.map total_node_weight kids in
    let kids_total_w = List.fold_left (+) 0 kids_weights in
    right_w - kids_total_w


let create_set f =
  List.fold_left f StrSet.empty
let get_nodes =
  create_set (fun a (n, _, _) -> StrSet.add n a)
let get_kids =
  create_set (fun a (_, _, k) -> StrSet.union a (StrSet.of_list k))

let nodes = get_nodes input
let kids = get_kids input
let root = StrSet.diff nodes kids |> StrSet.choose

let first = root |> Printf.printf "%s\n"
let second = find_correct_weight root 0 |> Printf.printf "%d\n"
