let (<+>) (p1, q1) (p2, q2) = (p1+p2, q1+q2)

let distance_to_origin (p, q) =
  max (max (abs p) (abs q)) (abs (p + q))


let solution =
  let input = CCIO.(with_in "inputs/11.txt" read_all) in
  input
  |> String.split_on_char ','
  |> List.fold_left
    (fun (pos, furthest) instruction ->
       let direction =
         match instruction with
         | "n"  -> ( 0, -1)
         | "nw" -> (-1,  0)
         | "sw" -> (-1,  1)
         | "s"  -> ( 0,  1)
         | "se" -> ( 1,  0)
         | "ne" -> ( 1, -1)
         | _ -> failwith "impossible"
       in
       let pos' = pos <+> direction in
       let furthest' = max furthest (distance_to_origin pos') in
       (pos', furthest'))
    ((0, 0), 0)
  |> fun (pos, furthest) -> distance_to_origin pos, furthest


let () = Printf.printf "%d\n%d\n" (fst solution) (snd solution)
