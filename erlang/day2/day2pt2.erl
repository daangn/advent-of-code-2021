%%%-------------------------------------------------------------------
%%% @author jinwoo
%%% @copyright (C) 2021, daangn.com
%%% @doc
%%%
%%% @end
%%% Created : 05. 12월 2021 1:13 AM
%%%-------------------------------------------------------------------
-module(day2pt2).
-author("jinwoo").

%% API
-export([main/0]).
main() ->
    Data = input([]),
    dive(0, 0, 0, Data).

dive(X, Y, Aim, Log) ->
    case length(Log) of
        0 -> X * Y;
        _ ->
            [Head | Tail] = Log,
            [Command | V] = string:split(Head, " "),
            Value = list_to_integer(lists:nth(1, V)),
            case Command of
                "forward" -> dive(X + Value, Y + (Aim * Value), Aim, Tail);
                "up" -> dive(X, Y, Aim - Value, Tail);
                "down" -> dive(X, Y, Aim + Value, Tail)
            end
    end.



input(Acc) ->
    WithNewLine = io:get_line(""),
    WithOutNewLine = lists:sublist(WithNewLine, length(WithNewLine) - 1),
    case length(WithOutNewLine) of
        0 -> Acc;
        _ ->
            input(Acc ++ [WithOutNewLine])
    end.