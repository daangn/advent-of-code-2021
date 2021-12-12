let test_input = "16,1,2,0,4,2,7,1,2,14"
let parse input = input |> String.split_on_char ',' |> List.map int_of_string
let farest lst = lst |> List.fold_left max (List.hd lst)

let collect lst =
  let rec collect lst acc =
    match lst with
    | costs :: next -> collect next (List.map2 ( + ) costs acc)
    | [] -> acc
  in
  let init = List.init (List.length (List.hd lst)) (fun _ -> 0) in
  collect lst init

let cheapest lst =
  let rec cheapest lst (prev, prev_pos) pos =
    match lst with
    | curr :: next when curr < prev -> cheapest next (curr, pos) (pos + 1)
    | _ :: next -> cheapest next (prev, prev_pos) (pos + 1)
    | _ -> (prev, prev_pos)
  in
  cheapest lst (List.hd lst, 0) 0

let part1 input =
  let positions = parse input in
  let candidates = List.init (farest positions) (fun i -> i) in
  let cost x y = abs (x - y) in
  positions
  |> List.map (fun pos -> candidates |> List.map (cost pos))
  |> collect |> cheapest |> fst |> string_of_int

let%expect_test "part1" =
  print_string (part1 test_input);
  [%expect {| 37 |}]

let part2 input =
  let positions = parse input in
  let candidates = List.init (farest positions) (fun i -> i) in
  let cost x y =
    let dist = abs (x - y) in
    (1 + dist) * dist / 2
  in
  positions
  |> List.map (fun pos -> candidates |> List.map (cost pos))
  |> collect |> cheapest |> fst |> string_of_int

let%expect_test "part2" =
  print_string (part2 test_input);
  [%expect {| 168 |}]
