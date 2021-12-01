type input = int list

let parse input = input |> String.split_on_char '\n' |> List.map int_of_string

let solution1 input =
  let input = parse input in
  let count acc curr =
    let acc, prev = acc in
    if prev == -1 then (acc, curr)
    else if prev < curr then (acc + 1, curr)
    else (acc, curr)
  in
  input |> List.fold_left count (0, -1) |> fst |> string_of_int
