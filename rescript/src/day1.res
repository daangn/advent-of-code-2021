@module("fs") external readFileSync: (string, string) => string = "readFileSync"
@module("path") external resolve: (string) => string = "resolve"

Js.log("Advent of Code - ReScript - Day 1")

let input = readFileSync(resolve("./src/day1.input.txt"), "utf-8")

/**
 * PART 1
 */
type part1Acc = {
  answer: int,
  beforeDepth: option<int>,
}

let parseInput = (input) => 
  input
    -> Js.String.trim
    -> Js.String.split("\n", _)
    -> Js.Array.map(Belt.Int.fromString, _)

let part1Answer =
  input
  -> parseInput
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

Js.log("- Part 1 Answer: " ++ Js.Int.toString(part1Answer))

/**
 * PART 2
 */
let depths = input -> parseInput

let part2Answer = Js.Array.reduce((answer, i) => {
  let one = Js.Option.getWithDefault(0, depths[i])
  let two = Js.Option.getWithDefault(0, depths[i+1])
  let three = Js.Option.getWithDefault(0, depths[i+2])
  let four = Js.Option.getWithDefault(0, depths[i+3])

  if one + two + three < two + three + four {
    answer + 1
  } else {
    answer
  }
}, 0, Belt.Array.range(0, Js.Array.length(depths) - 4))

Js.log("- Part 2 Answer: " ++ Js.Int.toString(part2Answer))
