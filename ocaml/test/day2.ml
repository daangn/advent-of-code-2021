open Lib

let input = "forward 5\ndown 5\nforward 8\nup 3\ndown 8\nforward 2"

let test_part1 () = Alcotest.(check string) "equals" "150" (Day2.part1 input)

let test_part2 () = Alcotest.(check string) "equals" "900" (Day2.part2 input)

let () =
  let open Alcotest in
  run "Day 2"
    [
      ("Part 1", [ test_case "Check" `Quick test_part1 ]);
      ("Part 2", [ test_case "Check" `Quick test_part2 ]);
    ]
