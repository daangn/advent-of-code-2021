let test_data = [ (3, 1L); (4, 1L); (3, 1L); (1, 1L); (2, 1L) ]

let parse input =
  input |> String.split_on_char ',' |> List.map (fun x -> (int_of_string x, 1L))

type eff = Spawn of int64

let reduce state =
  let rec reduce state acc effects =
    match state with
    | (count, n) :: next when count = 0 ->
        reduce next ((6, n) :: acc) (Spawn n :: effects)
    | (count, n) :: next -> reduce next ((count - 1, n) :: acc) effects
    | [] -> (acc, effects)
  in
  reduce state [] []

let ( ++ ) = Int64.add
let sum count (_, n) = count ++ n

let compress state =
  let rec compress state acc =
    match state with
    | (x, n) :: tail ->
        let dups, tail = tail |> List.partition (fun (y, _) -> x = y) in
        let dups = dups |> List.fold_left sum 0L in
        compress tail ((x, n ++ dups) :: acc)
    | [] -> acc
  in
  compress state [] |> List.rev

let handle (state, effects) =
  state
  |> List.rev_append (effects |> List.rev_map (function Spawn n -> (8, n)))
  |> List.rev

let%expect_test _ =
  Array.make 80 ()
  |> Array.fold_left
       (fun state _ -> reduce state |> handle |> compress)
       test_data
  |> List.fold_left sum 0L |> Int64.to_string |> print_string;
  [%expect {| 5934 |}]

let%expect_test _ =
  Array.make 256 ()
  |> Array.fold_left
       (fun state _ -> reduce state |> handle |> compress)
       test_data
  |> List.fold_left sum 0L |> Int64.to_string |> print_string;
  [%expect {| 26984457539 |}]

let part1 input =
  let state = parse input in
  Array.make 80 ()
  |> Array.fold_left (fun state _ -> reduce state |> handle |> compress) state
  |> List.fold_left sum 0L |> Int64.to_string

let part2 input =
  let state = parse input in
  Array.make 256 ()
  |> Array.fold_left (fun state _ -> reduce state |> handle |> compress) state
  |> List.fold_left sum 0L |> Int64.to_string
