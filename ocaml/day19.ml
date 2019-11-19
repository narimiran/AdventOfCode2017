open Complex

let instructions =
  CCIO.(with_in "inputs/19.txt" read_lines_l) |> Array.of_list

let left_turn = { re = 0.; im = -1. }
let right_turn = { re = 0.; im = 1. }


let get_char pos =
  let x = int_of_float pos.im in
  let y = int_of_float pos.re in
  instructions.(x).[y]

let change pos direction =
  if get_char (add pos (mul left_turn direction)) != ' '
  then mul direction left_turn
  else mul direction right_turn

let is_letter c =
  int_of_char c >= 65 && int_of_char c <= 90

let rec walk pos direction letters steps =
  let c = get_char pos in
  match c with
  | ' ' ->
    let word = CCString.of_list (List.rev letters) in
    word, steps
  | _ ->
    let letters' = if is_letter c then (c :: letters) else letters in
    let direction' = if c = '+' then change pos direction else direction in
    let pos' = add pos direction' in
    walk pos' direction' letters' (steps+1)


let pos =
  let first_row = instructions.(0) in
  let x = String.index first_row '|' |> float_of_int in
  { re = x; im = 0.0 }
let direction = { re = 0.; im = 1. }

let first, second = walk pos direction [] 0
let () =
  Printf.printf "%s\n" first;
  Printf.printf "%d\n" second
