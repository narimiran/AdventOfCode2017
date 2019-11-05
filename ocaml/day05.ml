let instructions =
  CCIO.(with_in "inputs/05.txt" read_lines_l)
  |> List.map int_of_string

let l = List.length instructions


let rec iterate part line steps instructions =
  let jump = instructions.(line) in
  let inc = if part = 2 && jump >= 3 then -1 else 1 in
  let next_line = line + jump in
  let steps = steps + 1 in
  if next_line >= l then steps
  else
    (instructions.(line) <- jump + inc;
     iterate part next_line steps instructions)


let solve instr ~part =
  instr
  |> Array.of_list
  |> iterate part 0 0
  |> Printf.printf "%d\n"


let first = solve instructions ~part:1
let second = solve instructions ~part:2
