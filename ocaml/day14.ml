let instructions = "hwlqcszp-"
let deltas = [ (1, 0); (-1, 0); (0, 1); (0, -1) ]
let size = 128


let create_maze () =
  let count = ref 0 in
  let maze = Array.make_matrix size size false in
  maze
  |> Array.iteri (fun i _ ->
      let word = instructions ^ Printf.sprintf "%d" i in
      let bin_hash = KnotHash.knot_hashing ~to_bin:true word in
      bin_hash
      |> String.iteri (fun j col ->
          if col = '1' then begin
            maze.(i).(j) <- true;
            incr count
          end));
  (!count, maze)


let is_inbounds x y =
  x >= 0 && x < size && y >= 0 && y < size

let rec dfs (x, y) maze =
  if is_inbounds x y && maze.(x).(y) then begin
    maze.(x).(y) <- false;
    List.iter (fun (dx, dy) -> dfs (x+dx, y+dy) maze) deltas
  end


let count_regions maze =
  let count = ref 0 in
  maze |> Array.iteri (fun i row ->
      row |> Array.iteri (fun j _ ->
          if maze.(i).(j) then incr count;
          dfs (i, j) maze));
  !count


let first, maze = create_maze ()
let () =
  first |> Printf.printf "%d\n";
  maze |> count_regions |> Printf.printf "%d\n"
