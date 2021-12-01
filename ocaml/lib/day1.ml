open Core

let parse input =
  input |> String.split_on_chars ~on:[ '\n' ] |> List.map ~f:int_of_string

let count_of_increase elems =
  let count acc curr =
    let acc, prev = acc in
    if prev = -1 then (acc, curr)
    else if prev < curr then (acc + 1, curr)
    else (acc, curr)
  in
  elems |> List.fold ~f:count ~init:(0, -1) |> fst

let part1 input = parse input |> count_of_increase |> string_of_int

let part2 input =
  let window elems =
    let slice elems =
      match List.take elems 3 with _ :: _ :: _ as xs -> xs | _ -> []
    in
    elems
    |> List.mapi ~f:(fun i _ -> List.drop elems i)
    |> List.map ~f:slice
    |> List.map ~f:(List.fold ~init:0 ~f:( + ))
  in
  parse input |> window |> count_of_increase |> string_of_int
