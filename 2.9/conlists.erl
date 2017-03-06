-module(conlists).
-export([double/1,test_double/0
        ,evens/1,test_evens/0
        ,median/1,test_median/0
        ,modes/1,test_modes/0
        ,count/2,test_count/0
    ]).

% Double
double([]) ->
    [];
double([X|Xs]) ->
   [(X*2)|double(Xs)].

test_double() ->
    [2,4,6] = double([1,2,3]).

% Evens
evens([]) ->
    [];
evens([X|Xs]) when X > 0 ->
    case X rem 2 of
        0 -> evens(Xs);
        _ -> [X|evens(Xs)]
    end.

test_evens() ->
    [1,3,5] = evens([1,2,3,4,5,6]).

% Median
median([X]) ->
    X;
median(L) ->
    S = lists:sort(L),
    Ln = length(L),
    case Ln rem 2 of
        0 -> lists:nth((Ln div 2),S);
        _ -> lists:nth((Ln div 2)+1,S)
    end.

test_median() ->
    1 = median([1]),
    1 = median([1,2]),
    2 = median([1,2,3]).

% Modes
modes([]) ->
    [];
modes([X|Xs]) ->
    Cx = count(X,Xs) + 1, % Count elements of X within List
    Ys = lists:delete(X,Xs), % Delete X elements
    Fx = [Cx|modes(Ys)], % Built list of counts.
    Px = fun(A)->A==lists:max(Fx) end,
    lists:filter(Px,Fx). % Return the max counts

test_modes() ->
   [] = modes([]),
   [1] = modes([2]),
   [2] = modes([1,1]),
   [2] = modes([1,1,2,3]),
   [2,2] = modes([1,1,2,2,3]).

% Helper
count(_, []) -> 0;
count(X, [X|XS]) -> 1 + count(X, XS);
count(X, [_|XS]) -> count(X, XS). 

test_count() ->
    0 = count(1,[]),
    0 = count(1,[2,3]),
    2 = count(1,[1,1,2,3]).