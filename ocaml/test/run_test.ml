let test_day1_challenge1 () =
  let input = "199
200
208
210
200
207
240
269
260
263"
  in
  let answer = Lib.Day1.solution1 input in
  Alcotest.(check int) "equals" answer 7

let () =
  let open Alcotest in
  run "Aoc"
    [
      ( "Day 1",
        [
          test_case "Challenge 1" `Quick test_day1_challenge1;
        ] );
    ]
