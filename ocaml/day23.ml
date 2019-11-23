type argument = Val of int | Reg of char

type command =
  | Set of char * argument
  | Sub of char * argument
  | Mul of char * argument
  | Jnz of argument * argument

module Regs = CCMap.Make(Char)

let get_reg_value regs c =
  Regs.get_or c regs ~default:0

let get_value regs arg =
  match arg with
  | Val i -> i
  | Reg c -> get_reg_value regs c


let parse_line line =
  let parse v =
    let c = int_of_char v.[0] - int_of_char 'a' in
    if c >= 0 then Reg v.[0]
    else Val (int_of_string v)
  in
  match String.split_on_char ' ' line with
  | [ "set"; r; v ] -> Set (r.[0], parse v)
  | [ "sub"; r; v ] -> Sub (r.[0], parse v)
  | [ "mul"; r; v ] -> Mul (r.[0], parse v)
  | [ "jnz"; r; v ] -> Jnz (parse r, parse v)
  | _ -> failwith "illegal input"

let parse filename =
  CCIO.(with_in filename read_lines_l)
  |> List.map parse_line
  |> Array.of_list

let input = parse "inputs/23.txt"


let solve ~part instructions =
  let regs = Regs.of_list [('a', part-1)] in
  let rec iterate regs i =
    if i >= 11 then regs
    else
      match instructions.(i) with
      | Set (c, a) ->
        let v = get_value regs a in
        let regs' = Regs.add c v regs in
        iterate regs' (i+1)
      | Sub (c, a) ->
        let v = get_reg_value regs c - get_value regs a in
        let regs' = Regs.add c v regs in
        iterate regs' (i+1)
      | Mul (c, a) ->
        let v = get_reg_value regs c * get_value regs a in
        let regs' = Regs.add c v regs in
        iterate regs' (i+1)
      | Jnz (a1, a2) ->
        let jump = if get_value regs a1 <> 0
          then get_value regs a2 else 1 in
        iterate regs (i+jump)
  in
  let regs = iterate regs 0 in
  if part = 1
  then
    let b = get_reg_value regs 'b' in
    let e = get_reg_value regs 'e' in
    let d = get_reg_value regs 'd' in
    (b - e) * (b - d)
  else
    let b = get_reg_value regs 'b' in
    let c = get_reg_value regs 'c' in
    let nonprimes = (c - b) / 34 + 1 in
    let is_prime n =
      let rec loop n k =
        if k*k >= n then true
        else if n mod k = 0 then false
        else loop n (k+2)
      in
      if n mod 2 = 0 then false
      else loop n 3
    in
    let rec find_nonprimes n acc =
      if n > c then acc
      else if is_prime n then
        find_nonprimes (n+34) acc
      else find_nonprimes (n+34) (acc+1)
    in
    find_nonprimes (b+17) nonprimes


let () =
  input |> solve ~part:1 |> Printf.printf "%d\n";
  input |> solve ~part:2 |> Printf.printf "%d\n"
