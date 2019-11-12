let parse line =
  line
  |> CCString.split ~by:" <-> "
  |> CCList.get_at_idx_exn 1
  |> CCString.split ~by:", "
  |> List.map int_of_string

let create_graph filename =
  let input = CCIO.(with_in filename read_lines_l) in
  let len = List.length input in
  let result = Array.make len [] in
  List.iteri (fun i l -> result.(i) <- parse l) input;
  result

let graph = create_graph "inputs/12.txt"
let seen = Array.make (Array.length graph) false

module Intset = Set.Make(Int)


let map_island x =
  let island = ref Intset.empty
  in
  let rec dfs x =
    island := Intset.add x !island;
    List.iter
      (fun y -> if not (Intset.mem y !island) then dfs y)
      graph.(x)
  in
  dfs x;
  !island


let groups =
  let add_to_seen island =
    Intset.iter (fun x -> seen.(x) <- true) island in
  let n = ref 0 in
  let last = Array.length graph - 1
  in
  for i = 0 to last do
    if not seen.(i) then begin
      add_to_seen (map_island i);
      incr n
    end
  done;
  !n


let part_1 = map_island 0 |> Intset.cardinal |> Printf.printf "%d\n"
let part_2 = groups |> Printf.printf "%d\n"
