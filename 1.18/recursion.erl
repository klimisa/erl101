-module(recursion).
-export([fac/1,fib/1,pieces/1,fibxy/3,fib_tail/1, perfect/1, fib1/1]).

fac(0)->
    1;
fac(N) when N>0 ->
    fac(N-1)*N.

fib(X) when X <2 ->
    1;
fib(X) ->
fib(X-1) + fib(X-2).

pieces(0)-> 1;
pieces(N)->
    N+pieces(N-1).

fib_tail(N) when N > 0 ->
    fibxy(0,1,N).

fibxy(X,Y,Z) when Z=<2 ->
    X+Y;  
fibxy(X,Y,Z) ->
    fibxy(Y,X+Y,Z-1).


perfect(X) when X > 0 ->
   perfect(0,X,1).

perfect(ACC,X,C) when C >= X ->
    ACC==X;
perfect(ACC,X,C) when X rem C == 0 ->
    perfect(ACC+C, X, C+1);
perfect(ACC,X,C) when X rem C =/= 0 ->
    perfect(ACC, X, C+1).

fibP(0) ->
    {0,1};
fibP(N) ->
    {P,C} = fibP(N-1),
    {C,P+C}.

fib1(N) ->
    {P,_} = fibP(N),
    P.
