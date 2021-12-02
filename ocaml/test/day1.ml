open Lib

let input = "199\n200\n208\n210\n200\n207\n240\n269\n260\n263"

let test_part1 () = Alcotest.(check string) "equals" "7" (Day1.part1 input)

let test_part2 () = Alcotest.(check string) "equals" "5" (Day1.part2 input)

let () =
  let open Alcotest in
  run "Day 1"
    [
      ("Part 1", [ test_case "Check" `Quick test_part1 ]);
      ("Part 2", [ test_case "Check" `Quick test_part2 ]);
    ]
