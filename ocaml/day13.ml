module Intset = Set.Make(Int)
type groups = { h: int; ds: int list }

let firewall = Hashtbl.create 16

let parse_line line =
  Scanf.sscanf line "%d: %d"
    (fun d h ->
       let v = match Hashtbl.find_opt firewall h with
         | None -> [d]
         | Some ds -> d :: ds
       in
       Hashtbl.replace firewall h v)

let is_caught ?(delay=0) d h =
  (d + delay) mod (2 * (h - 1)) = 0

let group_severity ds h =
  let caught_depths = List.filter (fun d -> is_caught d h) ds in
  let total_caught = List.fold_left (+) 0 caught_depths in
  h * total_caught

let total_severity =
  List.fold_left (fun acc { h; ds } -> acc + group_severity ds h) 0


let lcm a b =
  let rec gcd a b =
    if b = 0 then a else gcd b (a mod b) in
  a * b / gcd a b

let pymod b a =
  let m = -a mod b in
  if m < 0 then m+b else m


let find_allowed_delay { h; ds } =
  let period = 2 * (h - 1) in
  let potential = Intset.of_list (CCList.range_by ~step:2 0 period) in
  let forbidden = Intset.of_list (List.map (pymod period) ds) in
  let allowed_delay = Intset.choose (Intset.diff potential forbidden) in
  (allowed_delay, period)

let find_delay_params walls =
  let potential_delays = OSeq.map find_allowed_delay walls in
  let common_multi =
    OSeq.fold_left (fun acc (_, period) -> lcm acc period) 1 potential_delays
  in
  let delays =
    potential_delays
    |> OSeq.fold_left
      (fun acc (delay, period) ->
         let upper = common_multi / period in
         let s = Intset.of_seq
             (OSeq.map (fun i -> delay + i*period) OSeq.(0 --^ upper))
         in
         Intset.inter acc s)
      (Intset.of_seq OSeq.(0 --^ common_multi))
    |> Intset.choose
  in
  (delays, common_multi)

let pass_through (calc_group, ctrl_group) =
  let init_delay, step = find_delay_params calc_group in
  let rec aux delay step ctrl =
    let some_caught =
      ctrl |> OSeq.exists
        (fun { h; ds } -> ds |> List.exists (fun d -> is_caught ~delay d h))
    in
    match some_caught with
    | true -> aux (delay+step) step ctrl
    | false -> delay
  in
  aux init_delay step ctrl_group


let fw =
  CCIO.(with_in "inputs/13.txt" read_lines_l) |> List.iter parse_line;
  firewall
  |> CCHashtbl.to_list
  |> List.map (fun (h, ds) -> { h; ds })

let groups =
  let fws = List.to_seq fw in
  let one_remains { h; ds } = List.length ds = h - 2 in
  OSeq.partition one_remains fws


let part_1 = fw |> total_severity |> Printf.printf "%d\n"
let part_2 = groups |> pass_through |> Printf.printf "%d\n"
