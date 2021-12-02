let parse input = input |> String.split_on_char '\n' |> List.map int_of_string

let count elems =
  let rec count_increases acc elems =
    match elems with
    | a :: b :: tail ->
        let acc = if a < b then acc + 1 else acc in
        b :: tail |> count_increases acc
    | _ -> acc
  in
  elems |> count_increases 0

let part1 input = parse input |> count |> string_of_int

let part2 input =
  let window elems =
    let rec sum_triples acc elems =
      match elems with
      | a :: b :: c :: tail ->
          b :: c :: tail |> sum_triples (acc @ [ a + b + c ])
      | _ -> acc
    in
    elems |> sum_triples []
  in
  parse input |> window |> count |> string_of_int
