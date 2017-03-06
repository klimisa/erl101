-module(e211).
-export([take/2,take_test/0
]).

-spec take(integer(),[T])->[T].
take(0,_)  ->
    [];
take(_,[])  ->
    [];    
take(N,[X|Xs]) when N > 0 ->
    [X|take(N-1,Xs)].

take_test() ->
    []      = take(0,"Hello"),
    "Hell"  = take(4,"Hello"),
    "Hello" = take(5,"Hello"),
    "Hello" = take(9,"Hello"),
    ok.

