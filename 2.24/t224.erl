-module(t224).
-export([t1test/0,t2test/0,t3test/0,t4test/0,square/2,merge/2,foo/2,bar/2,baz/1]).

t1(A,B) -> (not(A) or not(B)).
t2(A,B) -> not(A and B).
t3(A,B) -> not(A andalso B).
t4(A,B) -> (not(A) and B) or (not(B) and A).

t1test() ->
    true = t1(false,false),
    true = t1(false,true),
    true = t1(true,false),
    false = t1(true,true),
    ok.

t2test() ->
    true = t2(false,false),
    true = t2(false,true),
    true = t2(true,false),
    false = t2(true,true),
    ok.

t3test() ->
    true = t3(false,false),
    true = t3(false,true),
    true = t3(true,false),
    false = t3(true,true),
    ok.

t4test() ->
    true = t4(false,false),
    true = t4(false,true),
    true = t4(true,false),
    false = t4(true,true),
    ok.


square(X,Y) ->
    false;
square(X,X) ->
    true.

merge([],Ys) -> Ys;
merge(Xs,[]) -> Xs;
merge([X|Xs],[Y|Ys]) when X<Y ->
    [ X | merge(Xs,[Y|Ys]) ];
merge([X|Xs],[Y|Ys]) when X>Y ->
    [ Y | merge([X|Xs],Ys) ];
merge([X|Xs],[Y|Ys]) ->
    [ X | merge(Xs,Ys) ].

foo(_,[])              -> [];
foo(Y,[X|_]) when X==Y -> [X];
foo(Y,[X|Xs])          -> [X | foo(Y,Xs) ].

bar (N, [N]) ->
	[];
bar (_N, [Y]) ->
 	[Y];
bar (N, [Y|Ys]) when N =/= Y ->
	[Y|bar(N, Ys)];
bar (_N, [_Y|Ys]) ->
	Ys.

baz([])     -> [];
baz([X|Xs]) -> [X | baz(zab(X,Xs))].

zab(_N,[])     -> [];
zab(N,[N|Xs]) -> zab(N,Xs);
zab(N,[X|Xs]) -> [X | zab(N,Xs)].
