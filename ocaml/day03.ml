let puzzle = 368078


let find_manhattan num =
  let spiral_corner = num |> float_of_int |> sqrt |> floor in
  let remaining_seps = num mod int_of_float (spiral_corner ** 2.) in
  let side_length = int_of_float spiral_corner + 1 in
  let towards_middle = remaining_seps mod (side_length/2) in
  side_length - towards_middle


module Direction = struct
  type t = Right | Up | Left | Down

  let left_hand = function
    | Right -> Up
    | Up -> Left
    | Left -> Down
    | Down -> Right
end

module Point = struct
  type t = int * int

  let compare (x1, y1) (x2, y2) =
    match Int.compare x1 x2 with
    | 0 -> Int.compare y1 y2
    | v -> v

  let neighbours (x, y) =
    [ (x-1, y-1); (x, y-1); (x+1, y-1);
      (x-1, y);             (x+1, y);
      (x-1, y+1); (x, y+1); (x+1, y+1);
    ]

  let move (x, y) = function
    | Direction.Right -> (x+1, y)
    | Direction.Up -> (x, y-1)
    | Direction.Left -> (x-1, y)
    | Direction.Down -> (x, y+1)
end

module PointGrid = struct
  include CCMap.Make(Point)

  let find_value grid p =
    get_or p grid ~default:0

  let neighbour_sum grid p =
    let nbs = Point.neighbours p in
    let nb_vals = List.map (find_value grid) nbs in
    List.fold_left (+) 0 nb_vals
end


let next_direction grid p d =
  let left_turn = Direction.left_hand d in
  let np = Point.move p left_turn in
  match PointGrid.find_opt np grid with
  | Some _ -> d
  | None -> left_turn

let rec make_spiral grid p d =
  let np = Point.move p d in
  let nv = PointGrid.neighbour_sum grid np in
  if nv > puzzle then nv
  else
    let nd = next_direction grid np d in
    make_spiral (PointGrid.add np nv grid) np nd


let first = find_manhattan puzzle |> Printf.printf "%d\n"
let second =
  let p = (0, 0) in
  let grid = PointGrid.of_list [(p, 1)] in
  let d = Direction.Right in
  make_spiral grid p d |> Printf.printf "%d\n"
