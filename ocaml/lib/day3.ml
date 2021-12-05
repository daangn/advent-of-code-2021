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

let bits_to_dec bits =
  let bits =
    bits
    |> Array.map (function Off -> '0' | On -> '1')
    |> Array.to_seq |> String.of_seq
  in
  Scanf.sscanf ("0b" ^ bits) "%i" (fun x -> x)

let diagnostic input =
  let len = input |> List.hd |> Array.length in
  input
  |> List.fold_left
       (Array.map2 (fun (on, off) bit ->
            match bit with On -> (on + 1, off) | Off -> (on, off + 1)))
       (Array.make len (0, 0))

let part1 input =
  let diagnostic = parse input |> diagnostic in
  let collect f =
    diagnostic |> Array.map f
    |> Array.map (function true -> On | false -> Off)
    |> bits_to_dec
  in
  let gamma_rate (on, off) = off <= on in
  let epsilon_rate (on, off) = off > on in
  collect gamma_rate * collect epsilon_rate |> string_of_int

let%expect_test "part1" =
  print_string (part1 test_input);
  [%expect {| 198 |}]

let part2 input =
  let input = parse input in
  let collect f =
    let rec collect lst cursor =
      let diagnostic = diagnostic lst in
      let on, off = Array.get diagnostic cursor in
      match
        lst
        |> List.filter (fun arr ->
               let bit = Array.get arr cursor in
               f bit (on, off))
      with
      | [ rating ] -> rating
      | next -> collect next (cursor + 1)
    in
    collect input 0 |> bits_to_dec
  in
  let oxygen_generator_rating bit (on, off) =
    match (bit, off <= on) with
    | On, true | Off, false -> true
    | On, false | Off, true -> false
  in
  let co2_scrubber_rating bit (on, off) =
    match (bit, off > on) with
    | On, true | Off, false -> true
    | On, false | Off, true -> false
  in
  collect oxygen_generator_rating * collect co2_scrubber_rating |> string_of_int

let%expect_test "part2" =
  print_string (part2 test_input);
  [%expect {| 230 |}]
