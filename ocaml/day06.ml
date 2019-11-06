let banks =
  CCIO.(with_in "inputs/06.txt" read_all)
  |> String.split_on_char '\t'
  |> Array.of_list
  |> Array.map int_of_string


let len = Array.length banks
let seen = Hashtbl.create 5000


let find_max xs =
  let f (mi, mv) i x =
    if x > mv then (i, x) else (mi, mv) in
  CCArray.foldi f (0, 0) xs


let rec redistribute xs n i =
  match n with
  | 0 -> ()
  | _ ->
    let pos = (i+1) mod len in
    xs.(pos) <- xs.(pos) + 1;
    redistribute xs (n-1) pos


let print_solutions first second =
  Printf.printf "%d\n" first;
  Printf.printf "%d\n" second


let rec cycle count banks =
  match Hashtbl.find_opt seen banks with
  | Some x -> print_solutions count (count - x)
  | None ->
    Hashtbl.add seen (Array.copy banks) count;
    let mi, mv = find_max banks in
    banks.(mi) <- 0;
    redistribute banks mv mi;
    cycle (count+1) banks


let () = cycle 0 banks
