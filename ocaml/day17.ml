let steps = 394


let spin insertions =
  let spinlock = [0]
  in
  let rec insert spinlock pos i =
    if i > insertions then List.nth spinlock (pos+1)
    else
      let pos' = (pos + steps) mod i + 1 in
      let spinlock' = CCList.insert_at_idx pos' i spinlock in
      insert spinlock' pos' (i+1)
  in
  insert spinlock 0 1 |> Printf.printf "%d\n"


let fake_spin insertions =
  let rec update_pos len pos result =
    if len >= insertions then result
    else
      let pos = (pos + steps) mod len + 1 in
      let result' = if pos = 1 then len else result in
      let skip = (len - pos) / steps in
      let pos' = pos + (skip * (steps+1)) in
      let len' = len + skip + 1 in
      update_pos len' pos' result'
  in
  update_pos 1 0 0 |> Printf.printf "%d\n"


let part_1 = spin 2017
let part_2 = fake_spin 50_000_000
