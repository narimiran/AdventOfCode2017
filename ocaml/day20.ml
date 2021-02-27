module Particle = struct
  type coord = { x : float; y : float; z : float }
  type particle = { p : coord; v : coord; a : coord }

  let create_particle px py pz vx vy vz ax ay az =
    { p = { x = px; y = py; z = pz };
      v = { x = vx; y = vy; z = vz };
      a = { x = ax; y = ay; z = az };
    }

  let magnitude c =
    let open CCFloat in
    let sq x = x * x in
    sq c.x + sq c.y + sq c.z

  let closest particles =
    let ix, _ =
      CCList.foldi
        (fun (ix, ac) i p ->
           let accel = magnitude p.a in
           if accel < ac then (i, accel) else (ix, ac))
        (-1, Float.max_float)
        particles
    in ix

  let is_1D_collision p v a t =
    let open CCFloat in
    (2.0*v + a*(1.0+t))*t + 2.0*p = 0.0

  let is_2D_collision p v a t =
    is_1D_collision p.y v.y a.y t && is_1D_collision p.z v.z a.z t

  let (-) c1 c2 = { x = c1.x -. c2.x; y = c1.y -. c2.y; z = c1.z -. c2.z }
  let (-) p1 p2 = { p = p1.p - p2.p; v = p1.v - p2.v; a = p1.a - p2.a }

  let find_collision_time p1 p2 =
    let {p; v; a} = p1 - p2 in
    let open CCFloat in
    let b = -v.x - 0.5*a.x in
    let d = b*b - 2.0*a.x*p.x
    in
    if a.x = 0.0 then
      if v.x != 0.0 then
        let t = - p.x / v.x in
        if is_2D_collision p v a t then t else 0.0
      else 0.0
    else if d = 0.0 then
      let t = b / a.x in
      if is_2D_collision p v a t then t else 0.0
    else
      let ds = sqrt d in
      let t1 = (b - ds) / a.x in
      let t2 = (b + ds) / a.x in
      if is_2D_collision p v a t1 then t1
      else if is_2D_collision p v a t2 then t2 else 0.0
end


let parse_line line =
  Scanf.sscanf
    line
    "p=<%f,%f,%f>, v=<%f,%f,%f>, a=<%f,%f,%f>"
    Particle.create_particle

let parse_input input =
  List.map parse_line input


module Intmap = Map.Make(Int)
module Intset = Set.Make(Int)
type collision_pair = { i : int; j : int }


let make_collision_table particles =
  particles
  |> CCList.foldi
    (fun m i p1 ->
       particles
       |> CCList.foldi
         (fun n j p2 ->
            if j > i then
              let t = int_of_float (Particle.find_collision_time p1 p2) in
              if t > 0 then
                let v = match Intmap.find_opt t n with
                  | Some xs -> { i; j } :: xs
                  | None -> [ { i; j } ]
                in
                Intmap.add t v n
              else n
            else n)
         m)
    Intmap.empty


let find_dead_particles collisions =
  Intmap.fold
    (fun _ v dead ->
       v
       |> List.fold_left
         (fun a { i; j } ->
            if not (Intset.mem i dead) && not (Intset.mem j dead)
            then Intset.union a (Intset.of_list [ i; j ])
            else a)
         Intset.empty
       |> Intset.union dead)
    collisions
    Intset.empty


let instructions = CCIO.(with_in "inputs/20.txt" read_lines_l)
let particles = parse_input instructions
let part_1 = Particle.closest particles |> Printf.printf "%d\n"

let collisions = make_collision_table particles
let dead_particles = find_dead_particles collisions
let part_2 =
  List.length particles - Intset.cardinal dead_particles
  |> Printf.printf "%d\n"
