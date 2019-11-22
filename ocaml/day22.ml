module Turn = struct
  type t = Left | Right | Back

  let rotate (x, y) = function
    | Left -> (-y, x)
    | Right -> (y, -x)
    | Back -> (-x, -y)
end

module Node = struct
  type t = Clean | Weakened | Infected | Flagged

  let next = function
    | Clean -> Weakened
    | Weakened -> Infected
    | Infected -> Flagged
    | Flagged -> Clean

  let of_char = function
    | '.' -> Clean
    | '#' -> Infected
    | _ -> failwith "not possible"
end

module Coord = struct
  type t = int * int

  let (+) (x1, y1) (x2, y2) = (x1+x2, y1+y2)

  let compare (x1, y1) (x2, y2) =
    match Int.compare x1 x2 with
    | 0 -> Int.compare y1 y2
    | v -> v
end

module Grid = Map.Make(Coord)



let parse input part =
  let (dim_x, dim_y) = if part = 1 then (60, 110) else (420, 420) in
  let (c_x, c_y) = (dim_x/2, dim_y/2) in
  let offset = List.length input / 2 in
  let grid = Array.make_matrix dim_x dim_y Node.Clean in
  List.iteri
    (fun i l ->
       List.iteri
         (fun j c -> grid.(c_x-offset + i).(c_y-offset + j) <- Node.of_char c)
         (CCString.to_list l))
    input;
  grid, (c_x, c_y)

let initial_conditions ~part =
  let instructions = CCIO.(with_in "inputs/22.txt" read_lines_l) in
  let grid, start = parse instructions part in
  let start_dir = (-1, 0) in
  (grid, start, start_dir, part)


let rotate dir = function
  | Node.Clean -> Turn.rotate dir Left
  | Node.Weakened -> dir
  | Node.Infected -> Turn.rotate dir Right
  | Node.Flagged -> Turn.rotate dir Back

let solve (grid, pos, dir, part) =
  let bursts = if part = 1 then 10_000 else 10_000_000 in
  let change =
    if part = 1 then
      CCFun.(Node.next %> Node.next)
    else Node.next
  in
  let rec work (x, y) dir inf remaining =
    match remaining with
    | 0 -> Printf.printf "%d\n" inf
    | r ->
      let current_status = grid.(x).(y) in
      let dir = rotate dir current_status in
      let status = change current_status in
      grid.(x).(y) <- status;
      let inf = if status = Infected then inf+1 else inf in
      let pos = Coord.((x, y) + dir) in
      work pos dir inf (r-1)
  in
  work pos dir 0 bursts


let () =
  solve (initial_conditions ~part:1);
  solve (initial_conditions ~part:2)
