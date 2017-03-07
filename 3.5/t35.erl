-module(t35).
-export([doubleAll/1,evens/1,product/1,zip/2,zip_with/3,zip_with_r/3,zip_r/2]).

doubleAll(Xs) ->
    lists:map(fun double/1,Xs).

double(X) -> 2*X.

evens(Xs) ->
    lists:filter(fun isEven/1,Xs).

isEven(X) -> X rem 2 == 0.

product(Xs) ->
    lists:foldl(fun mult/2,1,Xs).

mult(X,Y) -> X*Y.

zip(_Xs,[]) ->
    [];
zip([],_Ys) ->
    [];
zip([X|Xs],[Y|Ys]) ->
    [{X,Y}|zip(Xs,Ys)].

zip_with(_,_Xs,[]) ->
    [];
zip_with(_,[],_Ys) ->
    [];
zip_with(F,[X|Xs],[Y|Ys]) ->
    [F(X,Y)|zip_with(F,Xs,Ys)].

zip_with_r(F,Xs,Ys) -> 
    lists:map(fun({X,Y})->F(X,Y) end,zip(Xs,Ys)).

zip_r(Xs,Ys) -> 
    zip_with(fun(X,Y)->{X,Y} end,Xs,Ys).