open Lib

let test_day1 () =
  let input = "199\n200\n208\n210\n200\n207\n240\n269\n260\n263" in
  Alcotest.(check string) "equals" "7" (Day1.part1 input);
  Alcotest.(check string) "equals" "5" (Day1.part2 input)

let () =
  let open Alcotest in
  run "Aoc" [ ("Day 1", [ test_case "Solution" `Quick test_day1 ]) ]
