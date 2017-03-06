-module(e213).
-export([nub/1,nub_test/0
]).

-spec nub([T])->[T].
nub([]) ->
    [];
nub([X|Xs]) ->
    [X|nub(removeAll(X,Xs))].

removeAll(_,[]) ->
    [];
removeAll(X,[X|Xs]) ->
    removeAll(X,Xs);
removeAll(X,[Y|Xs]) ->
    [Y|removeAll(X,Xs)].

 nub_test() ->
    []          = nub([]),
    [2,4,1,3]   = nub([2,4,1,3,3,1]),
    ok.
