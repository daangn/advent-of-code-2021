let parse input = input |> String.split_on_char ',' |> List.map int_of_string

type eff = Spawn

let reduce state =
  let rec reduce state acc effects =
    match state with
    | count :: next when count = 0 -> reduce next (6 :: acc) (Spawn :: effects)
    | count :: next -> reduce next ((count - 1) :: acc) effects
    | [] -> (acc, effects)
  in
  reduce state [] []

let handle (state, effects) =
  state @ (effects |> List.map (function Spawn -> 8))

let%expect_test _ =
  Array.make 18 ()
  |> Array.fold_left (fun state _ -> reduce state |> handle) [ 3; 4; 3; 1; 2 ]
  |> List.length |> print_int;
  [%expect {| 26 |}]

let%expect_test _ =
  Array.make 80 ()
  |> Array.fold_left (fun state _ -> reduce state |> handle) [ 3; 4; 3; 1; 2 ]
  |> List.length |> print_int;
  [%expect {| 5934 |}]

let%expect_test _ =
  Array.make 256 ()
  |> Array.fold_left (fun state _ -> reduce state |> handle) [ 3; 4; 3; 1; 2 ]
  |> List.length |> print_int;
  [%expect {| 26984457539 |}]

let part1 input =
  let state = parse input in
  Array.make 80 ()
  |> Array.fold_left (fun state _ -> reduce state |> handle) state
  |> List.length |> string_of_int

let part2 input =
  let state = parse input in
  Array.make 256 ()
  |> Array.fold_left (fun state _ -> reduce state |> handle) state
  |> List.length |> string_of_int
