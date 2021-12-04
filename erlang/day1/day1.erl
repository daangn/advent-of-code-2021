%%%-------------------------------------------------------------------
%%% @author jinwoo
%%% @copyright (C) 2021, daangn.com
%%% @doc
%%%
%%% @end
%%% Created : 01. 12월 2021 9:49 PM
%%%-------------------------------------------------------------------
-module(day1).
-author("jinwoo").

%% API
-export([main/0]).
-export([input/1]).

main() ->
    Input = input([]),
    count([9876543321 | Input], 0).

count(List, Count) ->
    if
        length(List) == 1 ->
            Count;
        true ->
            case lists:nth(2, List) >= lists:nth(1, List) of
                true -> count(lists:sublist(List, 2, length(List)), Count + 1);
                _ -> count(lists:sublist(List, 2, length(List)), Count)
            end
    end.

input(Acc) ->
    WithNewLine = io:get_line(""),
    WithOutNewLine = lists:sublist(WithNewLine, length(WithNewLine) - 1),
    case length(WithOutNewLine) of
        0 -> Acc;
        _ ->
            ConvertToInt = list_to_integer(WithOutNewLine),
            input(Acc ++ [ConvertToInt])
    end.


