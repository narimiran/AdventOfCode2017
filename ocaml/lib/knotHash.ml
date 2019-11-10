let size = 255

let twist circle pos skipSize =
  for i = 0 to skipSize / 2 - 1 do
    let a = (pos + i) land size in
    let b = (pos + skipSize-1 - i) land size in
    CCArray.swap circle a b
  done


let knot_logic sizes n =
  let circle = Array.init (size+1) Fun.id in
  let pos = ref 0 in
  let skip = ref 0
  in
  let rec repeat n =
    if n = 0 then circle
    else begin
      List.iter
        (fun x ->
           twist circle !pos x;
           pos := (!pos + x + !skip) land size;
           incr skip
        ) sizes;
      repeat (n-1)
    end
  in
  repeat n


let hash_chunk arr i =
  let rec hash_it hash n =
    if n = 0 then hash
    else
      hash_it (hash lxor arr.(16*i + (n-1))) (n-1)
  in
  hash_it 0 16


let rec binary_representation digits n =
  match n with
  | 0 -> begin
      match List.length digits with
      | 8 ->
        digits
        |> List.map (fun x -> char_of_int (x + int_of_char '0'))
        |> CCString.of_list
      | _ -> binary_representation (0 :: digits) n
    end
  | _ ->
    let r = n mod 2 in
    binary_representation (r :: digits) (n/2)


let knot_hashing ?(to_bin=false) word =
  let ascii_sizes =
    (word |> CCString.to_list |> List.map int_of_char)
    @ [17; 31; 73; 47; 23]
  in
  let numbers = knot_logic ascii_sizes 64 in
  let convert =
    let f = if to_bin
      then (binary_representation [])
      else (Printf.sprintf "%02x") in
    CCFun.(Array.to_list %> List.map f %> String.concat "")
  in
  Array.make 16 0
  |> Array.mapi (fun i _ -> hash_chunk numbers i)
  |> convert
