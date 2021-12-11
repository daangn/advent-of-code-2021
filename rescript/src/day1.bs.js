// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Fs from "fs";
import * as Path from "path";
import * as Belt_Int from "rescript/lib/es6/belt_Int.js";
import * as Caml_obj from "rescript/lib/es6/caml_obj.js";
import * as Js_option from "rescript/lib/es6/js_option.js";

var input = Fs.readFileSync(Path.resolve("./src/day1.input.txt"), "utf-8");

var __x = input.trim().split("\n");

var __x$1 = __x.map(Belt_Int.fromString);

var answer = __x$1.reduce((function (param, nowDepth, i) {
        var answer = param.answer;
        if (i === 0 || Caml_obj.caml_greaterequal(param.beforeDepth, nowDepth)) {
          return {
                  answer: answer,
                  beforeDepth: nowDepth
                };
        } else {
          return {
                  answer: answer + 1 | 0,
                  beforeDepth: nowDepth
                };
        }
      }), {
      answer: 0,
      beforeDepth: Js_option.some(-1)
    }).answer;

console.log(answer);

export {
  input ,
  answer ,
  
}
/* input Not a pure module */
