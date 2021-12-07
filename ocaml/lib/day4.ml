exception Invalid_input

let test_input =
  "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1\n\n\
   22 13 17 11  0\n\
  \ 8  2 23  4 24\n\
   21  9 14 16  7\n\
  \ 6 10  3 18  5\n\
  \ 1 12 20 15 19\n\n\
  \ 3 15  0  2 22\n\
  \ 9 18 13 17  5\n\
   19  8  7 25 23\n\
   20 11 10 24  4\n\
   14 21 16 12  6\n\n\
   14 21 17 24  4\n\
   10 16 15  9 19\n\
   18  8 23 26 20\n\
   22 11 13  6  5\n\
  \ 2  0 12  3  7"

module Bingo = struct
  type cell = Marked of int | Unmarked of int

  type board = cell array array

  type game = { turns : int list; boards : board list }

  let rotate board =
    match board with
    | [|
     [| a1; a2; a3; a4; a5 |];
     [| b1; b2; b3; b4; b5 |];
     [| c1; c2; c3; c4; c5 |];
     [| d1; d2; d3; d4; d5 |];
     [| e1; e2; e3; e4; e5 |];
    |] ->
        [|
          [| a1; b1; c1; d1; e1 |];
          [| a2; b2; c2; d2; e2 |];
          [| a3; b3; c3; d3; e3 |];
          [| a4; b4; c4; d4; e4 |];
          [| a5; b5; c5; d5; e5 |];
        |]
    | _ -> raise Invalid_input

  let mark n board =
    board
    |> Array.map
         (Array.map (function Unmarked x when x = n -> Marked x | x -> x))

  let score board =
    board |> Array.to_list |> List.map Array.to_list
    |> List.map (List.map (function Unmarked x -> x | _ -> 0))
    |> List.flatten |> List.fold_left ( + ) 0

  let bingo cols =
    cols |> Array.for_all (function Marked _ -> true | _ -> false)

  let check board =
    board |> Array.exists bingo || rotate board |> Array.exists bingo
end

module Parser = struct
  open Angstrom
  open Bingo

  let digits =
    take_while1 (function '0' .. '9' -> true | _ -> false) >>| int_of_string

  let ws = skip_while (function ' ' -> true | _ -> false)

  let space = char ' '

  let newline = char '\n'

  let multiple = skip_many1 newline

  let comma = char ','

  let turn = digits

  let turns = sep_by1 comma turn

  let cell = ws *> digits >>| fun x -> Unmarked x

  let cols = sep_by1 space cell >>| Array.of_list

  let rows = sep_by1 newline cols >>| Array.of_list

  let boards = sep_by1 multiple rows

  let game =
    lift3 (fun turns _ boards -> { turns; boards }) turns multiple boards

  let parse input = input |> parse_string ~consume:All game |> Result.get_ok

  let%expect_test _ =
    let { turns; _ } = parse test_input in
    turns |> List.iter print_int;
    [%expect {| 74951117232014212410161361525122218208193261 |}]
end

let part1 input =
  let open Bingo in
  let rec play ~boards ~turns =
    match turns with
    | n :: turns -> (
        let boards = boards |> List.map (mark n) in
        match boards |> List.find_opt check with
        | Some board -> n * score board
        | None -> play ~boards ~turns)
    | [] -> raise Invalid_input
  in
  let { boards; turns } = Parser.parse input in
  play ~boards ~turns |> string_of_int

let%expect_test "part 1" =
  print_string (part1 test_input);
  [%expect {| 4512 |}]

let part2 input =
  let open Bingo in
  let rec play ~boards ~turns ~snapshot =
    match turns with
    | n :: turns -> (
        let boards = boards |> List.map (mark n) in
        match boards |> List.find_opt check with
        | Some board ->
            let snapshot = Some (n, board) in
            let boards = boards |> List.filter (fun x -> not (check x)) in
            play ~boards ~turns ~snapshot
        | None -> play ~boards ~turns ~snapshot)
    | [] -> (
        match snapshot with
        | Some (n, board) -> n * score board
        | None -> raise Invalid_input)
  in
  let { boards; turns } = Parser.parse input in
  play ~boards ~turns ~snapshot:None |> string_of_int

let%expect_test "part 2" =
  print_string (part2 test_input);
  [%expect {| 1924 |}]
