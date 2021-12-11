let test_input =
  "0,9 -> 5,9\n\
   8,0 -> 0,8\n\
   9,4 -> 3,4\n\
   2,2 -> 2,1\n\
   7,0 -> 7,4\n\
   6,4 -> 2,0\n\
   0,9 -> 2,9\n\
   3,4 -> 1,4\n\
   0,0 -> 8,8\n\
   5,5 -> 8,2"

type coord = int * int

module Parser = struct
  open Angstrom
  open Util.Parser

  let coord = lift3 (fun x _ y -> (x, y)) digit comma digit
  let dir = string " -> " >>| ignore
  let line = lift3 (fun c1 _ c2 -> (c1, c2)) coord dir coord
  let lines = sep_by newline line
  let parse input = input |> parse_string ~consume:All lines |> Result.get_ok

  let%expect_test _ =
    let lines = parse test_input in
    let print_line line =
      let (x1, y1), (x2, y2) = line in
      print_endline
        (string_of_int x1 ^ "," ^ string_of_int y1 ^ " -> " ^ string_of_int x2
       ^ "," ^ string_of_int y2)
    in
    lines |> List.iter print_line;
    [%expect
      {|
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    |}]
end

let ( --> ) i j =
  let rec aux i j acc = if i < j then acc else aux (i - 1) j (i :: acc) in
  if i < j then aux j i [] else aux i j [] |> List.rev

module CollisionMap = Map.Make (struct
  type t = coord

  let compare = compare
end)

let count_collision max coords =
  coords
  |> List.fold_left
       (fun map coord ->
         map
         |> CollisionMap.update coord (function
              | Some n -> Some (n + 1)
              | None -> Some 1))
       CollisionMap.empty
  |> CollisionMap.filter (fun _ n -> n >= max)
  |> CollisionMap.cardinal

let part1 input =
  let lines = Parser.parse input in
  let draw = function
    | (x1, y1), (x2, y2) when x1 = x2 && y1 = y2 -> [ (x1, y1) ]
    | (x1, y1), (x2, y2) when x1 = x2 ->
        y1 --> y2 |> List.map (fun y -> (x1, y))
    | (x1, y1), (x2, y2) when y1 = y2 ->
        x1 --> x2 |> List.map (fun x -> (x, y1))
    | _ -> []
  in
  lines |> List.map draw |> List.flatten |> count_collision 2 |> string_of_int

let%expect_test "part1" =
  print_string (part1 test_input);
  [%expect {| 5 |}]

let part2 input =
  let lines = Parser.parse input in
  let draw = function
    | (x1, y1), (x2, y2) when x1 = x2 && y1 = y2 -> [ (x1, y1) ]
    | (x1, y1), (x2, y2) when x1 = x2 && y1 != y2 ->
        y1 --> y2 |> List.map (fun y -> (x1, y))
    | (x1, y1), (x2, y2) when y1 = y2 && x1 != x2 ->
        x1 --> x2 |> List.map (fun x -> (x, y1))
    | (x1, y1), (x2, y2) when abs (x1 - x2) = abs (y1 - y2) ->
        List.map2 (fun x y -> (x, y)) (x1 --> x2) (y1 --> y2)
    | _ -> []
  in
  lines |> List.map draw |> List.flatten |> count_collision 2 |> string_of_int

let%expect_test "part2" =
  print_string (part2 test_input);
  [%expect {| 12 |}]
