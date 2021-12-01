open Core
open Lib

exception No_solution of int * int

let usage_msg = "aoc -d day -p part < input.txt"

let day = ref 1
let part = ref 1

let speclist =
  [
    ("-d", Arg.Set_int day, "Select Day");
    ("-p", Arg.Set_int part, "Select Part")
  ]

let () =
  Arg.parse speclist (fun _ -> ()) usage_msg;;
  let input = In_channel.input_lines In_channel.stdin |> String.concat ~sep:"\n" in
  let answer = match (!day, !part) with
    | (1, 1) -> Day1.solution1 input
    | _ -> raise (No_solution (!day, !part))
  in
  print_endline answer
