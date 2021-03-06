-module(hof).
-export([add/1,times/1,compose/2,id/1,iterate/1,multicompose/1]).

add(X) ->
    fun(Y) -> X+Y end.

times(X) ->
    fun(Y) ->
	     X*Y end.
         
compose(F,G) ->
    fun(X) -> G(F(X)) end.

multicompose(Fs) ->
    lists:foldl(fun compose/2, fun id/1, Fs).

id(X) ->
    X.

iterate(0) ->
    dummy;
iterate(N) ->
    dummy.
      
	     