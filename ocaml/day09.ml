type state = Clean | Garbage

type stream =
  { state: state;
    ignore: bool;
    score: int;
    nr_chars: int;
    depth: int;
  }

let solution =
  let initial_state =
    { state = Clean;
      ignore = false;
      score = 0;
      nr_chars = 0;
      depth = 1;
    }
  in
  CCIO.(with_in "inputs/09.txt" read_all)
  |> CCString.to_list
  |> List.fold_left
    (fun ({depth = d; score = s; nr_chars = n; state = st; _} as pos) x ->
       match x with
       | _ when pos.ignore -> {pos with ignore = false}
       | '!' -> {pos with ignore = true}
       | '<' when st = Clean -> {pos with state = Garbage}
       | '>' when st = Garbage -> {pos with state = Clean}
       | '{' when st = Clean -> {pos with depth = d + 1; score = s + d}
       | '}' when st = Clean -> {pos with depth = d - 1}
       | _ when st = Garbage -> {pos with nr_chars = n + 1}
       | _ -> pos)
    initial_state


let () = Printf.printf "%d\n%d\n" solution.score solution.nr_chars
