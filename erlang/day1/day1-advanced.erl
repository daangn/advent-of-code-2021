%%%-------------------------------------------------------------------
%%% @author jinwoo
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 12월 2021 10:56 PM
%%%-------------------------------------------------------------------
-module('day1-advanced').
-author("jinwoo").

%% API
-export([main/0]).
main() ->
    Input = input([]),
    count([9876543321, 987654321, 987654321] ++ Input, 0, 3).

count(List, Count, Size) ->
    Before = lists:sublist(List, 1, Size),
    After = lists:sublist(List, 2, Size),
    if
        length(List) == Size ->
            Count;
        true ->
            case lists:sum(After) > lists:sum(Before) of
                true -> count(lists:sublist(List, 2, length(List)), Count + 1, Size);
                false -> count(lists:sublist(List, 2, length(List)), Count, Size)
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

