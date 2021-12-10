module Token = struct
  let digit = function '0' .. '9' -> true | _ -> false

  let ws = function ' ' | '\t' -> true | _ -> false
end

module Parser = struct
  open Angstrom

  let digit = take_while1 Token.digit >>| int_of_string

  let ws = skip_while Token.ws

  let lex x = x <* ws

  let space = char ' '

  let newline = char '\n'

  let comma = char ','
end
