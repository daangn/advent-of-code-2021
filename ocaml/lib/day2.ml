exception Invalid_input

module Pos = struct
  type t = { hpos : int; depth : int; aim : int }

  let make () = { hpos = 0; depth = 0; aim = 0 }

  type command = Forward of int | Down of int | Up of int

  let instruct ~f pos cmds =
    let pos = cmds |> List.fold_left f pos in
    pos.hpos * pos.depth
end

open Pos

let parse input =
  input |> String.split_on_char '\n'
  |> List.map (String.split_on_char ' ')
  |> List.map (function
       | a :: b :: _ -> (
           match (a, int_of_string b) with
           | "forward", x -> Forward x
           | "down", x -> Down x
           | "up", x -> Up x
           | _ -> raise Invalid_input)
       | _ -> raise Invalid_input)

let part1 input =
  let apply pos cmd =
    match cmd with
    | Forward x -> { pos with hpos = pos.hpos + x }
    | Down x -> { pos with depth = pos.depth + x }
    | Up x -> { pos with depth = pos.depth - x }
  in
  parse input |> instruct ~f:apply (make ()) |> string_of_int

let part2 input =
  let apply pos cmd =
    match cmd with
    | Down x -> { pos with aim = pos.aim + x }
    | Up x -> { pos with aim = pos.aim - x }
    | Forward x ->
        { pos with hpos = pos.hpos + x; depth = pos.depth + (pos.aim * x) }
  in
  parse input |> instruct ~f:apply (make ()) |> string_of_int
