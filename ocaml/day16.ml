let instructions =
  CCIO.(with_in "inputs/16.txt" read_all) |> String.split_on_char ','

type spin = { n : int }
type exchange = { a : int; b : int }
type partner = { a : char; b : char }
type dance_move = Spin of spin | Exchange of exchange | Partner of partner


let parse instr =
  let l = String.length instr in
  let first = instr.[0] in
  let rest = String.sub instr 1 (l-1) in
  match first with
  | 's' -> Spin { n = int_of_string rest }
  | 'x' -> (
      match rest |> String.split_on_char '/' |> List.map int_of_string with
      | [a; b] -> Exchange { a; b }
      | _ -> failwith "impossible" )
  | 'p' -> Partner { a = rest.[0]; b = rest.[l-2] }
  | _ -> failwith "impossible"

let parsed_instructions = instructions |> List.map parse


let spin a n =
  let l = Array.length a in
  let rec rotate = function
    | 0 -> ()
    | r ->
      let last = a.(l-1) in
      for i = l - 1 downto 1 do
        a.(i) <- a.(i-1)
      done;
      a.(0) <- last;
      rotate (r-1)
  in
  rotate n

let dance dancers =
  let find x =
    CCArray.findi (fun i c -> if c = x then Some i else None) dancers
  in
  parsed_instructions
  |> List.iter (function
      | Exchange { a; b } -> CCArray.swap dancers a b
      | Spin { n } -> spin dancers n
      | Partner { a; b } ->
        match (find a, find b) with
        | Some pa, Some pb ->
          dancers.(pa) <- b;
          dancers.(pb) <- a
        | _ -> () )


let long_dance dancers =
  let iterations = 1_000_000_000 in
  let starting_position = "abcdefghijklmnop" in
  let rec iter dancers seen i =
    match List.mem starting_position seen with
    | true ->
      let seen' = starting_position :: List.rev seen in
      let final_position = iterations mod i in
      List.nth seen' final_position
    | false ->
      dance dancers;
      let current_order = CCString.of_array dancers in
      iter dancers (current_order :: seen) (i+1)
  in
  iter dancers [ CCString.of_array dancers ] 1


let programs = "abcdefghijklmnop" |> CCString.to_array
let part_1 =
  dance programs;
  programs |> CCString.of_array |> Printf.printf "%s\n"
let part_2 = long_dance programs |> Printf.printf "%s\n"
