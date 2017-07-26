%% Pair programming session with Lukasz Mainka (https://github.com/lkmain)

-module(hanoi).
-export([solve/1,solve_demo/1]).

solve(N) when N > 0 ->
    solve(N,1,2,3),
    ok.

solve(N,From,_,To) when N == 1 ->
    io:format("~p -> ~p~n",[From,To]);
solve(N,From,Using,To) ->
    solve(N-1,From,To,Using),
    solve(1,From,Using,To),
    solve(N-1,Using,From,To).

solve_demo(N) when N > 0 ->
    Tower = [lists:seq(1,N),[],[]],
    io:format("~p~n", [Tower]),
    solve_demo(N,1,2,3,Tower),
    ok.

solve_demo(N,From,Using,To,Tower) when N == 1 ->
    [FromPileH|FromPileT] = lists:nth(From,Tower),
    UsingPile = lists:nth(Using,Tower),
    ToPile = lists:nth(To,Tower),
    NewFromPile = FromPileT,
    NewToPile = [FromPileH|ToPile],
    NewPiles = lists:sort([{From,NewFromPile},
                           {Using,UsingPile},
                           {To,NewToPile}]),
    NewTower = [X || {_,X} <- NewPiles],
    io:format("~p~n", [NewTower]),
    NewTower;
solve_demo(N,From,Using,To,Towers) ->
    Step1 = solve_demo(N-1,From,To,Using,Towers),
    Step2 = solve_demo(1,From,Using,To,Step1),
    solve_demo(N-1,Using,From,To,Step2).

