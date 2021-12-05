let test_input =
  "00100\n\
   11110\n\
   10110\n\
   10111\n\
   10101\n\
   01111\n\
   00111\n\
   11100\n\
   10000\n\
   11001\n\
   00010\n\
   01010"

exception Invalid_input

type bit = On | Off

let parse input =
  input |> String.split_on_char '\n' |> List.map String.to_seq
  |> List.map
       (Seq.map (function '0' -> Off | '1' -> On | _ -> raise Invalid_input))
  |> List.map Array.of_seq

let part1 input =
  let input = parse input in
  let diagnostic =
    let len = input |> List.hd |> Array.length in
    input
    |> List.fold_left
         (Array.map2 (fun (on, off) bit ->
              match bit with On -> (on + 1, off) | Off -> (on, off + 1)))
         (Array.make len (0, 0))
  in
  let count diagnostic f =
    let bits = diagnostic |> Array.map f |> Array.to_seq |> String.of_seq in
    Scanf.sscanf ("0b" ^ bits) "%i" (fun x -> x)
  in
  let gamma_rate (on, off) = if off < on then '1' else '0' in
  let epsilon_rate (on, off) = if off < on then '0' else '1' in
  count diagnostic gamma_rate * count diagnostic epsilon_rate |> string_of_int

let%expect_test "part1" =
  print_string (part1 test_input);
  [%expect {| 198 |}]
