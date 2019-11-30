let input =
  CCIO.(with_in "inputs/05.txt" read_lines_l)
  |> List.map int_of_string

let rec iterate part line steps l instr =
  let jump = instr.(line) in
  let inc = if part = 2 && jump >= 3 then -1 else 1 in
  let next_line = line + jump in
  let steps = steps + 1 in
  if next_line >= l then steps
  else (
    instr.(line) <- jump + inc;
    iterate part next_line steps l instr )

let solve ~part input =
  let l = List.length input in
  input
  |> Array.of_list
  |> iterate part 0 0 l
  |> Printf.printf "%d\n"

let () =
  input |> solve ~part:1;
  input |> solve ~part:2
