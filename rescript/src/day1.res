@module("fs") external readFileSync: (string, string) => string = "readFileSync"
@module("path") external resolve: (string) => string = "resolve"

let input = readFileSync(resolve("./src/day1.input.txt"), "utf-8")

type accumulator = {
  answer: int,
  beforeDepth: option<int>,
}

let answer = input
  -> Js.String.trim
  -> Js.String.split("\n", _)
  -> Js.Array.map(Belt.Int.fromString, _)
  -> Js.Array.reducei(({ answer, beforeDepth }, nowDepth, i) => {
    if i == 0 {
      {
        answer,
        beforeDepth: nowDepth,
      }
    } else if beforeDepth >= nowDepth {
      {
        answer,
        beforeDepth: nowDepth,
      }
    } else {
      {
        answer: answer + 1,
        beforeDepth: nowDepth,
      }
    }
  }, {
    answer: 0,
    beforeDepth: Js.Option.some(-1),
  }, _)
  -> (acc) => acc.answer

Js.log(answer)
