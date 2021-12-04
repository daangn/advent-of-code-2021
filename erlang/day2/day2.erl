%%%-------------------------------------------------------------------
%%% @author jinwoo
%%% @copyright (C) 2021, daangn.com
%%% @doc
%%%
%%% @end
%%% Created : 05. 12월 2021 12:36 AM
%%%-------------------------------------------------------------------
-module(day2).
-author("jinwoo").

%% API
-export([main/0, input/1]).

main() ->
    Data = input([]),
    dive(0, 0, Data).

dive(X, Y, Log) ->
    case length(Log) of
        0 -> X * Y;
        _ ->
            [Head | Tail] = Log,
            [Command | Value] = string:split(Head, " "),
            Int = list_to_integer(lists:nth(1,Value)),
            case Command of
                "forward" -> dive(X + Int, Y, Tail);
                "up" -> dive(X, Y - Int, Tail);
                "down" -> dive(X, Y + Int, Tail)
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