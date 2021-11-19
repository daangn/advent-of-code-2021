let test_greet_name name () =
  let greeting = Lib.Greeter.greet name in
  let expected = "Hello, " ^ name ^ "!" in
  Alcotest.(check string) "equals" greeting expected

let () =
  let open Alcotest in
  run "Aoc"
    [
      ( "Greet",
        [
          test_case "Advent of Code 2021" `Quick
            (test_greet_name "Advent of Code 2021");
          test_case "OCaml" `Quick (test_greet_name "OCaml");
        ] );
    ]
