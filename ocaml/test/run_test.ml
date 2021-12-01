let test_day1_challenge1 () =
  let input = "199\n200\n208\n210\n200\n207\n240\n269\n260\n263" in
  let answer = Lib.Day1.solution1 input in
  Alcotest.(check string) "equals" answer "7"

let () =
  let open Alcotest in
  run "Aoc"
    [ ("Day 1", [ test_case "Challenge 1" `Quick test_day1_challenge1 ]) ]
