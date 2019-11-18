type argument = Val of int | Reg of char

type command =
  | Set of (char * argument)
  | Add of (char * argument)
  | Mul of (char * argument)
  | Mod of (char * argument)
  | Jgz of (argument * argument)
  | Snd of char
  | Rcv of char

module Regs = CCMap.Make(Char)

type state = Running | Paused | Finished

type worker = {
  name : int;
  line : int;
  state : state;
  find_first : bool;
  in_queue : int Queue.t;
  out_queue : int Queue.t;
  regs : int Regs.t;
  sent_count : int;
}


let get_reg_value regs c =
  Regs.get_or ~default:0 c regs

let get_value regs = function
  | Val i -> i
  | Reg c -> get_reg_value regs c

let update_worker worker reg value =
  let regs = Regs.add reg value worker.regs in
  { worker with regs; line = worker.line+1 }

let set worker reg arg =
  let v = get_value worker.regs arg in
  update_worker worker reg v

let perform op worker reg arg =
  let curr_val = get_reg_value worker.regs reg in
  let modification = get_value worker.regs arg in
  let new_val = op curr_val modification in
  update_worker worker reg new_val

let add = perform ( + )
let mul = perform ( * )
let modulo = perform ( mod )

let jump worker r_arg arg =
  let cond = get_value worker.regs r_arg in
  let jump = if cond > 0 then (get_value worker.regs arg) else 1 in
  { worker with line = worker.line + jump }

let send worker reg =
  let v = get_reg_value worker.regs reg in
  Queue.push v worker.out_queue;
  { worker with sent_count = worker.sent_count+1; line = worker.line+1 }

let receive worker reg =
  let change_state = function
    | Running -> Paused
    | _ -> Finished
  in
  match Queue.take_opt worker.in_queue with
  | Some v ->
    let () =
      if worker.find_first then
        let last_value = Queue.fold (fun _ v -> v) 0 worker.in_queue in
        Printf.printf "%d\n" last_value
    in
    { (update_worker worker reg v) with state = Running; find_first = false }
  | None -> {worker with state = change_state worker.state}


let execute w = function
  | Set (c, a) -> set w c a
  | Add (c, a) -> add w c a
  | Mul (c, a) -> mul w c a
  | Mod (c, a) -> modulo w c a
  | Jgz (a1, a2) -> jump w a1 a2
  | Snd c -> send w c
  | Rcv c -> receive w c

let run_command instructions w =
  if w.line < Array.length instructions
  then execute w instructions.(w.line)
  else { w with state = Finished }

let rec run active waiting instructions =
  match (active.state, waiting.state) with
  | Finished, Finished -> active, waiting
  | Running, _ -> run (run_command instructions active) waiting instructions
  | _ -> run (run_command instructions waiting) active instructions


let parse_line line =
  let parse v =
    let c = int_of_char v.[0] - int_of_char 'a' in
    if c >= 0 then Reg v.[0] else Val (int_of_string v)
  in
  match String.split_on_char ' ' line with
  | [ "set"; r; v ] -> Set (r.[0], parse v)
  | [ "add"; r; v ] -> Add (r.[0], parse v)
  | [ "mul"; r; v ] -> Mul (r.[0], parse v)
  | [ "mod"; r; v ] -> Mod (r.[0], parse v)
  | [ "jgz"; r; v ] -> Jgz (parse r, parse v)
  | [ "snd"; r ] -> Snd r.[0]
  | [ "rcv"; r ] -> Rcv r.[0]
  | _ -> failwith "illegal input"

let parse filename =
  CCIO.(with_in filename read_lines_l)
  |> List.map parse_line
  |> Array.of_list

let create_worker name in_queue out_queue =
  let regs = Regs.of_list [ ('p', name) ] in
  let find_first = name = 1 in
  { name; line = 0; state = Running; find_first;
    in_queue; out_queue; regs; sent_count = 0 }


let instructions = parse "inputs/18.txt"

let fst_queue = Queue.create ()
let snd_queue = Queue.create ()

let fst_worker = create_worker 0 fst_queue snd_queue
let snd_worker = create_worker 1 snd_queue fst_queue

let x, y = run fst_worker snd_worker instructions
let program_1 = if x.name = 1 then x else y
let () = Printf.printf "%d\n" program_1.sent_count
