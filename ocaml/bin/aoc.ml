open Lib
open Core

exception No_solution of int * int

let usage_msg = "aoc -d day -p part < input.txt"
let day = ref 1
let part = ref 1

let speclist =
  [
    ("-d", Arg.Set_int day, "Choose Day");
    ("-p", Arg.Set_int part, "Choose Part");
  ]

let () = Arg.parse speclist (fun _ -> ()) usage_msg;;

let input =
  In_channel.input_lines In_channel.stdin |> String.concat ~sep:"\n"
in
let answer =
  match (!day, !part) with
  | 1, 1 -> Day1.part1 input
  | 1, 2 -> Day1.part2 input
  | 2, 1 -> Day2.part1 input
  | 2, 2 -> Day2.part2 input
  | 3, 1 -> Day3.part1 input
  | 3, 2 -> Day3.part2 input
  | 4, 1 -> Day4.part1 input
  | 4, 2 -> Day4.part2 input
  | 5, 1 -> Day5.part1 input
  | 5, 2 -> Day5.part2 input
  | 6, 1 -> Day6.part1 input
  | 6, 2 -> Day6.part2 input
  | 7, 1 -> Day7.part1 input
  | 7, 2 -> Day7.part2 input
  | _ -> raise (No_solution (!day, !part))
in
print_endline answer
