-module(fizzbuzz_app).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, compute_until/1, print_until/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    error_logger:info_msg("Starting app(dev)..~n"),
    fizzbuzz_sup:start_link().


stop(_State) ->
    ok.

compute_until(_number) ->
    [{Number, compute(Number)} || Number <- lists:seq(0, _number)].

print_until(_number) ->
    FizzBuzz = compute_until(_number),
    lists:map(fun(X) ->  io:format("~p is ~p ~n", tuple_to_list(X)) end,FizzBuzz),
    ok.

compute(_number) when _number rem 15 =:= 0 ->
    "FizzBuzz";
compute(_number) when _number rem 5 =:= 0 ->
    "Buzz";
compute(_number) when _number rem 3 =:= 0 ->
    "Fizz";
compute(_number) ->
    integer_to_list(_number).

-ifdef(TEST).

simple_test() ->
ok = application:start(fizzbuzz),
    ?assertNot(undefined == whereis(fizzbuzz_sup)).

one_should_return_one_test() ->
    ?assertEqual("1", compute(1)).

three_should_return_Fizz_test() ->
    ?assertEqual("Fizz", compute(3)).

five_should_return_Buzz_test() ->
    ?assertEqual("Buzz", compute(5)).

fifteen_should_return_FizzBuzz_test() ->
    ?assertEqual("FizzBuzz", compute(15)).

-endif.
