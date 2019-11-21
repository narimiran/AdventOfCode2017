module Grid = struct
  open CCFun
  type t = bool array array

  let of_string: (string -> t) =
    let to_bool =
      CCString.to_array %> Array.map (Char.equal '#') in
    String.split_on_char '/' %> CCArray.of_list %> Array.map to_bool

  let make size : t =
    Array.make_matrix size size false

  let flip (g: t) =
    let gc = Array.copy g in
    let last = Array.length gc - 1 in
    CCArray.swap gc 0 last;
    gc

  let transpose (g: t) =
    let l = Array.length g in
    let gc = make l in
    for i = 0 to pred l do
      for j = i to pred l do
        gc.(j).(i) <- g.(i).(j);
        gc.(i).(j) <- g.(j).(i);
      done
    done;
    gc

  let all_variants (g: t) =
    let t = transpose in
    let f = flip in
    [ g;
      g |> t;
      g |> t |> f;
      g |> t |> f |> t;
      g |> t |> f |> t |> f;
      g |> t |> f |> t |> f |> t;
      g |> t |> f |> t |> f |> t |> f;
      g |> t |> f |> t |> f |> t |> f |> t;
    ]

  let pixels_on g =
    let result = ref 0 in
    g |> Array.iter (fun row ->
        row |> Array.iter (fun x -> if x then incr result));
    !result
end



let rules = Hashtbl.create (8 * 108)

let parse_line line =
  match CCString.split ~by:" => " line with
  | [ i; o ] ->
    let inputs = Grid.all_variants (Grid.of_string i) in
    let output = Grid.of_string o in
    inputs |> List.iter (fun input ->
        Hashtbl.add rules input output)
  | _ -> failwith "invalid input"

let parse filename =
  CCIO.(with_in filename read_lines_l)
  |> List.iter parse_line

let () = parse "inputs/21.txt"
let starting_grid = Grid.of_string ".#./..#/###"

let grid_2x2 = Grid.make 2
let grid_3x3 = Grid.make 3

let get_square g i j by =
  let result = if by = 2 then grid_2x2 else grid_3x3 in
  for x = 0 to pred by do
    for y = 0 to pred by do
      result.(x).(y) <- g.(i+x).(j+y)
    done
  done;
  result


let find_next g =
  let size = Array.length g in
  let by = if size mod 2 = 0 then 2 else 3 in
  let new_size = size * (by+1) / by in
  let square_size = size / by - 1 in
  let result = Grid.make new_size
  in
  for i = 0 to square_size do
    for j = 0 to square_size do
      let square = get_square g (i*by) (j*by) by in
      let enhanced = Hashtbl.find rules square in
      let h = Array.length enhanced - 1 in
      for x = 0 to h do
        for y = 0 to h do
          result.(i*(by+1) + x).(j*(by+1) + y) <- enhanced.(x).(y)
        done
      done
    done
  done;
  result

let repeat f n g =
  let rec aux n g =
    match n with
    | 0 -> g
    | n -> aux (n-1) (f g)
  in
  aux n g
  |> Grid.pixels_on |> Printf.printf "%d\n"


let () =
  starting_grid |> repeat find_next 5;
  starting_grid |> repeat find_next 18
