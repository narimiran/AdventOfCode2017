let numbers =
  CCIO.(with_in "inputs/02.txt" read_lines_l)
  |> List.map CCFun.(String.split_on_char '\t' %> List.map int_of_string)

let diff row =
  let max_val = List.fold_left max min_int row in
  let min_val = List.fold_left min max_int row in
  max_val - min_val


let rec find_divisors row =
  let are_divisible a b =
    a mod b = 0 || b mod a = 0 in
  let divide a b =
    if a mod b = 0 then a/b else b/a
  in
  match row with
  | [] -> 0
  | h :: t ->
    match List.find_opt (are_divisible h) t with
    | Some x -> divide h x
    | None -> find_divisors t


let solve ~part =
  let func = if part = 1 then diff else find_divisors in
  numbers
  |> List.fold_left (fun acc x -> func x + acc) 0
  |> Printf.printf "%d\n"

let () =
  solve ~part:1;
  solve ~part:2
