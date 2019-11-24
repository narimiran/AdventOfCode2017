module Component = struct
  type t = int * int

  let compare (x1, y1) (x2, y2) =
    match Int.compare x1 x2 with
    | 0 -> Int.compare y1 y2
    | v -> v

  let of_string line =
    let pins = String.split_on_char '/' line |> List.map int_of_string in
    match pins with
    | [a; b] -> (a, b)
    | _ -> failwith "invalid input"

  let is_connectable_to x (a, b) =
    x = a || x = b

  let other_end x (a, b) =
    if x = a then b else a
end

module CompSet = Set.Make(Component)


let parse filename =
  CCIO.(with_in filename read_lines_l)
  |> List.map Component.of_string
  |> CompSet.of_list


let create_bridges components =
  let rec aux available current result =
    let connectable = CompSet.filter (Component.is_connectable_to current) available in
    if CompSet.is_empty connectable then [result]
    else
      let connectable, available, result =
        if CompSet.exists (fun (a, b) -> a = b) connectable then
          let double = (current, current) in
          let connectable' = CompSet.remove double connectable in
          let available' = CompSet.remove double available in
          let result' = double :: result in
          (connectable', available', result')
        else (connectable, available, result)
      in
      CompSet.fold
        (fun component acc ->
           let available' = CompSet.remove component available in
           let current' = Component.other_end current component in
           acc @ (aux available' current' (component :: result)))
        connectable
        []
  in
  aux components 0 []


let bridge_strength =
  List.fold_left (fun acc (a, b) -> acc + a + b) 0


let components = parse "inputs/24.txt"
let bridges = create_bridges components

let first =
  bridges
  |> List.fold_left
    (fun acc bridge -> CCInt.max acc (bridge_strength bridge))
    0
  |> Printf.printf "%d\n"

let second =
  bridges
  |> List.fold_left
    (fun acc bridge ->
       let l = List.length bridge in
       let s = bridge_strength bridge in
       if Component.compare acc (l, s) > 0 then acc else (l, s))
    (0, 0)
  |> snd
  |> Printf.printf "%d\n"
