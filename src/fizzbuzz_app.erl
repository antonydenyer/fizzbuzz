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

compute_until(Max) ->
    [{Number, compute(Number)} || Number <- lists:seq(0, Max)].

print_until(Max) ->
    FizzBuzz = compute_until(Max),
    lists:map(fun(X) ->  io:format("~p is ~p ~n", tuple_to_list(X)) end,FizzBuzz),
    ok.

compute(Number) when Number rem 15 =:= 0 ->
    "FizzBuzz";
compute(Number) when Number rem 5 =:= 0 ->
    "Buzz";
compute(Number) when Number rem 3 =:= 0 ->
    "Fizz";
compute(Number) ->
    integer_to_list(Number).

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
