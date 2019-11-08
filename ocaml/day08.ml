module Regs = CCMap.Make(String)

type instruction =
  { reg: string;
    instr: string;
    condReg: string;
    condOp: string;
    amount: int;
    value: int;
  }

let parse_operator = function
  | "<"  -> (<)
  | ">"  -> (>)
  | "<=" -> (<=)
  | ">=" -> (>=)
  | "==" -> (=)
  | "!=" -> (<>)
  | _ -> failwith "invalid operator"


let make_instruction line =
  let a =
    line
    |> String.split_on_char ' '
    |> Array.of_list
  in {reg = a.(0); instr = a.(1); amount = int_of_string a.(2);
      condReg = a.(4); condOp = a.(5); value = int_of_string a.(6)}


let execute (regs, max) line =
  let get_reg_val key = Regs.get_or key regs ~default:0 in
  let regVal = get_reg_val line.condReg in
  let (<?>) = parse_operator line.condOp
  in
  if regVal <?> line.value then
    let v = get_reg_val line.reg in
    let (+-) = if line.instr = "inc" then (+) else (-) in
    let nv = v +- line.amount in
    let regs' = Regs.add line.reg nv regs in
    let max' = if nv > max then nv else max in
    (regs', max')
  else (regs, max)


let parse filename =
  List.map make_instruction CCIO.(with_in filename read_lines_l)

let (r, m) =
  parse "inputs/08.txt"
  |> List.fold_left execute (Regs.empty, 0)

let find_largest r =
  Regs.fold (fun _ v a -> if v > a then v else a) r 0


let first = Printf.printf "%d\n" (find_largest r)
let second = Printf.printf "%d\n" m
